# Use an appropriate base image
FROM python:3.9-slim

# Install system dependencies, including libgomp and ccache
# RUN apt-get update && apt-get install libgomp1 libgl1-mesa-glx libglib2.0-0 libsm6 libxext6  -y \
#     && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    libgl1 \
    wget

# http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/?C=M;O=D
RUN wget https://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.24_i386.deb && \
    dpkg -i libssl1.1_1.1.1f-1ubuntu2.24_i386.deb && \
    rm libssl1.1_1.1.1f-1ubuntu2.24_i386.deb

# Set the working directory
WORKDIR /app

# Copy project files
COPY . /app
# Set environment variables to ensure logs are displayed
ENV PYTHONUNBUFFERED=1
# ENV FLASK_ENV=development

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the application port
EXPOSE 5000

# Define the command to run the application
CMD ["flask", "run", "--host=0.0.0.0"]
