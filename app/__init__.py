# _*_ coding:utf-8 _*_
# 开发名称：__init__.py
# 开发人员：Agoni
# 开发时间:2020/3/12 17:13
# 开发工具：PyCharm


from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from config import config

db = SQLAlchemy()
def create_app(config_name):
    app = Flask(__name__)
    app.config.from_object(config[config_name])
    config[config_name].init_app(app)
    db.init_app(app)

    #注册蓝图
    from app.main import main as main_blueprint
    app.register_blueprint(main_blueprint)
    return app