# Flask PDF Reader

Flask PDF Reader is a simple web application built with Flask that allows users to upload PDF files and extract their text content using the PyMuPDF library.

## Features

- Upload a PDF file via a POST request.
- Extract and return the text content of the PDF.

## Requirements

- Python 3.9 or higher
- Flask
- PyMuPDF

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd flask-pdf-reader
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Run the application:
   ```bash
   python app.py
   ```

4. Access the application at `http://127.0.0.1:5000`.

## Usage

### Extract Text from a PDF

Send a POST request to the `/extract-text` endpoint with a PDF file:

```bash
curl -X POST -F "pdf=@path/to/your/file.pdf" http://127.0.0.1:5000/extract-text
```

The response will contain the extracted text in JSON format.

## Docker Setup

1. Build the Docker image:
   ```bash
   docker build -t flask-pdf-reader .
   ```

2. Run the container:
   ```bash
   docker run -p 5000:5000 flask-pdf-reader
   ```

3. Access the application at `http://127.0.0.1:5000`.

## Docker Compose Setup

1. Start the application using Docker Compose:
   ```bash
   docker-compose up
   ```

2. Access the application at `http://127.0.0.1:5000`.

## License

This project is licensed under the MIT License.
