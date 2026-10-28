
var getCurentLanguage = function () {
    switch (JSR.current_language) {
        case "fr": return "french"; break;
        case "en": return "english"; break;
        case "es": return "spanish"; break;
        default: return "french";
    }
    }

var initForm = {
    title: "Analyse spectrale et décomposition fonctionnelle des opérateurs linéaires.",
    level: "Intermédiaire",
    audience: JSR.students,
    language: getCurentLanguage(),
    duration: "2 heures",
    modules: 3,
    style: "Théorie + exercices",
    include_quiz: "no",
    description: "Analyse spectrale et décomposition fonctionnelle des opérateurs linéaires."
};
var initResult = {
    course_title: "",
    course_summary: "",
    modules: [],
    quizzes: [],
    markdown: "",
    date_build=(new Date()).toLocaleDateString()
};

const AI_MODE_STREAM_CHUNKS_ON = true; // définir le streaming chunks ON par défaut

// course-ai-wizard.js — streaming chunks ON par défaut
app.controller("CourseAIController", ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, settings) {

        const token = document.getElementById("__X_RVT")?.value || window.__X_RVT || "";

        // controller shared for streaming cancellation
        let streamAbortController = null;
        let streamReader = null;
        $scope.form = angular.copy(initForm);
        $scope.form_reset = angular.copy($scope.form);
        $scope.error = "";
        $scope.warnings = "";
        $scope.loading = false;
        $scope.generated = false;
        $scope.result = angular.copy(initResult);
      
        
        (function restoreLocal() {
            try {
                const saved = localStorage.getItem("ai_course_draft");
                if (saved) {
                    $scope.result = JSON.parse(saved);
                    $scope.generated = true;
                    $scope.error = "";
                    var date_build = $scope.result?.date_build || (new Date()).toLocaleDateString();
                    $scope.warnings = `dernière génération : ${date_build}`;
                    safeApply();
                }
            } catch (e) {
                console.warn("LocalStorage load error", e);
            }
        })();
        
        $scope.generate_stream_url = "";
        $scope.generate_url = "";
        $scope.save_draft_url = "";
        $scope.publish_url = "";
        $scope.init = function (aiBase, publish_url) {
            var AI_BASE = aiBase;
            $scope.generate_stream_url = "{0}{1}".format(`${AI_BASE}`, "generate/stream");
            $scope.generate_url = "{0}{1}".format(`${AI_BASE}`, "generate");
            $scope.save_draft_url = "/api/course-ai-manager/save_draft";
            $scope.publish_url = publish_url;
        }
        // CORE : try streaming chunks then fallback to non-stream-chunks
        $scope.generateCourse = async function () {
            $scope.error = "";
            $scope.warnings = "";
            if (!$scope.form.title) {
                $scope.warnings = "Le titre est requis.";
                $scope.$applyAsync?.();
                return;
            }
            if ($scope.form.modules > 30) {
                $scope.warnings = "Génération lourde. Peut prendre du temps.";
            }

            const payload = {
                title: $scope.form.title,
                level: $scope.form.level,
                audience: $scope.form.audience,
                language: $scope.form.language,
                duration: $scope.form.duration,
                modules: Number($scope.form.modules) || 6,
                style: $scope.form.style,
                include_quiz: toBool($scope.form.include_quiz),
                description: $scope.form.description
            };

            $scope.loading = true;
            $scope.generated = false;
            $scope.result = angular.copy(initResult);

            // if STREAM_ON try streaming endpoint
            if (AI_MODE_STREAM_CHUNKS_ON) {
                try {
                    await doStreamChunksGenerate(payload);//streaming
                    $scope.generated = true;
                } catch (e) {
                    console.warn("stream failed, fallback to second generate", e);

                    setTimeout(function () {
                        $scope.generated = false;
                        $scope.error = "";
                        safeApply();
                    }, 100);

                    //------- FALLBACK to sync POST /generate
                    try {
                        await doStreamChunksGenerate(payload);//streaming
                        $scope.generated = true;
                    } catch (err2) {
                        $scope.error = err2.message || "Erreur génération";
                        console.error("second stream failed", err2);
                    }
                } finally {
                    $scope.loading = false;
                    $scope.$applyAsync?.();
                }
                return;
            }

            // else do sync
            try {
                await doSyncGenerate(payload);
                $scope.generated = true;
            } catch (err) {
                console.error("sync failed", err);
                $scope.error = err.message || "Erreur génération";
            } finally {
                $scope.loading = false;
                $scope.$applyAsync?.();
            }
        };

        //-----------------------------------------BEGIN streaming flow using fetch + reader 
        async function doStreamChunksGenerate(payload) {
            console.log("starting SSE-aware stream viewer");

            // create controller and reset previous reader if any
            if (streamAbortController) {
                try { streamAbortController.abort(); } catch (e) { }
            }
            streamAbortController = new AbortController();
            const signal = streamAbortController.signal;

            const res = await fetch($scope.generate_stream_url, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(payload),
                signal // <-- important
            });
            if (!res.ok) {
                const t = await res.text();
                throw new Error("stream error: " + res.status + " " + t);
            }

            const reader = res.body.getReader();
            streamReader = reader; // keep reference for optional cancel
            const decoder = new TextDecoder("utf-8");
            let leftover = "";
            let fullText = "";

            // init result
            $scope.result = angular.copy(initResult);
            $scope.result.markdown = "";
            safeApply();
            console.log("streaming response started");
            try {
                while (true) {
                    const { value, done } = await reader.read();
                    if (done) break;

                    const chunk = leftover + decoder.decode(value, { stream: true });
                    const parts = chunk.split(/\r?\n\r?\n/);
                    leftover = parts.pop();

                    for (const part of parts) {
                        if (!part.trim()) continue;
                        const lines = part.split(/\r?\n/);
                        let dataPiece = "";
                        for (let ln of lines) {
                            if (/^\s*data:/.test(ln)) {
                                dataPiece += ln.replace(/^\s*data:\s?/, "");
                            }
                        }
                        if (!dataPiece.trim() || dataPiece.trim() === "[DONE]") continue;
                        fullText += dataPiece;
                        $scope.result.markdown = beautifyJsonStream(fullText) + ` <i class="fa ml-1 text-xs fa-ew-writing-hand fa-shake"></i>`;
                        safeApply();
                    }
                }

                // flush leftover
                if (leftover && leftover.trim()) {
                    const lines = leftover.split(/\r?\n/);
                    for (let ln of lines) {
                        if (/^\s*data:/.test(ln)) {
                            const piece = ln.replace(/^\s*data:\s?/, "");
                            if (piece && piece.trim() !== "[DONE]") fullText += piece;
                        }
                    }
                    $scope.result.markdown = beautifyJsonStream(fullText);
                    safeApply();
                }

                // try final parse (same as before)
                try {
                    let cleanText = stripCodeFences(fullText);
                    const finalObj = JSON.parse(cleanText);
                    $scope.result = finalObj;
                    $scope.result.modules = $scope.result.modules || [];
                    $scope.result.quizzes = $scope.result.quizzes || [];
                    $scope.result.markdown = "";
                    safeApply();
                    saveToLocal();
                    setTimeout(() => window.SmootScrollViewTopLayout(), 100);
                    console.log("Final JSON parsed successfully");
                } catch (err) {
                    console.warn("Final JSON parse failed — keeping raw stream in markdown");
                    $scope.result.markdown = beautifyJsonStream(fullText);
                    $scope.error = "Le flux généré n'est pas un contenu valide.";
                    throw err;
                    safeApply();
                }
                console.log("SSE stream completed");

            } catch (err) {
                // handle cancellation separately
                if (err.name === "AbortError") {
                    console.log("Generation stopped by user (AbortController).");
                    // optional: cancel reader to free resources
                    try { await reader.cancel(); } catch (_) { }
                    // leave partial result in $scope.result.markdown for user to edit
                    $scope.error = "Génération interrompue par l'utilisateur.";
                } else {
                    var msg = err.message || "Erreur durant le streaming.";
                    console.error("Streaming error:", msg);
                    try { await reader.cancel(); } catch (_) { }

                    $scope.error = msg;
                    throw err; // rethrow to trigger fallback if in streaming mode
                    
                }
                $scope.result.markdown = beautifyJsonStream(fullText);

            } finally {
                // cleanup references and UI state
                streamAbortController = null;
                streamReader = null;
                //console.log($scope.result);
            }
        }

        function stripCodeFences(text) {
            if (!text) return "";

            // Supprimer ```json, ```JSON, ``` et leurs variantes
            text = text.replace(/```json/gi, "");
            text = text.replace(/```/g, "");

            // Nettoyer aussi les balises erronées possibles
            text = text.replace(/`{2,}/g, "");

            // Trim final
            return text.trim();
        }

        function beautifyJsonStream(text) {
            if (!text) return "";

            // première passe de nettoyage général
            text = stripCodeFences(text);
            text = sanitizeFromJson(text);

            // 1. Retirer les préfixes SSE "data:"
            text = text.replace(/^\s*data:\s?/gm, "");

            // 2. Nettoyer les échappements JSON
            text = text.replace(/\\"/g, '"').replace(/\\n/g, '\n');

            // 3. Ajouter un saut de ligne AVANT chaque grande clé JSON
            const keys = [
                'course_title', 'course_summary', 'modules', 'module_title', 'module_description',
                'lessons', 'lesson_summary', 'lesson_content', 'quizzes', 'quiz_name', 'questions', 'time_limit', 'question',
            ];

            var css = "";
            keys.forEach(k => {

                switch (k) {
                    case "course_title":
                        css = "is-course-title";
                        break;
                    case "course_summary":
                        css = "is-course-summary";
                        break;
                    case "modules":
                        css = "is-modules";
                        break;
                        break;
                    case "module_title":
                        css = "is-module-title";
                        break;
                    case "lessons":
                        css = "is-lessons";
                        break;
                    case "lesson_summary":
                        css = "is-lesson-summary";
                        break;
                    case "quizzes":
                        css = "is-quizzes";
                        break;
                    case "quiz_name":
                        css = "is-quiz-name";
                        break;
                    case "time_limit":
                        css = "is-time-limit";
                        break;
                    case "questions":
                        css = "is-questions";
                        break;
                    default:
                        css = "is-default-title";
                }

                // 1) remplacer "key": → <b>key:</b>
                const REG = new RegExp(`"${k}"\\s*:`, "g");
                text = text.replace(
                    REG,
                    `<div class='${css} '>${k}:</div> `
                );

                // 2) enlever les quotes autour de la valeur immédiate si c'est un string
                const regVal = new RegExp(`(<b[^>]*>${k}:<\/b>\\s*)"([^"]*)"`, "g");
                text = text.replace(regVal, `$1$2`);
            });


            // 4. Ajouter un saut de ligne après une virgule suivie d'une autre clé
            text = text.replace(/,\s*"/g, ",\n\"");

            // 5. Réduire multiples espaces
            text = text.replace(/[ ]{2,}/g, " ");

            // 6. Nettoyer lignes trop longues
            text = text.replace(/\n{3,}/g, "\n\n");

            // 7. Indentation légère : ajouter 2 espaces devant chaque sous-élément
            text = text.replace(/\n"(?!(title|summary))/g, "\n  \"");

            return text.trim();
        }

        function sanitizeFromJson(text) {
            if (!text) return "";

            // retirer les prefix SSE "data:"
            text = text.replace(/^\s*data:\s?/gm, "");

            // normaliser indentations JSON (pas de tabs bizarres)
            text = text.replace(/\t+/g, "  ");

            // enlever les retours de ligne multiples
            text = text.replace(/\n{3,}/g, "\n\n");

            // si une accolade ou un tableau est ouvert mais pas fermé,
            // on n'affiche que la partie "texte" intelligible
            const clean = text
                .replace(/[{}[\]]/g, '')         // retirer { } [ ] si ça casse la lisibilité
                .replace(/\\n/g, "\n")           // afficher les vraies lignes
                .replace(/\\"/g, '"')            // nettoyer les escaped quotes
                .trim();

            return clean;
        }

        // Angular scope for stop
        $scope.stopGeneration = function () {
            if (streamAbortController) {
                try { streamAbortController.abort(); } catch (e) { }
            }
            // optional: also cancel reader
            if (streamReader) {
                try { streamReader.cancel(); } catch (e) { }
            }
            $scope.loading = false;
            safeApply();
        };


        //-----------------------------------------END streaming flow using fetch + reader 

        // synchronous fallback
        async function doSyncGenerate(payload) {
            try {
                const resp = await $http.post($scope.generate_url, payload, { headers: { "Content-Type": "application/json" } });
                $scope.result = resp.data || {};
                $scope.result.modules = $scope.result.modules || [];
                $scope.result.quizzes = $scope.result.quizzes || [];
                console.log("stream generate completed");
                console.log($scope.result);
                saveToLocal();
            } catch (err) {
                // normalize error message
                let msg = "Erreur API";
                try { msg = err.data?.detail || err.data?.message || JSON.stringify(err.data) || err.statusText; } catch (e) { }
                throw new Error(msg);
            }
        }


        // safe apply
        function safeApply() { try { $scope.$applyAsync(); } catch (e) { } }

        //-----------------------------------------ACTIONS

        // Save draft and publish unchanged behavior
        $scope.saveDraft = function () {
            const draftPayload = { draft: $scope.result };
            $http.post($scope.save_draft_url, draftPayload, { headers: { "X-RVT": token, "Content-Type": "application/json" } })
                .then(res => {
                    const id = res.data?.response?.id || res.data?.id || res.data?.responseId || res.data?.id;
                    alert("Brouillon sauvegardé, id = " + id);
                }).catch(err => {
                    alert("Erreur sauvegarde: " + (err.data?.message || JSON.stringify(err.data)));
                });
        };

        // Publish
        $scope.publish = function () {
            var publishConfirmed = function () {
                const coursePayload = { course: $scope.result };
                $http.post($scope.publish_url, coursePayload, { headers: { "X-RVT": token, "Content-Type": "application/json" } })
                    .then(res => {
                        const id = res.data?.response?.id || res.data?.id || res.data?.responseId || res.data?.id;
                        toastr.success("Cours publié");
                        setTimeout(() => $scope.reset(true), 1000);
                    }).catch(err => {
                        console.log("Erreur publication: " + (err.data?.message || JSON.stringify(err.data)));
                        toastr.error("Erreur publication");
                    });
            }

            toastr.confirm("Publier le cours ?",
                () => publishConfirmed(), null);


        };

        // reset form and state
        $scope.reset = function (force) {
            var resetConfirmed = function () {
                $scope.generated = false;
                $scope.error = "";
                $scope.warnings = "";
                $scope.result = angular.copy(initResult);
                $scope.form = angular.copy($scope.form_reset);
                safeApply();
                localStorage.removeItem("ai_course_draft");
            }
            if (!force) {
                toastr.confirm("Réinitialiser le formulaire ?<br/>Le contenu non publié sera perdu.",
                    () => resetConfirmed(), null);
            } else {
                resetConfirmed();
            }
        };


        $scope.copyResultsContainer = function () {
            const el = document.getElementById("resultsContainer");
            if (!el) return;

            const selection = el.innerText.trim();
            navigator.clipboard.writeText(selection).then(function () { });
        };
        $scope.printResultsContainer = function () {
            const el = document.getElementById("resultsContainer");
            if (!el) return;

            const win = window.open("", "_blank");

            win.document.write(`
                        <html>
                        <head>
                            <title>Impression</title>
                            <style>
                                body { font-family: Arial; padding:20px; }
                                h4,h5 { margin-top:0; }
                            </style>
                        </head>
                        <body>${el.innerHTML}</body>
                        </html>
                        `);

            win.document.close();
            win.focus();

            // Delay to allow browser render
            setTimeout(() => {
                win.print();
                win.close();
            }, 200);
        };
        function saveToLocal() {
            try {
                localStorage.setItem("ai_course_draft", JSON.stringify($scope.result));
            } catch (e) {
                console.warn("LocalStorage save error", e);
            }
        }

        function toBool(v) {
            if (typeof v === "boolean") return v;
            if (typeof v === "string") return v === "yes" || v === "true" || v === "1";
            return Boolean(v);
        }


    }]);
