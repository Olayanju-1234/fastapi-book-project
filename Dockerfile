FROM python:3.9-slim

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

EXPOSE 80

# Start Nginx and FastAPI
CMD service nginx start && uvicorn main:app --host 0.0.0.0 --port 8000