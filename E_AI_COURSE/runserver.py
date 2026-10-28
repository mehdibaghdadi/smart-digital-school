from E_AI_COURSE import create_app
app = create_app()

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("runserver:app", host="0.0.0.0", port=8800, reload=True)
