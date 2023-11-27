import os
from dotenv import load_dotenv

# Carrega as variáveis de ambiente a partir do arquivo .env
load_dotenv()

class DBConfig:
    def __init__(self):
        self.host = os.getenv("DB_HOST")
        self.user = os.getenv("DB_USER")
        self.password = os.getenv("DB_PASSWORD")
        self.database = os.getenv("DB_DATABASE")
        self.ssl_ca_cert = os.getenv("SSL_CA_CERT")
        # self.ssl_disable = False

    def get_connection_config(self):
        return {
            "host": self.host,
            "user": self.user,
            "password": self.password,
            "database": self.database,
            "ssl_ca": self.ssl_ca_cert,
            # "ssl_disable": self.ssl_disable
        }
