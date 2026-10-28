@ECHO OFF
:: 1. Se déplacer sur le bon disque et dossier
D:
CD "D:\SMART_DIGITAL_SCHOOL\E_LEARNING\E_WEBSITE_UI\dist"

:: 2. Utiliser le chemin complet vers npx (tapez 'where npx' pour le trouver)
:: On utilise aussi "call" pour s'assurer que le script continue
CALL "C:\Program Files\nodejs\npx.cmd" "C:\Users\eware\AppData\Roaming\npm\node_modules\serve\build\main.js" -s . -l 5010
