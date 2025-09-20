FROM python:3.12-slim

WORKDIR /app

# Install system dependencies (needed for Pillow and others)
RUN apt-get update && apt-get install -y \
    libjpeg-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

# Collect static files
RUN python manage.py collectstatic --noinput

EXPOSE 8000

CMD ["gunicorn", "book.wsgi:application", "--bind", "0.0.0.0:8000"]