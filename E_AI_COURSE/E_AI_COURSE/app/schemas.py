# app/schemas.py
from typing import List, Optional
from pydantic import BaseModel, Field

class LessonOut(BaseModel):
    lesson_summary: Optional[str] = ""
    lesson_content: Optional[str] = ""

class ModuleOut(BaseModel):
    module_title: str
    module_description: Optional[str] = ""
    lessons: List[LessonOut] = []

class GenerateRequest(BaseModel):
    title: str = Field(..., min_length=3, max_length=300)
    level: Optional[str] = "Débutant"
    audience: Optional[str] = ""
    language: Optional[str] = "fr"
    duration: Optional[str] = ""
    modules: Optional[int] = 8
    style: Optional[str] = "Théorie + exercices"
    include_quiz: Optional[bool] = True
    description: Optional[str] = ""

class GenerateResponse(BaseModel):
    course_title: str
    course_summary: Optional[str] = ""
    modules: List[ModuleOut] = []
    note: Optional[str] = None
