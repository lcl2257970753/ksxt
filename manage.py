# _*_ coding:utf-8 _*_
# 开发名称：manage
# 开发人员：Agoni
# 开发时间:2020/3/12 17:13
# 开发工具：PyCharm

from app import create_app
from app.models import *
from flask_script import Manager, Shell
from flask_migrate import Migrate, MigrateCommand
from flask import render_template

app = create_app('default')
manager = Manager(app)
migrate = Migrate(app, db)


def make_shell_context():
    return dict(app=app, db=db)


manager.add_command("shell", Shell(make_context=make_shell_context))
manager.add_command('db', MigrateCommand)


@app.errorhandler(404)
def page_not_found(error):
    """
    404
    """
    return render_template("app/templates/common/404.html"), 404


if __name__ == '__main__':
    # manager.run()
    app.run(host='0.0.0.0', port=5000)