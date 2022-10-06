# _*_ coding:utf-8 _*_
# 开发名称：__init__.py
# 开发人员：Agoni
# 开发时间:2020/3/12 17:16
# 开发工具：PyCharm

from flask import Blueprint

main = Blueprint("main",__name__)

import app.main.views