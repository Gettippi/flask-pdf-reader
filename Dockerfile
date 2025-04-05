# Use an appropriate base image
FROM python:3.9-slim

# Install system dependencies, including libgomp and ccache
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy project files
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the application port
EXPOSE 5000

# Define the command to run the application
CMD ["flask", "run", "--host=0.0.0.0"]
