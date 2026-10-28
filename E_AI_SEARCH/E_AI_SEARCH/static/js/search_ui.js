// static/js/search_ui.js
// Interface de recherche E_AI_SEARCH
// - utilise DOMPurify pour nettoyer le HTML (protection XSS)
// - effectue un highlight des mots recherchés
// - affiche les résultats renvoyés par /search

// helper: escape HTML (fallback, on préfère DOMPurify)
function escapeHtml(unsafe) {
    if (!unsafe) return '';
    return unsafe
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}

// sanitize using DOMPurify (if present)
function sanitizeHtml(dirty, allowedTags = ['b', 'i', 'em', 'strong', 'a', 'mark']) {
    if (typeof DOMPurify === 'undefined') {
        // fallback: escape everything
        return escapeHtml(dirty);
    }
    // configure allowed tags and attributes
    return DOMPurify.sanitize(dirty, {
        ALLOWED_TAGS: allowedTags,
        ALLOWED_ATTR: ['href', 'target', 'rel'] // allow links safe attrs
    });
}

// highlight query terms in sanitized HTML
function highlightText(safeHtml, query) {
    if (!query || !query.trim()) return safeHtml;
    // build list of words, deduplicate
    const words = Array.from(new Set(query.split(/\s+/).filter(Boolean)));
    if (words.length === 0) return safeHtml;

    // Escape regex chars in words
    const pattern = words.map(w => w.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')).join('|');
    const re = new RegExp(`(${pattern})`, 'ig');

    // Replace matches by <mark>...</mark>
    // We operate on text nodes; but since we have safeHtml already, we'll do a string replace
    // then sanitize again to avoid accidental injection
    const replaced = safeHtml.replace(re, '<mark>$1</mark>');

    // sanitize final HTML (allow <mark> + existing allowed tags)
    return sanitizeHtml(replaced, ['b', 'i', 'em', 'strong', 'a', 'mark']);
}

async function doSearch() {
    const status = document.getElementById('status');
    const resultsDiv = document.getElementById('results');
    resultsDiv.innerHTML = '';
    status.textContent = 'Recherche en cours…';

    const query = document.getElementById('query').value.trim();
    const k = parseInt(document.getElementById('k').value) || 5;
    const apiKey = document.getElementById('apiKey').value.trim();

    if (!query) {
        status.textContent = 'Entrez une requête.';
        return;
    }

    try {
        const body = { query: query, k: k };
        const headers = { 'Content-Type': 'application/json' };
        if (apiKey) headers['X-API-KEY'] = apiKey;

        const resp = await fetch('/search', {
            method: 'POST',
            headers: headers,
            body: JSON.stringify(body)
        });

        if (!resp.ok) {
            const text = await resp.text();
            status.textContent = `Erreur serveur: ${resp.status} - ${text}`;
            return;
        }

        const json = await resp.json();
        status.textContent = `Résultats : ${json.results ? json.results.length : 0}`;

        if (!json.results || json.results.length === 0) {
            resultsDiv.innerHTML = '<p>Aucun résultat.</p>';
            return;
        }

        const list = document.createElement('div');
        list.className = 'list';

        json.results.forEach(r => {
            const item = document.createElement('div');
            item.className = 'item';

            const score = document.createElement('div');
            score.className = 'score';
            score.textContent = `score: ${r.score.toFixed(4)}`;

            const title = document.createElement('div');
            title.className = 'title';
            title.textContent = `content_id: ${r.content_id}`;

            const snippet = document.createElement('div');
            snippet.className = 'snippet';

            // Snippet: sanitize then highlight
            const rawSnippet = r.snippet || '';
            // sanitize the raw snippet (allow a few tags)
            const safe = sanitizeHtml(rawSnippet, ['b', 'i', 'em', 'strong', 'a', 'mark']);
            // highlight query terms inside the safe html
            /*const highlighted = highlightText(safe, query);
            snippet.innerHTML = highlighted;*/
            snippet.innerHTML = safe;

            const vid = document.createElement('div');
            vid.className = 'meta';
            vid.textContent = `vector_id: ${r.vector_id} — chunk: ${r.chunk}`;

            // Link to open content (adapt to your E_LEARNING path)
            const openBtn = document.createElement('a');
            openBtn.href = `/content/${r.content_id}`; // adapte si nécessaire
            openBtn.target = "_blank";
            openBtn.textContent = 'Ouvrir le contenu';
            openBtn.className = 'openBtn';

            item.appendChild(score);
            item.appendChild(title);
            item.appendChild(snippet);
            item.appendChild(vid);
            item.appendChild(openBtn);

            list.appendChild(item);
        });

        resultsDiv.appendChild(list);

    } catch (err) {
        console.error(err);
        status.textContent = 'Erreur: ' + err.toString();
    }
}

document.getElementById('searchBtn').addEventListener('click', doSearch);
document.getElementById('clearBtn').addEventListener('click', () => {
    document.getElementById('query').value = '';
    document.getElementById('results').innerHTML = '';
    document.getElementById('status').textContent = '';
});
