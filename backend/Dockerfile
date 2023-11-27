FROM python:3.11.3

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

CMD ["gunicorn", "main:app", "--bind", "0.0.0.0:80"]
