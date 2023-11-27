from flask import Flask
from application.controller.controller import app_blueprint
from application.repository.repository import PredictionRepository

app = Flask(__name__)
app.register_blueprint(app_blueprint)

repository = PredictionRepository()
repository.create_tables()

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=80)