# _*_ coding:utf-8 _*_
# 开发名称：models
# 开发人员：Agoni
# 开发时间:2020/3/12 17:15
# 开发工具：PyCharm
from . import db
from datetime import datetime


# 用户
class User(db.Model):
    __tablename__ = "user"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    username = db.Column(db.String(100))  # 用户名
    pwd = db.Column(db.String(100))  # 密码
    email = db.Column(db.String(100), unique=True)  # 邮箱
    role_id = db.Column(db.Integer, db.ForeignKey("role.id"))  # 角色
    phone = db.Column(db.String(11), unique=True)  # 手机号
    info = db.Column(db.Text)  # 个性简介
    face = db.Column(db.String(255), default='default.jpg')  # 头像
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 注册时间
    # loginlogs = db.relationship('Loginlog', backref='user')  # 登录日志外键关系关联
    # oplogs = db.relationship('Oplog', backref='user')  # 操作日志外键关系关联
    question = db.relationship('Question', backref='user')
    role = db.relationship('Role', backref='user')

    def __repr__(self):
        return '<User %r>' % self.name

    def check_pwd(self, pwd):
        """
        检测密码是否正确
        :param pwd: 密码
        :return: 返回布尔值
        """
        from werkzeug.security import check_password_hash
        return check_password_hash(self.pwd, pwd)


# 登录日志
class Loginlog(db.Model):
    __tablename__ = "loginlog"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))  # 所属管理员
    ip = db.Column(db.String(100))  # 登录IP
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 登录时间
    user = db.relationship("User", backref='loginlog')

    def __repr__(self):
        return "<Loginlog %r>" % self.id


# 操作日志
class Oplog(db.Model):
    __tablename__ = "oplog"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))  # 所属管理员
    ip = db.Column(db.String(100))  # 操作IP
    reason = db.Column(db.String(600))  # 操作原因
    user = db.relationship("User", backref='oplog')
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 登录时间

    def __repr__(self):
        return "<Oplog %r>" % self.id


# 角色
class Role(db.Model):
    __tablename__ = "role"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    rolename = db.Column(db.String(100))  # 角色名称
    state = db.Column(db.Integer, default=1);  # 角色状态
    detail = db.Column(db.String(100))  # 描述
    Menus = db.relationship('Menu_role', backref='role')  # 关联角色目录表

    def __repr__(self):
        return "<Role %r>" % self.id


# 系统目录
class Sysmenu(db.Model):
    __tablename__ = "sysmenu"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    menustr = db.Column(db.String(100))  # 目录名称
    state = db.Column(db.Integer, default=1)  # 目录状态
    path = db.Column(db.String(100))  # 路由请求
    parent_id = db.Column(db.Integer, default=0)  # 父级目录
    icon = db.Column(db.String(100))  # 系统图标
    rank = db.Column(db.Integer, default=0)  # 排序
    menus = db.relationship('Menu_role', backref='menu')  # 关联角色目录表

    def __repr__(self):
        return "<Sysmenu %r>" % self.id

    def to_json(self):
        return {
            'id': self.id,
            'path': self.path,
            'menustr': self.menustr,
            'parent_id': self.parent_id
        }


# 角色目录表
class Menu_role(db.Model):
    __tablename__ = "menu_role"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    mid = db.Column(db.Integer, db.ForeignKey('sysmenu.id'))  # 目录编号
    rid = db.Column(db.Integer, db.ForeignKey('role.id'))  # 角色编号
    Menu = db.relationship('Sysmenu', backref="menu_role")

    def __repr__(self):
        return "<Menu_role %r>" % self.mid


# 试题类别
class Question_type(db.Model):
    __tablename__ = "question_type"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    name = db.Column(db.String(100))  # 名称
    desc = db.Column(db.String(100))  # 描述
    is_public = db.Column(db.Integer, default=1)  # 是否公开
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))  # 所属用户
    type = db.relationship("Question", backref="question_type")

    def __repr__(self):
        return "<Question_type %r>" % self.id


# 试题
class Question(db.Model):
    __tablename__ = "question"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    context = db.Column(db.String(1024))  # 题目
    op_a = db.Column(db.String(1024))  # A选项
    op_b = db.Column(db.String(1024))  # B选项
    op_c = db.Column(db.String(1024))  # C选项
    op_d = db.Column(db.String(1024))  # D选项
    answer = db.Column(db.String(1024))  # 答案
    state = db.Column(db.Integer, default=1)  # 目录状态
    is_public = db.Column(db.Integer, default=0)  # 是否公开
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))  # 所属用户
    type = db.Column(db.Integer, db.ForeignKey("question_type.id"))  # 试题类型
    analysis = db.Column(db.String(1024))  # 解析
    difficult = db.Column(db.String(10))  # 难度

    def __repr__(self):
        return "<Question %r>" % self.id


# 试卷表
class Test(db.Model):
    __tablename__ = "test"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    test_name = db.Column(db.String(100))  # 试卷名称
    count = db.Column(db.Integer)  # 试卷题目数
    state = db.Column(db.Integer, default=1)  # 试卷状态
    is_public = db.Column(db.Integer, default=1)  # 是否公开
    score = db.Column(db.Integer)  # 分数
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))  # 所属用户
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 创建时间
    exam = db.relationship("Examination", backref="test")

    def __repr__(self):
        return "<test %r>" % self.id


# 试卷详细表
class Test_detail(db.Model):
    __tablename__ = "test_detail"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    test_id = db.Column(db.Integer, db.ForeignKey('test.id'))  # 所属试卷
    question_id = db.Column(db.Integer, db.ForeignKey('question.id'))  # 所属试卷
    score = db.Column(db.Integer)  # 分数
    test = db.relationship("Test", backref="test_detail")
    question = db.relationship("Question", backref="test_detail")

    def __repr__(self):
        return "<test_detail %r>" % self.id


# 考试表
class Examination(db.Model):
    __tablename__ = "examination"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    to_user = db.Column(db.Integer, db.ForeignKey('user.id'))  # 考生
    from_user = db.Column(db.Integer, db.ForeignKey('user.id'))  # 出卷人
    test_id = db.Column(db.Integer, db.ForeignKey('test.id'))  # 所属试卷
    time = db.Column(db.Integer)  # 考试时间
    startTime = db.Column(db.DateTime, index=True)  # 开始时间
    endTime = db.Column(db.DateTime, index=True)  # 结束时间
    count = db.Column(db.Integer)  # 试卷题目数
    is_join = db.Column(db.Integer, default=0)  # 是否参加考试，默认不参加

    def __repr__(self):
        return "<Examination %r>" % self.id


# 考试结果表
class ExaminationResult(db.Model):
    __tablename__ = "examination_result"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    unique_id = db.Column(db.String(20))  # 考试唯一标识
    to_user = db.Column(db.Integer, db.ForeignKey('user.id'))  # 考生
    from_user = db.Column(db.Integer, db.ForeignKey('user.id'))  # 出卷人
    test_name = db.Column(db.Integer, db.ForeignKey('test.id'))  # 所属试卷
    time = db.Column(db.Integer)  # 考试时间
    count = db.Column(db.Integer)  # 试卷题目数
    score = db.Column(db.Integer)  # 得分
    test = db.relationship("Test", backref="examination_result")
    user = db.relationship("User", foreign_keys=to_user)

    def __repr__(self):
        return "<ExaminationResult %r>" % self.id


# 考试结果详情
class ExaminationDetail(db.Model):
    __tablename__ = "examinationdetail"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    unique_id = db.Column(db.String(20))  # 考试唯一标识
    test_id = db.Column(db.Integer, db.ForeignKey('test.id'))  # 所属试卷
    question_id = db.Column(db.Integer, db.ForeignKey('question.id'))  # 所属问题
    answer = db.Column(db.String(1024))  # 错误答案
    answer_post = db.Column(db.String(1024))  # 正确答案
    score = db.Column(db.Integer)  # 得分
    is_true = db.Column(db.Integer, default=1)  # 是否做对，默认错误
    question = db.relationship("Question", backref="examinationdetail")
    test = db.relationship("Test", backref="examinationdetail")

    def __repr__(self):
        return "<Examinationdetail %r>" % self.id


# 消息
class Message(db.Model):
    __tablename__ = "message"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    to_user = db.Column(db.Integer, db.ForeignKey('user.id'))  # 发送者
    from_user = db.Column(db.Integer, db.ForeignKey('user.id'))  # 接收者
    context = db.Column(db.String(1024))  # 消息
    is_read = db.Column(db.Integer, default=0)  # 是否阅读，默认未阅读
    addtime = db.Column(db.DateTime, index=True, default=datetime.now)  # 发送时间
    receivier = db.relationship('User', foreign_keys=to_user)
    sender = db.relationship('User', foreign_keys=from_user)

    def __repr__(self):
        return "<Message %r>" % self.id


# 好友
class Friends(db.Model):
    __tablename__ = "friends"
    __table_args__ = {"useexisting": True}
    id = db.Column(db.Integer, primary_key=True)  # 编号
    self_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    friend_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    self = db.relationship('User', foreign_keys=self_id)
    friend = db.relationship('User', foreign_keys=friend_id)

    def __repr__(self):
        return "<Friends %r>" % self.id
