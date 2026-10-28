using System.Text.RegularExpressions;

namespace E_MEDIAHUB.Helpers
{
    public static class FileManager
    {  

    public static string SecureFilename(string filename)
    {
        // Remplacer les espaces par des underscores
        filename = filename.Replace(" ", "_");

        // Enlever les caractères spéciaux non autorisés pour un nom de fichier
        filename = Regex.Replace(filename, @"[^\w\.-]", "");

        // Assurer que le nom final est valide et n'est pas vide
        if (string.IsNullOrEmpty(filename))
        {
            throw new ArgumentException("Le nom du fichier résultant est vide après le nettoyage.");
        }

        return filename;
    }

  }
}
