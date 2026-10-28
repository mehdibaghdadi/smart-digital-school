using E_MEDIAHUB.Filters;
using E_MEDIAHUB.Helpers;
using E_MEDIAHUB.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using System.IO;
using System.Threading.Tasks;

namespace E_MEDIAHUB.Controllers
{
    [ApiController]
    [Route("api/download-manager")]
    public class DownloadManagerController : ControllerBase
    {
        private readonly string _rootPath;
        private readonly double _previewPercent;
        private readonly int _bufferSizeDownload;

        public DownloadManagerController(IOptions<AppSettings> options)
        {
            // Récupérer la racine des fichiers à partir des options AppSettings
            _rootPath = options.Value.E_DbFilesRoot;
            _previewPercent = options.Value.PreviewPercent;
            _bufferSizeDownload = options.Value.BufferSizeDownload ;
        }

        
        // GET or POST api/download-manager/media/{filename}
        [HttpGet("media/{*filename}")]
        [HttpPost("media/{*filename}")]
        [ServiceFilter(typeof(DownloadValidationFilter))] // Filtre pour valider le téléchargement
        public async Task<IActionResult> Media(string filename)
        {
            try
            {
                var decodedFilename = Uri.UnescapeDataString(filename);
                var filePath = Path.Combine(_rootPath, decodedFilename);
                var bufferSize = _bufferSizeDownload;
                return await PartialContentHelper.CreatePartialResponse(filePath, HttpContext, bufferSize);
            }
            catch (Exception ex)
            {
                return BadRequest($"Erreur de fichier : {ex.Message}");
            }
        }


        // POST api/download-manager/filelink
        [HttpPost("filelink")]
        [ServiceFilter(typeof(DownloadValidationFilter))] // Filtre pour valider le téléchargement
        public IActionResult FileLink([FromBody] FileRequest request)
        {
            try
            {
                var filePath = Path.Combine(_rootPath, request.content_url);
                if (!System.IO.File.Exists(filePath))
                {
                    return BadRequest($"Aucun fichier trouvé : {filePath}");
                }

                return PhysicalFile(filePath, "application/octet-stream", enableRangeProcessing: true);
            }
            catch (Exception ex)
            {
                return BadRequest($"Erreur lors de la récupération du fichier : {ex.Message}");
            }
        }


        // GET api/download-manager/image/{filename}
        [HttpGet("image/{*filename}")]
        public IActionResult GetImage(string filename)
        {
            try
            {
                var filePath = Path.Combine(_rootPath, filename);

                if (!System.IO.File.Exists(filePath))
                {
                    return BadRequest($"Erreur lors de la récupération de l'image : {filePath}");
                }

                return PhysicalFile(filePath, "image/jpeg");
            }
            catch (Exception ex)
            {
                return BadRequest($"Erreur lors de la récupération de l'image : {ex.Message}");
            }
        }
    }
}