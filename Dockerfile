# 1. Base image
FROM python:3.12-slim

# 2. Working directory inside the container
WORKDIR /app

# 3. Environment settings
ENV PYTHONUNBUFFERED=1

# 4. Install system dependencies
RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

# 5. Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy ENTIRE Django project
COPY . .

# 7. Expose Django port
EXPOSE 8090

# 8. Start Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8090"]
