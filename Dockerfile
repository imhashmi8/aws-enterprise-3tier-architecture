FROM python:3.10-slim

# Security best practice
RUN useradd -m appuser

WORKDIR /app

COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

USER appuser

EXPOSE 80

CMD ["gunicorn", "--workers=3", "--bind=0.0.0.0:80", "app:app"]