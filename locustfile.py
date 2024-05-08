from locust import HttpUser, task, between


class WebsiteUser(HttpUser):
    host = "https://localhost"
    wait_time = between(1, 2)  # Ожидание между задачами от 1 до 2 секунд

    def on_start(self):
        self.client.verify = False

    @task(1)
    def home_page(self):
        self.client.get("/")  # Симуляция обращения к главной странице

    @task(2)
    def search(self):
        # Симуляция обращения к странице поиска с параметром запроса
        self.client.get("/search", params={"query": "hello"})