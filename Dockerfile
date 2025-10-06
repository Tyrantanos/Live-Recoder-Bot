#KSBOTOFFICALS
#DEVELOPER

FROM python:3.12-slim-bookworm  # Updated to newer Python/Debian for security and stable repos

WORKDIR /app

# Copy requirements first for better Docker layer caching
COPY requirements.txt .

# Install Python dependencies with no cache to keep layers small
RUN pip install --no-cache-dir -r requirements.txt

# Install FFmpeg robustly (combined update/install/clean for efficiency)
RUN apt-get update -qq \
    && apt-get install -y ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the rest of the app
COPY . .

CMD python3 bot.pyc # Use exec form for better signal handling
