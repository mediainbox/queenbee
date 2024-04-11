FROM python:3.11.5-slim

ENV PYTHONUNBUFFERED True

# Set the working directory

WORKDIR /app

# Copy the current directory contents into the container at /app
COPY poetry.lock pyproject.toml /app/

# Install any needed packages specified in requirements.txt
RUN apt-get update && apt-get install -y build-essential

RUN pip install poetry

# Install the dependencies
RUN poetry install

# Copy the current directory contents into the container at /app
COPY . /app

# Make port 80 available to the world outside this container
EXPOSE 80


# Run app.py when the container launches
CMD ["poetry", "run", "gunicorn" ,"-k", "uvicorn.workers.UvicornWorker", "ai_spider.app:app", "--bind", "0.0.0.0:80", "--log-config", "logging.conf"]
