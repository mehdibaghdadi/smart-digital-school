//<script src="/static/plugins/pica/pica.min.js"></script>

async function resizeImagePica(file, maxWidth = 800, maxHeight = 800, returnType = 'base64') {
    if (!(file instanceof Blob)) {
        throw new Error("L'entrée doit être un objet Blob ou File.");
    }

    // Création d’un objet Image
    const img = document.createElement('img');
    const url = URL.createObjectURL(file);
    img.src = url;

    await new Promise((resolve, reject) => {
        img.onload = resolve;
        img.onerror = reject;
    });

    // Calcul du ratio de redimensionnement
    let width = img.width;
    let height = img.height;

    if (width > maxWidth || height > maxHeight) {
        const ratio = Math.min(maxWidth / width, maxHeight / height);
        width = Math.round(width * ratio);
        height = Math.round(height * ratio);
    }

    // Création des canvas source et destination
    const srcCanvas = document.createElement('canvas');
    srcCanvas.width = img.width;
    srcCanvas.height = img.height;
    const ctx = srcCanvas.getContext('2d');
    ctx.drawImage(img, 0, 0);

    const destCanvas = document.createElement('canvas');
    destCanvas.width = width;
    destCanvas.height = height;

    // Utilisation de Pica pour redimensionner proprement
    const picaInstance = window.pica({ features: ['js', 'wasm', 'ww'] });

    await picaInstance.resize(srcCanvas, destCanvas, {
        unsharpAmount: 80,
        unsharpRadius: 0.6,
        unsharpThreshold: 2
    });

    URL.revokeObjectURL(url); // Libère la mémoire

    // Retourne le format souhaité
    if (returnType === 'base64') {
        return destCanvas.toDataURL('image/jpeg', 0.7);
    } else if (returnType === 'blob') {
        return await picaInstance.toBlob(destCanvas, 'image/jpeg', 0.7);
    } else {
        throw new Error("Type de retour invalide : utilisez 'base64' ou 'blob'");
    }
}

