# 1. Base image with Python
FROM python:3.12-slim

# 2. Working directory inside the container
WORKDIR /app

# 3. Environment settings
ENV PYTHONUNBUFFERED=1

# 4. System dependencies (compiler etc. if needed)
RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

# 5. Install Python dependencies
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt
# 6. Copy Django project code
#    Your manage.py is inside todo_site/, so copy that folder. :contentReference[oaicite:1]{index=1}
# COPY todo_site/ ./todo_site/

# 7. Expose Django port
EXPOSE 5050

# 8. Default command (development server)
CMD ["python", "manage.py", "runserver", "0.0.0.0:5050"]

