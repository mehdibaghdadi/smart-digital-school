
var detectMeetingService = function (url) {
    let hostname;

    // Tente de créer un objet URL pour extraire le hostname
    try {
        hostname = new URL(url).hostname;
    } catch (error) {
        // Si l'URL est invalide, on peut retourner un message d'erreur
        return "invalid URL";
    }

    // Comparaison du hostname avec différents services
    if (hostname.includes("zoom.us")) {
        return "Zoom";
    } else if (hostname.includes("teams.microsoft.com")) {
        return "Microsoft Teams";
    } else if (hostname.includes("meet.google.com")) {
        return "Google Meet";
    } else if (hostname.includes("webex.com")) {
        return "Cisco Webex";
    } else if (hostname.includes("gotomeeting.com")) {
        return "GoToMeeting";
    } else if (hostname.includes("whereby.com")) {
        return "Whereby";
    } else if (hostname.includes("bluejeans.com")) {
        return "BlueJeans";
    }

    // Si aucun match, on peut retourner un texte générique
    return JSR.browse;
}

