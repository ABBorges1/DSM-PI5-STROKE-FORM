import mysql.connector
from db.db_config import DBConfig
from ..model.model import Prediction

class PredictionRepository:
    def __init__(self):
        self.db_config = DBConfig()

    def connect(self):
        try:
            connection = mysql.connector.connect(**self.db_config.get_connection_config())
            return connection
        except mysql.connector.Error as err:
            print(f"Erro ao conectar ao banco de dados: {err}")
            return None

    def create_tables(self):
        connection = self.connect()
        if connection:
            try:
                cursor = connection.cursor()
                use_database_query = "USE prediction_stroke"
                cursor.execute(use_database_query)

                create_table_query = """
                CREATE TABLE IF NOT EXISTS Prediction (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    name VARCHAR(50) NOT NULL,
                    phone VARCHAR(50) NOT NULL,
                    gender VARCHAR(10) NOT NULL,
                    age FLOAT NOT NULL,
                    hypertension INT NOT NULL,
                    heart_disease INT NOT NULL,
                    ever_married VARCHAR(255) NOT NULL,
                    work_type VARCHAR(255) NOT NULL,
                    residence_type VARCHAR(255) NOT NULL,
                    avg_glucose_level FLOAT NOT NULL,
                    bmi FLOAT NOT NULL,
                    smoking_status VARCHAR(255) NOT NULL,
                    stroke VARCHAR(255) NOT NULL
                )
                """
                cursor.execute(create_table_query)
                connection.commit()
                print("Tabela 'Prediction' criada com sucesso.")

            except mysql.connector.Error as err:
                print(f"Erro ao criar a tabela 'Prediction': {err}")

            finally:
                cursor.close()
                connection.close()

    def insert(self, data: Prediction):
        connection = self.connect()
        if connection:
            cursor = connection.cursor()

            try:
                use_database_query = "USE prediction_stroke"
                cursor.execute(use_database_query)

                insert_query = "INSERT INTO Prediction (name, phone, gender, age, hypertension, heart_disease, ever_married, work_type, residence_type, avg_glucose_level, bmi, smoking_status, stroke) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

                values = (
                    data.name,
                    data.phone,
                    data.gender,
                    data.age,
                    data.hypertension,
                    data.heart_disease,
                    data.ever_married,
                    data.work_type,
                    data.residence_type,
                    data.avg_glucose_level,
                    data.bmi,
                    data.smoking_status,
                    data.stroke
                )

                cursor.execute(insert_query, values)
                connection.commit()

            except mysql.connector.Error as err:
                print(f"Erro ao inserir na tabela 'Prediction': {err}")

            finally:
                cursor.close()
                connection.close()           
            

    def select_predictions(self):
        connection = self.connect()
        if connection:
            try:
                cursor = connection.cursor()

                select_query = "SELECT name, phone, gender, age, hypertension, heart_disease, ever_married, work_type, residence_type, avg_glucose_level, bmi, smoking_status, stroke FROM Prediction"
                cursor.execute(select_query)
                predictions = cursor.fetchall()

                return predictions

            except mysql.connector.Error as err:
                print(f"Erro ao selecionar dados da tabela 'Prediction': {err}")

            finally:
                cursor.close()
                connection.close()

    def select_prediction_id(self, id):
        connection = self.connect()
        if connection:
            try:
                cursor = connection.cursor()

                select_query = f"SELECT name, phone, gender, age, hypertension, heart_disease, ever_married, work_type, residence_type, avg_glucose_level, bmi, smoking_status, stroke FROM Prediction WHERE id = {int(id)}"
                cursor.execute(select_query)
                predictions = cursor.fetchall()

                return predictions

            except mysql.connector.Error as err:
                print(f"Erro ao selecionar dados da tabela 'Prediction': {err}")

            finally:
                cursor.close()
                connection.close()
