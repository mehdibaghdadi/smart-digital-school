
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.IO;
using System.Net;
using System.Threading.Tasks;

namespace E_MEDIAHUB.Helpers
{
    using System.Net;
    using System.Text;
    using Microsoft.AspNetCore.Mvc;

    public static class PartialContentHelper
    {
        /// <summary>
        /// Méthode principale pour créer une réponse Partial Content (avec support multi-range).
        /// </summary>
        /// <param name="filePath">Chemin complet du fichier sur le serveur.</param>
        /// <param name="httpContext">Le HttpContext de la requête en cours.</param>
        /// <param name="bufferSizeMb">Taille du buffer en Mo, utilisée lors de la copie de données.</param>
        /// <returns>Une IActionResult représentant la réponse partial content (ou multi-part).</returns>
        public static async Task<IActionResult> CreatePartialResponse(
          string filePath, HttpContext httpContext, int bufferSizeBytes)
        {
            // 1. Vérifier si le fichier existe
            if (!System.IO.File.Exists(filePath))
            {
                return new NotFoundResult();
            }

            long fileSize = new FileInfo(filePath).Length;

            // 2. Lire le header Range
            var rangeHeader = httpContext.Request.Headers["Range"].ToString();

            // 3. Si pas de Range → simuler un Range complet (0 - fileSize-1)
            if (string.IsNullOrEmpty(rangeHeader))
            {
                rangeHeader = $"bytes=0-{fileSize - 1}";
            }

            // 4. Parser les ranges
            var ranges = ParseMultiRange(rangeHeader, fileSize);
            if (ranges == null || ranges.Count == 0)
            {
                return new StatusCodeResult((int)HttpStatusCode.RequestedRangeNotSatisfiable);
            }

            // 5. Single-range
            if (ranges.Count == 1)
            {
                var (start, end) = ranges[0];
                long length = end - start + 1;

                return CreateStreamResponse(filePath, httpContext, start, end, length, fileSize, bufferSizeBytes);
            }
            // 6. Multi-range
            else
            {
                return await CreateMultiRangeResponse(filePath, httpContext, ranges, fileSize, bufferSizeBytes);
            }
        }

        /// <summary>
        /// Gère le cas d'une seule plage (start-end).
        /// </summary>
        private static  FileStreamResult CreateStreamResponse(
            string filePath, HttpContext httpContext, long start, long end, long length, long fileSize, int bufferSizeMb)
        {
            // Configurer les headers manuellement
            httpContext.Response.Headers["Content-Range"] = $"bytes {start}-{end}/{fileSize}";
            httpContext.Response.Headers["Accept-Ranges"] = "bytes";
            httpContext.Response.ContentLength = length;
            httpContext.Response.StatusCode = 206; // Partial Content

            return new FileStreamResult(
                new PartialFileStream(filePath, start, length, bufferSizeMb),
                GetMimeType(filePath));
        }

        /// <summary>
        /// Gère le cas de plusieurs plages (multi-range).
        /// Retourne un Content-Type: multipart/byteranges avec un bloc par range.
        /// </summary>
        // Remplacer toute la méthode CreateMultiRangeResponse
        private static async Task<IActionResult> CreateMultiRangeResponse(
            string filePath, HttpContext httpContext, List<(long start, long end)> ranges, long fileSize, int bufferSizeBytes)
        {
            httpContext.Response.StatusCode = (int)HttpStatusCode.PartialContent;
            string boundary = "MULTIPART_BYTERANGES_" + DateTime.Now.Ticks.ToString("x");
            httpContext.Response.ContentType = $"multipart/byteranges; boundary={boundary}";

            // CORRECTION: Utiliser bufferSizeBytes directement
            int bufferSize = Math.Min(bufferSizeBytes, 65536); // Max 64KB

            await using (var output = httpContext.Response.Body)
            await using (var fileStream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read, bufferSize, FileOptions.Asynchronous | FileOptions.SequentialScan))
            {
                foreach (var (start, end) in ranges)
                {
                    long length = end - start + 1;

                    // Écrire le header du bloc
                    string header = $"--{boundary}\r\nContent-Type: {GetMimeType(filePath)}\r\nContent-Range: bytes {start}-{end}/{fileSize}\r\n\r\n";
                    var headerBytes = Encoding.UTF8.GetBytes(header);
                    await output.WriteAsync(headerBytes);

                    // Écrire la portion du fichier
                    fileStream.Seek(start, SeekOrigin.Begin);
                    long bytesRemaining = length;
                    var buffer = new byte[bufferSize];

                    while (bytesRemaining > 0)
                    {
                        int read = await fileStream.ReadAsync(buffer, 0, (int)Math.Min(buffer.Length, bytesRemaining));
                        if (read == 0) break;

                        await output.WriteAsync(buffer.AsMemory(0, read));
                        bytesRemaining -= read;
                    }

                    // CRLF pour finir ce bloc
                    await output.WriteAsync(Encoding.UTF8.GetBytes("\r\n"));
                }

                // Terminer par le boundary final
                await output.WriteAsync(Encoding.UTF8.GetBytes($"--{boundary}--\r\n"));
            }

            return new EmptyResult();
        }
        /// <summary>
        /// Parse le header "Range: bytes=0-99,200-299" et renvoie une liste de plages (start, end).
        /// </summary>
        private static List<(long start, long end)> ParseMultiRange(string rangeHeader, long fileSize)
        {
            // Attendu : "bytes=0-99,200-299"
            if (!rangeHeader.StartsWith("bytes=", StringComparison.OrdinalIgnoreCase))
                return null;

            string rangeValue = rangeHeader.Substring("bytes=".Length).Trim();
            if (string.IsNullOrEmpty(rangeValue))
                return null;

            var ranges = new List<(long start, long end)>();
            var parts = rangeValue.Split(',');

            foreach (var part in parts)
            {
                var sub = part.Split('-');
                if (sub.Length != 2)
                    continue;

                if (!long.TryParse(sub[0], out long start))
                    start = 0;
                if (!long.TryParse(sub[1], out long end))
                    end = fileSize - 1;

                if (start > end)
                    continue;
                if (start >= fileSize)
                    continue;
                if (end >= fileSize)
                    end = fileSize - 1;

                ranges.Add((start, end));
            }

            if (ranges.Count == 0)
                return null;

            return ranges;
        }

        /// <summary>
        /// Détermine le type MIME en fonction de l'extension du fichier.
        /// </summary>
        private static string GetMimeType(string filePath)
        {
            var mimeType = "application/octet-stream";
            var extension = Path.GetExtension(filePath)?.ToLowerInvariant();

            if (extension == ".mp4") mimeType = "video/mp4";
            else if (extension == ".jpg" || extension == ".jpeg") mimeType = "image/jpeg";
            else if (extension == ".png") mimeType = "image/png";
            else if (extension == ".gif") mimeType = "image/gif";
            else if (extension == ".mp3") mimeType = "audio/mpeg";
            // etc. selon vos besoins

            return mimeType;
        }
    }


}
