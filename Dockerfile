FROM python:3.10-slim

# Устанавливаем Node.js и curl
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем requirements.txt и устанавливаем зависимости
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь код
COPY . .

# Открываем порт
EXPOSE 8003

# Запускаем через gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8003", "app:app"]
