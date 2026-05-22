FROM python:3.11-slim

WORKDIR /app

# Copy files
COPY requirements.txt .
COPY app.py .
COPY templates/ ./templates/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port
EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:5000/health')" || exit 1

# Run app
CMD ["python", "app.py"]
