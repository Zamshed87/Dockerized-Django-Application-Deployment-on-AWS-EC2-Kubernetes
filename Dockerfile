# Base image
FROM python:3.11-slim

# Set workdir
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libffi-dev \
    libpq-dev \
    zlib1g-dev \
    gcc \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Collect static files at build time
RUN python manage.py collectstatic --noinput

# Expose port
EXPOSE 8000

# Run with Gunicorn for production
CMD ["gunicorn", "rapid.wsgi:application", "--bind", "0.0.0.0:8000"]
