# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies and nginx
RUN apt-get update \
    && apt-get install -y nginx supervisor \
    && apt-get clean

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Expose the application and nginx ports
EXPOSE 80
EXPOSE 8000

# Copy Nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy Supervisor config (you will need to create this)
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Start the services using Supervisor
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
