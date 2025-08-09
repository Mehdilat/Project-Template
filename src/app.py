from fastapi import FastAPI
from fastapi.responses import PlainTextResponse
import uvicorn
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()

app = FastAPI()

@app.get("/", response_class=PlainTextResponse)
def read_root():
    return "Hello World"

if __name__ == "__main__":
    host = os.getenv("HOST", "0.0.0.0")
    port = int(os.getenv("PORT", 8000))
    uvicorn.run(app, host=host, port=port)