
# FastAPI Book Project

This project is a FastAPI-based API for managing a collection of books. It includes a `/api/v1/books/{book_id}` endpoint to retrieve book details by its ID. The API is deployed with a CI/CD pipeline and served using Nginx as a reverse proxy.

## Table of Contents

1. [Project Setup](#project-setup)
2. [Installation](#installation)
3. [Running Locally](#running-locally)
4. [Testing](#testing)
5. [CI/CD Pipeline](#cicd-pipeline)
6. [Deployment](#deployment)
7. [API Endpoints](#api-endpoints)
8. [Contributing](#contributing)
9. [License](#license)

---

## Project Setup

The project is based on the [FastAPI Book Project Template](https://github.com/hng12-devbotops/fastapi-book-project). Follow the instructions below to set up and deploy the project.

## Installation

### Prerequisites

Ensure you have the following installed:

- Python 3.8+
- Pip
- Git
- Docker (for containerization)
- Nginx (for reverse proxy setup if deploying on a VPS)

### Clone the Repository

Clone the repository to your local machine:

```bash
git clone https://github.com/olayanju-1234/fastapi-book-project.git
cd fastapi-book-project
```

### Install Dependencies

Install the project dependencies using `pip`:

```bash
pip install -r requirements.txt
```

---

## Running Locally

### Start the FastAPI Application

To run the application locally, use the following command:

```bash
uvicorn main:app --reload
```

This will start the FastAPI application on `http://127.0.0.1:8000`.

### Access the API Documentation

The FastAPI app provides interactive documentation, which can be accessed by visiting:

- **Swagger UI**: `http://127.0.0.1:8000/docs`
- **ReDoc UI**: `http://127.0.0.1:8000/redoc`

---

## Testing

To run tests with pytest, use the following command:

```bash
pytest
```

---

## CI/CD Pipeline

The project uses GitHub Actions for continuous integration and deployment. The pipeline is configured to:

1. **Test**: Run tests on every pull request to the `main` branch.
2. **Deploy**: Automatically deploy the application to Render when a pull request is merged to `main`.

### GitHub Actions Configuration

You can view the pipeline configuration in the `.github/workflows/ci-cd.yml` file. It includes:

- Running `pytest` for testing.
- Deploying the application to Render.

---

## Deployment

The application is deployed on [Render](https://render.com/). The deployment process is automated through the CI/CD pipeline.

To deploy the application:

1. Push your changes to the `main` branch.
2. Render will automatically redeploy the app with the latest changes.

For custom setups, such as VPS deployments, follow the instructions below:

### VPS Deployment

1. Install Docker on your VPS.
2. Clone the repository onto your server.
3. Build and run the Docker container with the FastAPI app.
4. Configure Nginx to serve as a reverse proxy for the FastAPI application.

Refer to the [Nginx Documentation](https://nginx.org/en/docs/) for reverse proxy setup instructions.

---

## API Endpoints

### `/api/v1/books/{book_id}`

- **Method**: GET
- **Parameters**: `book_id` (integer)
- **Response**:
  - **200 OK**: Returns the book details in JSON format.
  - **404 Not Found**: Returns an error message if the book is not found.

Example Response:

```json
{
  "book_id": 1,
  "title": "The Great Gatsby",
  "author": "F. Scott Fitzgerald",
  "published": "1925"
}
```

---

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request with your changes.

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Make your changes and commit them (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Create a new pull request.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
