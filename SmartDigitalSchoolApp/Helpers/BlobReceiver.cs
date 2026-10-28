using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
#if ANDROID
using Android.Content;
using Android.Webkit;
using Android.Widget;
using Java.Interop;
#endif

namespace SmartDigitalSchoolApp.Helpers
{
#if ANDROID

    public class BlobReceiver : Java.Lang.Object
    {
        private readonly Context? _context;

        public BlobReceiver(Context? context)
        {
            _context = context;
        }

        [JavascriptInterface]
        [Export("postBlob")]
        public bool PostBlob(string base64Data, string fileName)
        {
            try
            {
                if (_context == null)
                {
                    // Afficher un message d'erreur si le contexte est null
                    Android.Util.Log.Error("BlobReceiver", "Le contexte Android est null.");
                    return false;
                }
                Toast.MakeText(_context, "Downloads file ...", ToastLength.Long)?.Show();
                byte[] data = Convert.FromBase64String(base64Data);
                var resolver = _context?.ContentResolver;

                // ✅ Ajout d’un préfixe horodaté unique
                string timestamp = DateTime.Now.ToString("yy.MM.dd.HH.mm.ss");
                string uniqueFileName = $"{timestamp}_{fileName}";

                var contentValues = new ContentValues();
                contentValues.Put(Android.Provider.MediaStore.IMediaColumns.DisplayName, uniqueFileName);
                contentValues.Put(Android.Provider.MediaStore.IMediaColumns.MimeType, GetMimeType(fileName));
                contentValues.Put(Android.Provider.MediaStore.IMediaColumns.RelativePath, Android.OS.Environment.DirectoryDownloads);

                var uri = resolver?.Insert(Android.Provider.MediaStore.Downloads.ExternalContentUri, contentValues);


                if (uri != null)
                {
                    using (var outputStream = resolver?.OpenOutputStream(uri))
                    {
                        outputStream?.Write(data, 0, data.Length);
                        outputStream?.Flush();
                    }

                    Toast.MakeText(_context, $"📥 File saved in Downloads : {fileName}", ToastLength.Long)?.Show();
                }
                else
                {
                    Toast.MakeText(_context, "Error creating file.", ToastLength.Long)?.Show();
                    return false;
                }

                return true;

            }
            catch (Exception ex)
            {
                Toast.MakeText(_context, $"❌ Error : {ex.Message}", ToastLength.Long)?.Show();
                return false;
            }
        }

        private string GetMimeType(string fileName)
        {
            string? ext = Path.GetExtension(fileName)?.ToLowerInvariant();
            return ext switch
            {
                ".pdf" => "application/pdf",
                ".png" => "image/png",
                ".jpg" or ".jpeg" => "image/jpeg",
                ".mp4" => "video/mp4",
                ".mp3" => "audio/mpeg",
                ".zip" => "application/zip",
                _ => "application/octet-stream"
            };
        }
    }

#endif

}
