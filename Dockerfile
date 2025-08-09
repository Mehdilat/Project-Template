ARG HOST=0.0.0.0
ARG PORT=8000

# Use a lightweight Python image
FROM python:3.12-slim

# Create a non-root user
RUN useradd --create-home --shell /bin/bash appuser

# Copy uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

#Set working directory
WORKDIR /app

# Copy application files
COPY src/app.py ./
COPY pyproject.toml ./
COPY uv.lock ./

# Install dependencies
RUN uv sync --frozen

# Switch to non-root user
USER appuser

# Expose the port (use fixed value instead of variable)
EXPOSE 8000

# Set environment variables
ARG HOST
ARG PORT
ENV HOST=${HOST}
ENV PORT=${PORT}
ENV PYTHONPATH=/app

# Run the application
CMD ["sh", "-c", "uv run uvicorn app:app --host $HOST --port $PORT"]