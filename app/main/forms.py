# _*_ coding:utf-8 _*_
# 开发名称：forms
# 开发人员：Agoni
# 开发时间:2020/3/12 17:17
# 开发工具：PyCharm

from flask_wtf import FlaskForm
from flask_wtf.file import FileAllowed
from wtforms import StringField, PasswordField, SubmitField, FileField, TextAreaField, RadioField, SelectField, \
    SelectMultipleField,BooleanField,DateTimeField
from wtforms.validators import DataRequired, ValidationError, Email, EqualTo
from app.models import User


class LoginForm(FlaskForm):
    """
    用户登录表单
    """
    account = StringField(
        label="邮箱",
        validators=[
            DataRequired("邮箱不能为空")
        ],
        description="邮箱",
        render_kw={
            "type":"email",
            "placeholder": "请输入邮箱！"
        }
    )
    pwd = PasswordField(
        label="密码",
        validators=[
            DataRequired("密码不能为空")
        ],
        description="密码",
        render_kw={
            "type": "password",
            "placeholder": "请输入密码！",
        }
    )
    submit = SubmitField(
        '登录',
        render_kw={
            "class": "btn btn-primary btn-block btn-flat",
        }
    )


class RegisterForm(FlaskForm):
    """
    用户注册表单
    """
    username = StringField(
        validators=[DataRequired("用户名不能为空！")],
        description="用户名",
        render_kw={"placeholder": "请输入用户名！"}
    )
    email = StringField(
        validators=[
            DataRequired("邮箱不能为空！"),
            Email("邮箱格式不正确！")
        ],
        description="邮箱",
        render_kw={
            "type": "email",
            "placeholder": "请输入邮箱！",
        }
    )
    pwd = PasswordField(
        validators=[
            DataRequired("密码不能为空！")
        ],
        description="密码",
        render_kw={
            "placeholder": "请输入密码！",
        }
    )
    repwd = PasswordField(
        validators=[
            DataRequired("请输入确认密码！"),
            EqualTo('pwd', message="两次密码不一致！")
        ],
        description="确认密码",
        render_kw={
            "placeholder": "请输入确认密码！",
        }
    )
    submit = SubmitField(
        '注册',
        render_kw={
            "class": "btn btn-primary",
        }
    )

    def validate_email(self, field):
        """
        检测注册邮箱是否已经存在
        :param field: 字段名
        """
        email = field.data
        user = User.query.filter_by(email=email).count()
        if user == 1:
            raise ValidationError("邮箱已经存在！")


class UserForm(FlaskForm):
    """
    用户表单
    """
    username = StringField(
        label="用户名",
        validators=[
            DataRequired("用户名不能为空！"),
        ],
        description="用户名",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入用户名！",
        }
    )
    email = StringField(
        label="邮箱",
        validators=[
            DataRequired("邮箱不能为空！"),
            Email("邮箱格式不正确！")
        ],
        description="邮箱",
        render_kw={
            "class": "form-control",
            "type": "email",
            "placeholder": "请输入邮箱！"
        }
    )
    phone = StringField(
        label="手机号",
        validators=[
            DataRequired("手机号不能为空！")
        ],
        description="手机号",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入手机号！",
        },

    )
    face = FileField(
        label="头像",
        validators=[
            DataRequired("请上传头像！"),
            FileAllowed(['jpg','jpeg', 'png'], '请上传jpg或png格式图片!')
        ],
        description="头像",
    )
    info = StringField(
        label="描述",
        description="描述",
        render_kw={
            "class": "form-control",
            "placeholder": "描述信息！"
        }
    )
    role_id = SelectField(
        label="角色",
        description="选择角色",
        coerce=int,
        render_kw={
            "class": "form-control",
            "placeholder": "选择角色",
        }
    )
    submit = SubmitField(
        '注册',
        render_kw={
            "class": "btn btn-primary",
        }
    )


class PwdForm(FlaskForm):
    old_pwd = PasswordField(
        label="旧密码",
        validators=[
            DataRequired("旧密码不能为空！")
        ],
        description="旧密码",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入旧密码！",
        }
    )
    new_pwd = PasswordField(
        label="新密码",
        validators=[
            DataRequired("新密码不能为空！")
        ],
        description="新密码",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入新密码！",
        }
    )
    submit = SubmitField(
        '保存',
        render_kw={
            "class": "btn btn-primary",
        }
    )

    def validate_old_pwd(self, field):
        from flask import session
        pwd = field.data
        name = session["user"]
        user = User.query.filter_by(
            username=name
        ).first()
        if not user.check_pwd(pwd):
            raise ValidationError("旧密码错误！")


class MenuForm(FlaskForm):
    """
    添加/编辑目录表单
    """
    menustr = StringField(
        label="目录名称",
        description="目录",
        render_kw={
            "class": "form-control",
            "placeholder": "目录名称",
        }
    )
    state = RadioField(
        label='是否启用',
        description="是否启用",
        coerce=int,
        choices=[(0, '否'), (1, '是')], default=1
    )
    path = StringField(
        label="路径",
        description="路径",
        render_kw={
            "class": "form-control",
            "placeholder": "路径",
        }
    )
    icon = StringField(
        label="图标",
        description="图标",
        render_kw={
            "class": "form-control",
            "placeholder": "图标",
        }
    )
    parent_id = SelectField(
        label="父级编号",
        description="父级编号",
        coerce=int,
        render_kw={
            "class": "form-control",
            "placeholder": "父级编号",
        }
    )
    rank = StringField(
        label="排序",
        description="排序",
        render_kw={
            "class": "form-control",
            "placeholder": "排序",
        }
    )
    submit = SubmitField(
        '添加',
        render_kw={
            "class": "btn btn-primary",
        }
    )


class RoleForm(FlaskForm):
    """
    添加/编辑角色表单
    """
    rolename = StringField(
        label="角色名称",
        description="目录",
        render_kw={
            "class": "form-control",
            "placeholder": "目录名称",
        }
    )
    state = RadioField(
        label='是否启用',
        description="是否启用",
        coerce=int,
        choices=[(0, '否'), (1, '是')],
        default=0
    )
    detail = StringField(
        label="描述",
        description="描述",
        render_kw={
            "class": "form-control",
            "placeholder": "添加描述信息",
        }
    )
    submit = SubmitField(
        '添加',
        render_kw={
            "class": "btn btn-primary",
        }
    )


class QtForm(FlaskForm):
    """
    添加/编辑试题类别表单
    """
    name = StringField(
        label="名称",
        description="类别名称",
        render_kw={
            "class": "form-control",
            "placeholder": "输入类别名称",
        }
    )
    desc = StringField(
        label="描述",
        description="类别描述",
        render_kw={
            "class": "form-control",
            "placeholder": "输入类别名称",
        }
    )
    is_public = RadioField(
        label='是否公开',
        description="是否公开",
        coerce=int,
        choices=[(0, '否'), (1, '是')], default=0
    )
    submit = SubmitField(
        '添加',
        render_kw={
            "class": "btn btn-primary",
        }
    )


class QuestionForm(FlaskForm):
    """
    添加/编辑试题表单
    """
    context = TextAreaField(
        label="题目",
        description="题目",
        render_kw={
            "rows":"3",
            "class": "form-control",
            "placeholder": "输入题目信息",
        }
    )
    op_a = StringField(
        label="A选项",
        description="选项",
        render_kw={
            "class": "form-control",
            "placeholder": "A选项",
        }
    )
    op_b = StringField(
        label="B选项",
        description="选项",
        render_kw={
            "class": "form-control",
            "placeholder": "B选项",
        }
    )
    op_c = StringField(
        label="C选项",
        description="选项",
        render_kw={
            "class": "form-control",
            "placeholder": "C选项",
        }
    )
    op_d = StringField(
        label="D选项",
        description="选项",
        render_kw={
            "class": "form-control",
            "placeholder": "D选项",
        }
    )
    answer = TextAreaField(
        label="答案",
        description="选项",
        render_kw={
            "rows": "3",
            "class": "form-control",
            "placeholder": "答案",
        }
    )
    state = RadioField(
        label='是否启用',
        description="是否启用",
        coerce=int,
        choices=[(0, '否'), (1, '是')], default=0
    )
    type = SelectField(
        label="类型",
        coerce=int,
        render_kw={
            "class": "form-control",
            "placeholder": "选择类型"
        }
    )
    is_public = RadioField(
        label='是否公开',
        description="是否公开",
        coerce=int,
        choices=[(0, '否'), (1, '是')], default=0
    )
    submit = SubmitField(
        '添加',
        render_kw={
            "class": "btn btn-primary",
        }
    )


class TestForm(FlaskForm):
    """
    添加/编辑试题表单
    """
    test_name = StringField(
        label="试卷名称",
        description="试卷名称",
        render_kw={
            "class": "form-control",
            "placeholder": "输入试卷名称",
        }
    )
    count = StringField(
        label="题目数量",
        description="题目数量",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入题目数量",
        }
    )
    score = StringField(
        label="试卷总分",
        description="试卷总分",
        render_kw={
            "class": "form-control",
            "placeholder": "试卷总分",
        }
    )
    state = RadioField(
        label='是否启用',
        description="是否启用",
        coerce=int,
        choices=[(0, '否'), (1, '是')], default=0
    )
    is_public = RadioField(
        label='是否公开',
        description="是否公开",
        coerce=int,
        choices=[(0, '否'), (1, '是')], default=0
    )
    submit = SubmitField(
        '添加',
        render_kw={
            "class": "btn btn-primary",
        }
    )


class ExamForm(FlaskForm):
    """
    添加/编辑考试表单
    """
    test_id = SelectField(
        label="试卷名称",
        description="试卷名称",
        coerce=int,
        render_kw={
            "class": "form-control",
            "placeholder": "请选择试卷名称",
        }
    )
    time = StringField(
        label="答题时间",
        description="答题时间",
        render_kw={
            "class": "form-control",
            "placeholder": "答题时间(分钟)",
        }
    )
    startTime = DateTimeField(
        label='开始日期',
        render_kw={
            "type":"datetime",
            "class": "form-control datePicker",
            "placeholder": "请输入日期，如:2020-01-01 00:00:00",
            "autocomplete": "off"
        },
    )
    endTime = DateTimeField(
        label='结束日期',
        render_kw={
            "class": "form-control datePicker",
            "placeholder": "请输入日期，如:2020-01-02 00:00:00",
            "autocomplete":"off"
        },
    )
    members = BooleanField(
        label='参考人员'
    )
    submit = SubmitField(
        '添加',
        render_kw={
            "class": "btn btn-primary",
        }
    )
