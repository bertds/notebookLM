# Use Python 3.11 slim image as base
FROM python:3.11-slim-bookworm

# Install uv using the official method
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/


# Install system dependencies required for building certain Python packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    gcc git \
    libmagic-dev \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container to /app
WORKDIR /app

COPY . /app

RUN uv sync

ENV STREAMLIT_SERVER_PORT=8502
EXPOSE 8502

RUN mkdir -p /app/data

HEALTHCHECK --interval=30s --timeout=5s CMD curl -f http://localhost:8502/_stcore/health || exit 1

CMD ["uv", "run", "streamlit", "run", "app_home.py", "--server.port", "8502", "--server.address", "0.0.0.0"]
