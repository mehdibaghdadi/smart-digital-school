# curl -sS http://localhost:11434/api/chat -H "Content-Type: application/json" -d "{ \"model\": \"deepseek-v3.1:671b-cloud\", \"messages\": [{\"role\": \"user\", \"content\": \"ping\"}] }"


PROMPT_TEST="""
SYSTEM:
You output STRICT JSON ONLY.
No markdown. No code fences. No ```json. No ``` . No explanations.
You MUST output exactly ONE valid JSON object and NOTHING else.
Never include text before or after the JSON object.

ABSOLUTE RULES:
- Output ONLY raw JSON.
- Never wrap JSON inside code fences.
- Never add markdown formatting.
- Never add comments.
- Use only double quotes.
- The JSON must be fully parseable with JSON.parse().
- Do not output extraneous fields. Only produce the keys requested below.

USER INSTRUCTIONS:
Produce exactly one JSON object. Required top-level keys: "title","summary","modules".
If Include_quiz = true, also include a top-level key "quizzes" as specified below.

Rules for keys:
- "title": concise reformulation of provided Title, maximum 12 words.
- "summary": rewrite Description into a coherent summary, minimum 12 words, same language as input.
- "modules": array with exactly {modules} objects.

Each module object MUST contain exactly these keys:
"title", "description", "lessons".

Module rules:
- module["title"]: minimum 12 words, this is a title of module.
- module["description"]: minimum 30 words,this is a description of module.
- module["lessons"]: array of one or more lesson objects.

Each lesson object MUST contain exactly:
"summary", "content".
- lesson["summary"]: minimum 12 words,this is a title of lesson.
- lesson["content"]: minimum 60 words,this is a content of lesson.

If Include_quiz = true:
    Add a new top-level key named "quizzes" in the JSON object.

If Include_quiz = true "quizzes" MUST be an array of one or more quiz objects.
Each quiz object MUST contain exactly:
- "quiz_name": a short title for the quiz (<= 10 words).
- "questions": an array of question objects (minimum 2 questions per quiz).

If Include_quiz = true Each question object MUST contain exactly:
- "question": question text (string).
- "choices": an array of 2 to 6 answer strings.
- "correct_answer": integer index (0-based) indicating the correct choice.
  This means:
  • The first choice has index 0
  • The second choice has index 1
  • The third choice has index 2
  • And so on…
- "correct_answer" MUST correspond exactly to the position of the correct item
  inside the "choices" array.

IMPORTANT:
- Choices MUST NOT start with labels such as: "A.", "B.", "C.", "D.", "1.", "2.", "3." or any other prefix or enumeration.
- Choices MUST be plain text only.
- Example of valid choices:
    ["Le traitement du langage naturel", "La traduction automatique", "L'analyse syntaxique"]
- Example of invalid choices (DO NOT PRODUCE):
    ["A. Le traitement du langage naturel", "B. La traduction automatique"]

Rules:
- You may create multiple quizzes per course.
- Each quiz must have at least 2 questions.
- Choices must not contain numbering or lettering.
- "correct_answer" must be an integer between 0 and len(choices)-1.
- Do NOT add quiz modules inside "modules".
- Do NOT add lessons named "Quiz".
- Do NOT modify lessons inside modules.
Only create the "quizzes" array at the root of the JSON object If Include_quiz = true.


If any constraint becomes difficult, still produce meaningful non-empty text that matches the minimum word counts and structural rules.

STRICT FORMAT REQUIREMENT:
Output MUST match this structure EXACTLY (no markdown). Include the "quizzes" key only when Include_quiz = true.

{{
  "title": "...",
  "summary": "...",
  "modules": [
    {{
      "title": "...",
      "description": "...",
      "lessons": [
        {{"summary":"...", "content":"..."}}
      ]
    }}
  ],
  "quizzes": [
    {{
      "quiz_name": "Quiz introductif",
      "questions": [
        {{
          "question": "Question 1 text ...?",
          "choices": ["Choice A", "Choice B", "Choice C"],
          "correct_answer": 0
        }},
        {{
          "question": "Question 2 text ...?",
          "choices": ["Choice A", "Choice B"],
          "correct_answer": 1
        }}
      ]
    }}
  ]
}}

INPUT SPECIFICATION:
Title: Modèles probabilistes et bayésiens
Level: débutant
Audience: étudiant
Language: fr
Duration:1 heures
Number of modules: 3
Style: excercices+théorie
Include_quiz: True
Description: Définir Modèles probabilistes et bayésiens Modèles probabilistes et bayésiens

END
"""



import requests, json

URL = "http://localhost:8800/api/generate"
payload = {"title":"NLP : traitement du langage nature","level":"Débutant","audience":"étudiants","language":"fr","duration":"4 heures","modules":1,"style":"Théorie + exercices","include_quiz":False,"description":"cours de NLP : traitement du langage nature"}

r = requests.post(URL, json=payload, timeout=500)
print("HTTP", r.status_code)
print("Headers:", r.headers)
print("Body:\n", r.text)        # <- important : montre la trace ou l'erreur JSON
try:
    r.raise_for_status()
except Exception as e:
    print("raise_for_status:", e)
    # si c'est du JSON d'erreur on l'affiche joliment
    try:
        print("JSON body:", json.dumps(r.json(), indent=2, ensure_ascii=False))
    except Exception:
        pass
