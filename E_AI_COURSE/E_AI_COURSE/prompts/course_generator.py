COURSE_GENERATOR_TEMPLATE = """
INPUT SPECIFICATION:
Title: <<title>>
Description: <<description>>
Language: <<language>>
Duration: <<duration>>
Level: <<level>>
Audience: <<audience>>
Number of modules: <<modules>>
Style: <<style>>
Include_quiz: <<include_quiz>>

LANGUAGE OVERRIDE:
Every sentence in the JSON output MUST be written in the language specified in the field: Language: <<language>>
You MUST NOT use English when Language = french.

SYSTEM:
You output STRICT JSON ONLY.
No markdown. No code fences. No ```json. No ``` . No explanations.
You MUST output exactly ONE valid JSON object and NOTHING else.
Never include text before or after the JSON object.
ALL GENERATED TEXT MUST BE WRITTEN IN <<language>>.
Use <<language>> for every word in every field.

ABSOLUTE RULES:
- Output ONLY raw JSON.
- Never wrap JSON inside code fences.
- Never add markdown formatting.
- Never add comments.
- Use only double quotes.
- The JSON must be fully parseable with JSON.parse().
- Do not output extraneous fields. Only produce the keys requested below.

USER INSTRUCTIONS:
Produce exactly one JSON object. Required top-level keys: "course_title","course_summary","modules".
If Include_quiz = true, also include a top-level key "quizzes" as specified below.

Rules for keys:
- "course_title": concise reformulation of provided Title, maximum 12 words.
- "course_summary": rewrite Description into a coherent summary, minimum 30 words, same language as input.
- "modules": array with exactly {modules} objects.

Each module object MUST contain exactly these keys:
"module_title", "module_description", "lessons".

Module rules:
- module["module_title"]: the title of the module; it must contain at least 12 words.
- module["module_description"]: the description of the module; it must contain at least 30 words.
- module["lessons"]: array of three or more lesson objects.

Each lesson object MUST contain exactly:
"lesson_summary", "lesson_content".
- lesson["lesson_summary"]: the lesson title; it must contain at least 12 words.
- lesson["lesson_content"]: the lesson content; it must contain at least 60 words.

If Include_quiz = true:
    Add a new top-level key named "quizzes" in the JSON object.

Quiz rules (when Include_quiz = true):
- "quizzes" MUST be a root-level array.
- You MUST create at least one quiz for each module.
- Total number of quizzes MUST be greater than or equal to the number of modules.
- Each quiz object MUST contain exactly: "quiz_name", "time_limit", "questions".
- "quiz_name": short title for the quiz (<= 10 words).
- "time_limit": integer number of minutes (no quotes).
- "questions": array of question objects (minimum 2 questions per quiz).

Each question object MUST contain exactly:
- "question": question text (string).
- "choices": an array of 2 to 6 answer strings (plain text, no numbering or lettering).
- "correct_answer": integer index (0-based) indicating the correct choice.
  Example: if the correct choice is the first item, correct_answer is 0.

STYLE RULE:
- Do NOT begin any title, summary, description, module text, or lesson content with repetitive openings such as:
  "Ce cours", "Dans ce cours", "Ce module", "Dans ce module", "Cette leçon", "Dans cette leçon".
- Vary openings creatively. Start sentences with diverse, natural academic expressions.
- Avoid formulaic introductions. No copy/paste patterns across modules or lessons.

IMPORTANT:
- Choices MUST NOT start with labels such as: "A.", "B.", "C.", "D.", "1.", "2.", "3." or any other prefix.
- Choices MUST be plain text only.
- Do NOT add quiz modules inside "modules".
- Do NOT add lessons named "Quiz".
- Do NOT modify lessons inside modules.
- Only create the "quizzes" array at the root of the JSON object when Include_quiz = true.

If any constraint becomes difficult, still produce meaningful non-empty text that matches the minimum word counts and structural rules.

STRICT FORMAT REQUIREMENT:
Output MUST match this structure EXACTLY (no markdown). Include the "quizzes" key only when Include_quiz = true.

Valid example (when Include_quiz = true). This is a parseable JSON example; keep commas and syntax exactly as shown:

{
  "course_title": "Analysis of Linear Operators and Spectral Decomposition",
  "course_summary": "A coherent summary of at least thirty words describing the course goals, prerequisites, intended outcomes, and a brief explanation of the main topics that will be covered during the course.",
  "modules": [
    {
      "module_title": "Foundations and functional analysis preliminaries including topology, normed spaces, and bounded linear operators as necessary background",
      "module_description": "This module presents foundational material in functional analysis, covering topological vector spaces, normed and Banach spaces, bounded operators, and essential examples to prepare students for spectral theory and operator decompositions.",
      "lessons": [
        { "lesson_summary": "Review of normed spaces, linear operators, and examples contextualizing their use in spectral problems", "lesson_content": "Detailed content of at least sixty words explaining norms, examples of normed vector spaces, linear operators, boundedness, and motivations for spectral analysis with illustrative examples and exercises." },
        { "lesson_summary": "Compact operators, Fredholm theory, and their relevance to decompositions in infinite-dimensional contexts", "lesson_content": "Extended content with at least sixty words describing compact operators, Fredholm index, essential spectrum, and how these concepts inform decomposition strategies and spectral approximations." },
        { "lesson_summary": "Adjoint operators, self-adjointness, and consequences for spectral measures and functional calculus", "lesson_content": "Extended content with at least sixty words covering adjoint definitions, criteria for self-adjointness, spectral theorem statements, and consequences for functional calculus and applications." }
      ]
    }
  ],
  "quizzes": [
    {
      "quiz_name": "Module 1 Quiz",
      "time_limit": 20,
      "questions": [
        { "question":"What is the definition of a bounded linear operator on a normed space?", "choices":["An operator with finite operator norm","An operator that is compact on the space"], "correct_answer": 0 },
        { "question":"Which space is complete under the usual norm?", "choices":["A Banach space","A pre-Hilbert space"], "correct_answer": 1 }
      ]
    }
  ]
}

END
"""
