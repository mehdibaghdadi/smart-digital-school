using E_MEDIAHUB.Filters;
using E_MEDIAHUB.Helpers;
using E_MEDIAHUB.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using System;
using System.IO;
using System.Threading.Tasks;

namespace E_MEDIAHUB.Controllers
{
    [ApiController]
    [Route("api/upload-manager")]
    public class UploadManagerController : ControllerBase
    {
        private readonly string _rootPath;

        public UploadManagerController(IOptions<AppSettings> options)
        {
            // Récupérer la racine des fichiers à partir des options AppSettings
            _rootPath = options.Value.E_DbFilesRoot;
        }
        // PUT api/upload-manager/upload/{rootPath}/{filename}/delete/{oldPathFile}
        [HttpPost("upload/{rootPath}/{filename}/delete/{oldPathFile}")]
        [HttpPost("upload/{rootPath}/{filename}")]
        [ServiceFilter(typeof(DownloadValidationFilter))] // Filtre pour valider le téléchargement
        public async Task<IActionResult> Upload(string rootPath, string filename, string oldPathFile = null)
        {
            try
            {
                if (string.IsNullOrEmpty(filename) || string.IsNullOrEmpty(rootPath))
                {
                    return BadRequest("No selected file");
                }

                filename = Uri.UnescapeDataString(filename);
                rootPath = Uri.UnescapeDataString(rootPath);

                // Construire le chemin pour l'upload
                var fullPath = Path.Combine(_rootPath, rootPath);
                Directory.CreateDirectory(fullPath);

                // Supprimer l'ancien fichier si spécifié
                if (!string.IsNullOrEmpty(oldPathFile))
                {
                    oldPathFile = Uri.UnescapeDataString(oldPathFile);
                    var oldFilePath = Path.Combine(_rootPath, oldPathFile);
                    if (System.IO.File.Exists(oldFilePath))
                    {
                        System.IO.File.Delete(oldFilePath);
                    }
                }

                // Conserver le nom du fichier et son extension
                var fileNameWithoutExtension = Path.GetFileNameWithoutExtension(filename);
                fileNameWithoutExtension = FileManager.SecureFilename(fileNameWithoutExtension);
                var fileExtension = Path.GetExtension(filename);

                // Ajouter un horodatage au nom du fichier tout en conservant l'extension
                var timestamp = DateTime.Now.ToString(".dd.MM.yyyy.HH.mm.ss");
                var newFileName = $"{fileNameWithoutExtension}{timestamp}{fileExtension}";
                var fileFullPath = Path.Combine(fullPath, newFileName);
                var pathFile = $"{rootPath}/{newFileName}";

                // Lecture du corps de la requête en utilisant un FileStream de manière asynchrone
                using (var uploadStream = new FileStream(fileFullPath, FileMode.Create, FileAccess.Write))
                {
                    var buffer = new byte[10240]; // 10KB buffer
                    int bytesRead;
                    long totalBytesRead = 0;
                    long contentLength = Request.ContentLength ?? 0;

                    // Lire en chunks jusqu'à la fin de la requête
                    while ((bytesRead = await Request.Body.ReadAsync(buffer, 0, buffer.Length)) > 0)
                    {
                        await uploadStream.WriteAsync(buffer, 0, bytesRead);
                        totalBytesRead += bytesRead;

                        // Optionnel : Ajout d'une vérification si nécessaire
                        if (contentLength > 0 && totalBytesRead > contentLength)
                        {
                            return BadRequest("La taille des données reçues dépasse la taille spécifiée dans Content-Length.");
                        }
                    }

                    // Vérifier si la totalité des données a été lue
                    if (contentLength > 0 && totalBytesRead != contentLength)
                    {
                        return BadRequest("Erreur lors de la lecture des données du fichier. La taille lue ne correspond pas à la taille attendue.");
                    }
                }

                // Retourner la réponse avec succès
                return Ok(new { file = pathFile });
            }
            catch (Exception ex)
            {
                return BadRequest($"Upload Error: {ex.Message}");
            }
        }

        // POST api/upload-manager/delete
        [HttpPost("delete")]
        [ServiceFilter(typeof(DownloadValidationFilter))] // Filtre pour valider le téléchargement
        public IActionResult Delete([FromBody] FileRequest request)
        {
            try
            {
                var pathFile = request.content_url;
                if (string.IsNullOrEmpty(pathFile))
                {
                    return BadRequest("No selected file");
                }

                // Construire le chemin complet du fichier
                var fullPath = Path.Combine(_rootPath, pathFile);
                if (System.IO.File.Exists(fullPath))
                {
                    System.IO.File.Delete(fullPath);
                }
                else
                {
                    return BadRequest("Aucun fichier à supprimer.");
                }

                return Ok(new { file = pathFile });
            }
            catch (Exception ex)
            {
                return BadRequest($"Delete Error: {ex.Message}");
            }
        }
    }
}
