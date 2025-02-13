
# FastAPI Book Project

This is a FastAPI application that provides an API for managing books. It includes a CI/CD pipeline for automated testing and deployment, and it is served using Nginx as a reverse proxy.

## Features
- Retrieve a book by its ID.
- JSON responses for successful and error cases.
- Continuous Integration (CI) pipeline for testing.
- Continuous Deployment (CD) pipeline for automatic deployment.
- Nginx reverse proxy for serving the application.

## API Endpoints

### Get Book by ID
**Method:** GET  
**URL:** /api/v1/books/{book_id}

**Parameters:**
- `book_id` (integer): The ID of the book to retrieve.

**Responses:**
- **200 OK:** Returns JSON with the book details.
- **404 Not Found:** Returns an error if the book does not exist.

**Example Request:**
```bash
curl http://20.185.80.28/api/v1/books/1
```

**Example Response (200 OK):**
```json
{
  "book_id": 1,
  "title": "Sample Book",
  "author": "John Doe"
}
```

**Example Response (404 Not Found):**
```json
{
  "detail": "Book not found"
}
```

## Setup Instructions

### 1. Prerequisites
- Python 3.7+
- Git
- Nginx
- A server with a public IP address (e.g., Azure, AWS, DigitalOcean)

### 2. Clone the Repository
Clone the repository to your local machine or server:
```bash
git clone https://github.com/olayanju-1234/fastapi-book-project.git
cd fastapi-book-project
```

### 3. Set Up a Virtual Environment
Create and activate a virtual environment:
```bash
python3 -m venv venv
source venv/bin/activate
```

### 4. Install Dependencies
Install the required Python packages:
```bash
pip install -r requirements.txt
```

### 5. Run the Application Locally
Start the FastAPI app using Uvicorn:
```bash
uvicorn main:app --host 0.0.0.0 --port 8000
```
Access the app at: `http://localhost:8000`

## Deployment Instructions

### 1. Set Up the Server

#### Install Required Software
Install Python, Pip, and Nginx:
```bash
sudo apt update
sudo apt install python3 python3-pip python3-venv nginx -y
```

#### Clone the Repository
Clone the repository to your server:
```bash
git clone https://github.com/olayanju-1234/fastapi-book-project.git /home/azureuser/fastapi-app
cd /home/azureuser/fastapi-app
```

#### Set Up the Virtual Environment
Create and activate a virtual environment:
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 2. Configure Nginx

#### Edit the Nginx Configuration
Open the Nginx configuration file:
```bash
sudo nano /etc/nginx/sites-available/default
```

#### Add the Following Configuration
Replace the content with:
```nginx
server {
    listen 80;
    server_name 20.185.80.28;  # Replace with your server's public IP or domain

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

#### Test and Restart Nginx
Test the configuration and restart Nginx:
```bash
sudo nginx -t
sudo systemctl restart nginx
```

### 3. Set Up Systemd for FastAPI

#### Create a Systemd Service File
Create a new service file:
```bash
sudo nano /etc/systemd/system/fastapi.service
```

#### Add the Following Configuration
Replace `azureuser` with your username:
```ini
[Unit]
Description=FastAPI Application
After=network.target

[Service]
User=azureuser
WorkingDirectory=/home/azureuser/fastapi-app
ExecStart=/home/azureuser/fastapi-app/venv/bin/uvicorn main:app --host 0.0.0.0 --port 8000
Restart=always

[Install]
WantedBy=multi-user.target
```

#### Start and Enable the Service
Reload systemd, start the service, and enable it to run on boot:
```bash
sudo systemctl daemon-reload
sudo systemctl start fastapi
sudo systemctl enable fastapi
```

### 4. Set Up CI/CD Pipeline

#### Add the SSH Private Key to GitHub Secrets
Go to your GitHub repository → Settings → Secrets and variables → Actions.  
Add a new secret named `SSH_PRIVATE_KEY` and paste your private key.

#### Create the CI/CD Workflow
Add a `.github/workflows/cd.yml` file:
```yaml
name: CD
on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Deploy to Server
        env:
          SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
        run: |
          echo "$SSH_PRIVATE_KEY" > private_key
          chmod 600 private_key
          ssh -i private_key azureuser@20.185.80.28           "cd /home/azureuser/fastapi-app &&           git pull &&           sudo systemctl restart fastapi"
```

### Access the Application
Access the deployed application at: `http://20.185.80.28`  
Replace `20.185.80.28` with your server’s public IP address.

## Contributing
- Fork the repository.
- Create a new branch for your feature or bugfix.
- Submit a pull request.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
