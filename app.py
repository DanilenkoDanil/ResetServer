from flask import Flask, request
import time

app = Flask(__name__)


@app.route('/')
def home():
    return "Добро пожаловать на главную страницу!"


@app.route('/search')
def search():
    time.sleep(5)
    query = request.args.get('query')
    return f"Результаты поиска для: {query}"