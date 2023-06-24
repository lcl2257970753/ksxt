# _*_ coding:utf-8 _*_
# 开发名称：config
# 开发人员：Agoni
# 开发时间:2020/3/12 17:13
# 开发工具：PyCharm

import os


class Config:
    SECRET_KEY = 'agoni'
    SQLALCHEMY_TRACK_MODIFICATIONS = True
    UP_DIR = os.path.join(os.path.abspath(os.path.dirname(__file__)), "app/static/uploads/")  # 文件上传路径
    FC_DIR = os.path.join(os.path.abspath(os.path.dirname(__file__)), "app/static/uploads/users/")  # 用户头像上传路径

    @staticmethod
    def init_app(app):
        pass


class DevelopmentConfig(Config):
    # SQLALCHEMY_DATABASE_URI = "mysql+mysqlconnector://root:KCjd@123456@127.0.0.1:3306/questions"
    #SQLALCHEMY_DATABASE_URI = "mysql+mysqlconnector://root:root@1259164270LCL@gxx@123.207.198.138:3306/questions"
    SQLALCHEMY_DATABASE_URI = "mysql+mysqlconnector://root:123456LCL.gxx@111.229.10.135:3306/questions"


config = {
    'default': DevelopmentConfig
}
