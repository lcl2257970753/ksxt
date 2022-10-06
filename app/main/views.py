# _*_ coding:utf-8 _*_
# 开发名称：views
# 开发人员：Agoni
# 开发时间:2020/3/12 17:17
# 开发工具：PyCharm

import os, uuid, json, xlrd
from datetime import datetime
from app import db
from . import main
from aip import AipOcr,AipNlp
from flask import render_template, redirect, url_for, flash, session, request, current_app, jsonify
from app.main.forms import LoginForm, RegisterForm, RoleForm, MenuForm, QtForm, QuestionForm, UserForm, TestForm, \
    ExamForm, PwdForm
from app.models import User, Role, Loginlog, Oplog, Menu_role, Sysmenu, Question_type, Question, Test, Test_detail, \
    Examination, ExaminationDetail, Friends, Message, ExaminationResult
from werkzeug.security import generate_password_hash
from werkzeug.utils import secure_filename
from functools import wraps
from app.main.tools import queryToDict
from sqlalchemy import or_, and_, func
from random import sample


# 登录装饰器
def user_login(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "user_id" not in session:
            return redirect(url_for("main.login", next=request.url))
        return f(*args, **kwargs)

    return decorated_function


# 登录功能
@main.route("/login/", methods=["GET", "POST"])
def login():
    form = LoginForm()  # 实例化登录表单
    if form.validate_on_submit():  # 验证提交表单
        data = form.data  # 接收数据
        user = User.query.filter_by(email=data["account"]).first()  # 查找User表数据
        # 判断用户名和密码是否匹配
        if not user:
            flash("用户不存在！", "err")  # 输出错误信息
            return redirect(url_for("main.login"))  # 调回登录页
        if not user.check_pwd(data["pwd"]):
            flash("密码错误!", "err")  # 闪存错误信息
            return redirect(url_for("main.login"))  # 跳转到前台登录页
        # 如果是正确的，就要定义session的会话进行保存。
        role = Role.query.filter_by(id=user.role_id).first()
        session["user"] = user.username  # 存入session
        session["user_id"] = user.id  # 存入session
        session["face"] = user.face  # 头像
        session["role_id"] = role.id  # 角色id
        session["user_role"] = role.rolename  # 用户角色

        # 创建数据
        loginlog = Loginlog(
            user_id=user.id,
            ip=request.remote_addr,
        )
        db.session.add(loginlog)  # 添加数据
        db.session.commit()  # 提交数据
        return redirect(url_for("main.index"))  # 返回后台主页
    return render_template("user/login.html", form=form)


# 注册功能
@main.route("/register/", methods=["GET", "POST"])
def register():
    form = RegisterForm()  # 导入注册表单
    if form.validate_on_submit():  # 提交注册表单
        data = form.data  # 接收表单数据
        # 为User类属性赋值
        user = User(
            username=data["username"],  # 用户名
            email=data["email"],  # 邮箱
            pwd=generate_password_hash(data["pwd"]),  # 对密码加密
            role_id=3  # 默认时普通用户
        )
        db.session.add(user)  # 添加数据
        db.session.commit()  # 提交数据
        flash("注册成功！", "ok")  # 使用flask存储成功信息
    return render_template("user/register.html", form=form)  # 渲染模板


# 退出登录
@main.route("/logout/")
def logout():
    session.pop("user_id", None)
    return redirect(url_for('main.login'))


# 修改密码
@main.route('/pwd/', methods=["GET", "POST"])
@user_login
def pwd():
    form = PwdForm()
    if form.validate_on_submit():
        data = form.data
        user = User.query.filter_by(username=session["user"]).first()
        from werkzeug.security import generate_password_hash
        user.pwd = generate_password_hash(data["new_pwd"])
        db.session.add(user)
        db.session.commit()
        flash("修改密码成功，请重新登录！", "ok")
        return redirect(url_for('main.logout'))
    return render_template("user/pwd.html", form=form)


# 首页
@main.route("/")
@user_login
def index():
    menus = menu_tree(session["role_id"])
    return render_template("main/index.html", menus=menus)


# 主页
@main.route("/home/")
@user_login
def home():
    return render_template('main/home.html')


# 关于我们
@main.route("/about/")
def about():
    return render_template('main/about.html')


def get_file_content(filePath):
    with open(filePath, 'rb') as fp:
        return fp.read()


# 树形目录
@main.route("/menu_tree/", methods=["GET"])
@user_login
def menu_tree(rode_id):
    menusjson = []
    if (rode_id):
        mList_parent = Menu_role.query.join(Sysmenu).filter(Menu_role.rid == rode_id,Sysmenu.state==1, Sysmenu.parent_id == 0).order_by(
            Sysmenu.rank).all()
        for item in mList_parent:
            menus = queryToDict(item.Menu)
            mList_child = Menu_role.query.join(Sysmenu).filter(Menu_role.rid == rode_id,
                                                               Sysmenu.parent_id == item.mid,Sysmenu.state==1,).order_by(
                Sysmenu.rank).all()
            menus_c = []
            for i in mList_child:
                child = queryToDict(i.Menu)
                menus_c.append(child)
            menus["children"] = menus_c
            menusjson.append(menus)
    else:
        mList_parent = Sysmenu.query.filter(Sysmenu.state==1,Sysmenu.parent_id == 0).order_by(Sysmenu.rank).all()
        for item in mList_parent:
            menus = queryToDict(item)
            mList_child = Sysmenu.query.filter(Sysmenu.state==1,Sysmenu.parent_id == item.id).order_by(Sysmenu.rank).all()
            menus_c = []
            for i in mList_child:
                child = queryToDict(i)
                menus_c.append(child)
            menus["children"] = menus_c
            menusjson.append(menus)
    return menusjson


# 添加操作日志
def addOplog(reason):
    oplog = Oplog(
        user_id=session["user_id"],
        ip=request.remote_addr,
        reason=reason
    )
    db.session.add(oplog)
    db.session.commit()


# 登录日志列表
@main.route("/loginlog_list/", methods=["GET"])
@user_login
def loginlog_list(page=None):
    page = request.args.get('page', 1, type=int)  # 获取page参数值
    keyword = request.args.get('keyword', '', type=str)
    if keyword:
        # 根据名称模糊查询
        if session['role_id']==1:
            filters = User.username.like("%" + keyword + "%")
        else :
            filters = and_(Loginlog.user_id==session['user_id'],User.username.like("%" + keyword + "%"))
        page_data = Loginlog.query.filter(
            filters
        ).order_by(
            Loginlog.addtime.desc()
        ).paginate(page=page, per_page=5)
    else:
        if session['role_id']==1:
            page_data = Loginlog.query.order_by(Loginlog.addtime.desc()).paginate(page=page, per_page=5)
        else :
            page_data = Loginlog.query.filter(Loginlog.user_id ==session['user_id']).order_by( Loginlog.addtime.desc()).paginate(page=page, per_page=5)
    return render_template("log/loginlog_list.html", page_data=page_data, keyword=keyword)


# 操作日志管理
@main.route("/oplog_list/", methods=["GET"])
@user_login
def oplog_list():
    page = request.args.get('page', 1, type=int)  # 获取page参数值
    keyword = request.args.get('keyword', '', type=str)
    if keyword:
        # 根据名称模糊查询
        if session['role_id'] == 1:
            filters = and_(User.username.like("%" + keyword + "%"))
        else:
            filters = and_(Oplog.user_id==session['user_id'], User.username.like("%" + keyword + "%"))
        page_data = Oplog.query.filter(
            filters
        ).order_by(
            Oplog.addtime.desc()
        ).paginate(page=page, per_page=5)
    else:
        if session['role_id']==1:
            page_data = Oplog.query.order_by(Oplog.addtime.desc()).paginate(page=page, per_page=5)
        else :
            page_data = Oplog.query.filter( User.id == session['user_id']).order_by(Oplog.addtime.desc()).paginate(page=page, per_page=5)
    return render_template("log/oplog_list.html", page_data=page_data, keyword=keyword)


# 获取唯一名称
def gen_rnd_filename():
    return datetime.now().strftime("%Y%m%d%H%M%S") + str(uuid.uuid4().hex)


# 修改文件名称
def change_filename(filename):
    fileinfo = os.path.splitext(filename)
    filename = gen_rnd_filename() + fileinfo[-1]
    return filename


# 系统目录
@main.route("/menu_list/", methods=["GET"])
@user_login
def menu_list():
    page = request.args.get('page', 1, type=int)  # 获取page参数值
    keyword = request.args.get('keyword', '', type=str)
    if keyword:
        # 根据名称模糊查询
        filters = Sysmenu.menustr.like("%" + keyword + "%")
        page_data = Sysmenu.query.filter(filters).paginate(page=page, per_page=10)
    else:
        page_data = Sysmenu.query.paginate(page=page, per_page=10)
    return render_template("system/menu_list.html", page_data=page_data, keyword=keyword)


# 添加目录
@main.route("/menu_add/", methods=["GET", "POST"])
@user_login
def menu_add():
    form = MenuForm()
    choices = [(v.id, v.menustr) for v in Sysmenu.query.all()]
    form.parent_id.choices = [(0, "无")]
    form.parent_id.choices += choices
    if form.validate_on_submit():
        data = form.data
        sysmenu = Sysmenu(
            menustr=data["menustr"],
            state=data["state"],
            path=data["path"],
            parent_id=data["parent_id"],
            icon=data["icon"],
            rank=data["rank"]
        )
        db.session.add(sysmenu)
        db.session.commit()
        addOplog("添加[" + data["menustr"] + "]目录")
        flash("添加目录成功!", "ok")
        return redirect(url_for('main.menu_list'))  # 页面跳转
    return render_template("system/menu_add.html", form=form)  # 渲染模板


# 编辑目录
@main.route("/menu_edit/<int:id>", methods=["GET", "POST"])
@user_login
def menu_edit(id=None):
    form = MenuForm()
    form.parent_id.choices = [(v.id, v.menustr) for v in Sysmenu.query.all()]
    form.parent_id.choices.insert(0, ("0", "无"))
    form.submit.label.text = "修改"
    sysmenu = Sysmenu.query.get_or_404(id)
    if request.method == "GET":
        form.menustr.data = sysmenu.menustr
        form.state.data = sysmenu.state
        form.path.data = sysmenu.path
        form.parent_id.data = sysmenu.parent_id
        form.icon.data = sysmenu.icon
        form.rank.data = sysmenu.rank
    if form.validate_on_submit():
        data = form.data
        sysmenu.menustr = data["menustr"]
        sysmenu.state = data["state"]
        sysmenu.path = data["path"]
        sysmenu.parent_id = data["parent_id"]
        sysmenu.icon = data["icon"]
        sysmenu.rank = data["rank"]
        db.session.add(sysmenu)
        db.session.commit()
        addOplog("修改[" + sysmenu.menustr + "]信息")
        flash("修改目录成功!", "ok")
        return redirect(url_for('main.menu_list', id=id))  # 页面跳转
    return render_template("system/menu_edit.html", form=form, menu=sysmenu)  # 渲染模板


# 删除目录
@main.route("/menu_del/<int:id>", methods=["GET", "POST"])
@user_login
def menu_del(id=None):
    menu = Sysmenu.query.get_or_404(id)
    db.session.delete(menu)
    db.session.commit()
    flash("目录删除成功", "ok")  # 使用flash存储成功信息
    addOplog("删除[" + menu.menustr + "]目录")  # 添加日志
    return redirect(url_for('main.menu_list', page=1))


# 权限列表
@main.route("/authority_list/", methods=["GET"])
@user_login
def authority_list():
    page = request.args.get('page', 1, type=int)  # 获取page参数值
    keyword = request.args.get('keyword', '', type=str)
    if keyword:
        # 根据名称模糊查询
        filters = and_(Role.id == Menu_role.rid, Sysmenu.id == Menu_role.mid,
                       or_(Sysmenu.menustr.like("%" + keyword + "%"), Role.rolename.like("%" + keyword + "%")))
        page_data = Menu_role.query.join(
            Role, Sysmenu
        ).filter(
            filters
        ).order_by(
            Menu_role.rid, Menu_role.id
        ).paginate(page=page, per_page=10)
    else:
        page_data = Menu_role.query.join(
            Role, Sysmenu
        ).filter(
            Role.id == Menu_role.rid,
            Sysmenu.id == Menu_role.mid
        ).order_by(
            Menu_role.rid, Menu_role.id
        ).paginate(page=page, per_page=10)

    # 合并单元格数据准备
    rows = {}
    index = 1
    for item in page_data.items:
        if item.rid in rows.keys():
            rows.get(item.rid)["count"] = rows.get(item.rid)["count"] + 1
        else:
            rows[item.rid] = {"rid": item.rid, "count": 1, "index": index}
        index += 1

    return render_template("system/authority_list.html", page_data=page_data, keyword=keyword, rows=rows)


# 权限编辑准备
@main.route("/authority_edit/", methods=["GET", "POST"])
@user_login
def authority_edit():
    rid = [(v.id, v.rolename) for v in Role.query.all()]
    menus = menu_tree(None)
    menu_in = {}
    menu_list = Menu_role.query.all()
    for v in menu_list:
        if v.rid in menu_in.keys():
            menu_in[v.rid].append(v.mid)
        else:
            menu_in[v.rid] = []
            menu_in[v.rid].append(v.mid)
    return render_template("system/authority_edit.html", rid=rid, menus=menus, menu_in=menu_in)


# 权限编辑
@main.route("/authority_add/", methods=["GET", "POST"])
@user_login
def authority_add():
    rid = request.values.get("rid")
    Menu_role.query.filter(Menu_role.rid == rid).delete()
    mids = request.values.getlist("mid")
    list = [];
    for mid in mids:
        menu_role = Menu_role(
            rid=rid,
            mid=mid,
        )
        list.append(menu_role)
    db.session.add_all(list)
    db.session.commit()
    addOplog("添加权限")
    flash("添加权限成功!", "ok")
    return redirect(url_for('main.authority_list'))  # 页面跳转


# 删除权限
@main.route("/authority_del/<int:id>", methods=["GET", "POST"])
@user_login
def authority_del(id=None):
    menu_role = Menu_role.query.get_or_404(id)
    db.session.delete(menu_role)
    db.session.commit()
    flash("权限删除成功", "ok")  # 使用flash存储成功信息
    addOplog("删除权限")  # 添加日志
    return redirect(url_for('main.authority_list', page=1))
    return


# 角色列表
@main.route("/role_list/", methods=["GET"])
@user_login
def role_list():
    page = request.args.get('page', 1, type=int)  # 获取page参数值
    keyword = request.args.get('keyword', '', type=str)
    if keyword:
        filters = or_(Role.rolename.like("%" + keyword + "%"))
        page_data = Role.query.filter(filters).paginate(page=page, per_page=10)
    else:
        page_data = Role.query.paginate(page=page, per_page=10)
    return render_template("system/role_list.html", page_data=page_data, keyword=keyword)


# 角色编辑
@main.route("/role_edit/<int:id>", methods=["GET", "POST"])
@user_login
def role_edit(id=None):
    form = RoleForm()
    form.submit.label.text = "修改"
    role = Role.query.get_or_404(id)
    if request.method == "GET":
        form.rolename.data = role.rolename
        form.state.data = role.state
        form.detail.data = role.detail
    if form.validate_on_submit():
        data = form.data
        role.rolename = data["rolename"]
        role.state = data["state"]
        role.detail = data["detail"]
        db.session.add(role)
        db.session.commit()
        addOplog("修改[" + data["rolename"] + "]角色")
        flash("修改角色信息成功!", "ok")
        return redirect(url_for('main.role_list'))  # 页面跳转
    return render_template("system/role_edit.html", form=form, role=role)  # 渲染模板


# 角色添加
@main.route("/role_add/", methods=["GET", "POST"])
@user_login
def role_add():
    form = RoleForm()
    if form.validate_on_submit():
        data = form.data
        role = Role(
            rolename=data["rolename"],
            state=data["state"],
            detail=data["detail"]
        )
        db.session.add(role)
        db.session.commit()
        addOplog("添加[" + data["rolename"] + "]角色")
        flash("添加角色成功!", "ok")
        return redirect(url_for('main.role_list'))  # 页面跳转
    return render_template("system/role_add.html", form=form)  # 渲染模板


# 角色删除
@main.route("/role_del/<int:id>", methods=["GET", "POST"])
@user_login
def role_del(id=None):
    role = Role.query.get_or_404(id)
    db.session.delete(role)
    db.session.commit()
    flash("角色删除成功", "ok")  # 使用flash存储成功信息
    addOplog("删除[" + role.rolename + "]角色")  # 添加日志
    return redirect(url_for('main.menu_list', page=1))


# 用户列表
@main.route("/user_list/", methods=["GET"])
@user_login
def user_list():
    page = request.args.get('page', 1, type=int)  # 获取page参数值
    keyword = request.args.get('keyword', '', type=str)
    if session['role_id'] !=3 :
        if keyword:
            # 根据姓名或者邮箱查询
            filters = or_(User.username == keyword, User.email == keyword, User.phone == keyword)
            page_data = User.query.filter(filters).order_by(
                User.addtime.desc()
            ).paginate(page=page, per_page=10)
        else:
            page_data = User.query.order_by(
                User.addtime.desc()
            ).paginate(page=page, per_page=10)
    else:
        page_data = User.query.filter(User.id==session["user_id"]).order_by(
            User.addtime.desc()
        ).paginate(page=page, per_page=10)
    return render_template("user/user_list.html", page_data=page_data, keyword=keyword)  # 渲染模板


# 用户编辑
@main.route("/user_edit/<int:id>", methods=["GET", "POST"])
@user_login
def user_edit(id=None):
    form = UserForm()
    form.submit.label.text = "修改"
    form.role_id.choices = [(v.id, v.rolename) for v in Role.query.all()]
    user = User.query.get_or_404(id)
    if request.method == "GET":
        form.username.data = user.username
        form.email.data = user.email
        form.phone.data = user.phone
        form.face.data = user.face
        form.info.data = user.info
        form.role_id.data = user.role_id
    if form.validate_on_submit():
        data = form.data
        user.username = data["username"]
        user.email = data["email"]
        user.phone = data["phone"]
        user.info = data["info"]
        user.face = data["face"]
        user.role_id = data["role_id"]
        db.session.add(user)
        db.session.commit()
        addOplog("修改[" + data["username"] + "]用户")
        flash("修改用户信息成功!", "ok")
        return redirect(url_for('main.user_list'))
    return render_template("user/user_edit.html", form=form, user=user)


# 用户添加
@main.route("/user_add/", methods=["GET", "POST"])
@user_login
def user_add():
    form = UserForm()
    form.role_id.choices = [(v.id, v.rolename) for v in Role.query.all()]
    if form.validate_on_submit():
        data = form.data
        file_face = secure_filename(form.face.data.filename)
        if not os.path.exists(current_app.config["FC_DIR"]):
            os.makedirs(current_app.config["FC_DIR"])  # 创建文件夹
            os.chmod(current_app.config["FC_DIR"], "rw")  # 设置权限
        face = change_filename(file_face)  # 更改名称
        form.face.data.save(current_app.config["FC_DIR"] + face)  # 保存文件
        from werkzeug.security import generate_password_hash
        user = User(
            username=data["username"],
            email=data["email"],
            pwd=generate_password_hash('123456'),
            phone=data["phone"],
            info=data["info"],
            face=face,
            role_id=data["role_id"]
        )
        db.session.add(user)
        db.session.commit()
        addOplog("添加[" + data["username"] + "]用户")
        flash("添加用户成功!默认密码123456", "ok")
        return redirect(url_for('main.user_list'))  # 页面跳转
    return render_template("user/user_add.html", form=form)  # 渲染模板


# 用户删除
@main.route("/user_del/<int:id>", methods=["GET", "POST"])
@user_login
def user_del(id=None):
    try:
        user = User.query.get_or_404(id)
        db.session.delete(user)
        db.session.commit()
        flash("用户删除成功", "ok")  # 使用flash存储成功信息
        addOplog("删除[" + user.username + "]用户")  # 添加日志
    except Exception as e:
        flash(f"用户删除失败:{e}", "err")  # 使用flash存储成功信息
    return redirect(url_for('main.user_list', page=1))


# 试题类型列表
@main.route("/qt_list/", methods=["GET"])
@user_login
def qt_list():
    page = request.args.get('page', 1, type=int)  # 获取page参数值
    keyword = request.args.get('keyword', '', type=str)
    user_id = session["user_id"]
    if keyword:
        filters = and_(or_(Question_type.is_public==1,and_(Question_type.is_public==0,Question_type.user_id == user_id)),Question_type.name.like("%" + keyword + "%"))
        page_data = Question_type.query.filter(filters).paginate(page=page, per_page=10)
    else:
        page_data = Question_type.query.filter(or_(Question_type.is_public==1,and_(Question_type.is_public==0,Question_type.user_id == user_id))).paginate(page=page, per_page=10)
    return render_template("question/qt_list.html", page_data=page_data, keyword=keyword)


# 试题类型编辑
@main.route("/qt_edit/<int:id>", methods=["GET", "POST"])
@user_login
def qt_edit(id=None):
    form = QtForm()
    form.submit.label.text = "修改"
    qt = Question_type.query.get_or_404(id)
    if request.method == "GET":
        form.name.data = qt.name
        form.desc.data = qt.desc
        form.is_public.data = qt.is_public
    if form.validate_on_submit():
        data = form.data
        qt.name = data["name"]
        qt.desc = data["desc"]
        qt.is_public = data["is_public"]
        db.session.add(qt)
        db.session.commit()
        addOplog("修改试题信息成功")
        flash("修改试题信息成功!", "ok")
        return redirect(url_for('main.qt_list'))  # 页面跳转
    return render_template("question/qt_edit.html", form=form, qt=qt)  # 渲染模板


# 试题类型添加
@main.route("/qt_add/", methods=["GET", "POST"])
@user_login
def qt_add():
    form = QtForm()
    if form.validate_on_submit():
        data = form.data
        qt_count = Question_type.query.filter_by(name=data['name']).count()
        if qt_count == 1:
            flash("题型已存在！无须在添加", 'err')
            return redirect(url_for('main.qt_add'))
        qt = Question_type(
            name=data["name"],
            desc=data["desc"],
            is_public=data["is_public"],
            user_id=session['user_id']
        )
        db.session.add(qt)
        db.session.commit()
        addOplog("添加[" + data["name"] + "]试题类型")
        flash("添加试题类型成功!", "ok")
        return redirect(url_for('main.qt_list'))  # 页面跳转
    return render_template("question/qt_add.html", form=form)  # 渲染模板


# 试题类型删除
@main.route("/qt_del/<int:id>", methods=["GET", "POST"])
@user_login
def qt_del(id=None):
    qt = Question_type.query.get_or_404(id)
    db.session.delete(qt)
    db.session.commit()
    flash("删除成功", "ok")  # 使用flash存储成功信息
    addOplog("删除[" + qt.name + "]试题类型")  # 添加日志
    return redirect(url_for('main.qt_list', page=1))


# 试题列表
@main.route("/question_list/", methods=["GET"])
@user_login
def question_list():
    page = request.args.get('page', 1, type=int)  # 获取page参数值
    keyword = request.args.get('keyword', '', type=str)
    user_id = session['user_id']
    if keyword:
        filters = and_(or_(and_(Question.state == 1,Question.is_public==1),
                           and_(Question.user_id == user_id,or_(Question.is_public == 0,Question.state==0))),
                       Question.context.like("%" + keyword + "%"))
        page_data = Question.query.filter(filters).order_by((Question.user_id==user_id).desc()).paginate(page=page, per_page=10)
    else:
        filters = or_(and_(Question.state == 1, Question.is_public == 1),
                           and_(Question.user_id == user_id, or_(Question.is_public == 0, Question.state == 0)))
        page_data = Question.query.filter(filters).order_by((Question.user_id==user_id).desc()).paginate(page=page, per_page=10)
    return render_template("question/question_list.html", page_data=page_data, keyword=keyword)


# 试题编辑
@main.route("/question_edit/<int:id>", methods=["GET", "POST"])
@user_login
def question_edit(id=None):
    form = QuestionForm()
    form.type.choices = [(v.id, v.name) for v in Question_type.query.filter(Question_type.is_public == 1).all()]
    form.submit.label.text = "修改"
    question = Question.query.get_or_404(id)
    if request.method == "GET":
        form.context.data = question.context
        form.op_a.data = question.op_a
        form.op_b.data = question.op_b
        form.op_c.data = question.op_c
        form.op_d.data = question.op_d
        form.answer.data = question.answer
        form.state.data = question.state
        form.type.data = question.type
        form.is_public.data = question.is_public
    if form.validate_on_submit():
        data = form.data
        question.context = data["context"]
        question.op_a = data["op_a"]
        question.op_b = data["op_b"]
        question.op_c = data["op_c"]
        question.op_d = data["op_d"]
        question.answer = data["answer"]
        question.state = data["state"]
        question.type = data["type"]
        question.is_public = data["is_public"]
        db.session.add(question)
        db.session.commit()
        addOplog("修改试题信息成功")
        flash("修改系统信息成功!", "ok")
        return redirect(url_for('main.question_list'))  # 页面跳转
    return render_template("question/question_edit.html", form=form, question=question)  # 渲染模板


# 题目添加页
@main.route("/question_add_html/", methods=["GET", "POST"])
@user_login
def question_add_html():
    type = request.args.get('type')
    if type == "1":
        return render_template("question/question_add2.html")
    else:
        return render_template("question/question_add_html.html")


# 手动添加题目
@main.route("/question_add/", methods=["GET", "POST"])
@user_login
def question_add():
    form = QuestionForm()
    form.type.choices = [(v.id, v.name) for v in Question_type.query.filter(Question_type.is_public == 1).all()]
    if form.validate_on_submit():
        data = form.data
        question = Question(
            context=data["context"],
            op_a=data["op_a"],
            op_b=data["op_b"],
            op_c=data["op_c"],
            op_d=data["op_d"],
            answer=data["answer"],
            state=data["state"],
            type=data["type"],
            is_public=data["is_public"],
            user_id=session['user_id']
        )
        db.session.add(question)
        db.session.commit()
        addOplog("添加试题")
        flash("添加试题成功!", "ok")
        return redirect(url_for('main.question_list'))  # 页面跳转
    return render_template("question/question_add.html", form=form)  # 渲染模板


# 批量添加试题
@main.route("/importQT/", methods=["GET", "POST"])
@user_login
def importQT():
    datas = json.loads(request.get_data())
    questions = []
    for data in datas:
        try:
            op_a = data["answer1"]
        except:
            op_a = ""
        try:
            op_b = data["answer2"]
        except:
            op_b = ""
        try:
            op_c = data["answer3"]
        except:
            op_c = ""
        try:
            op_d = data["answer4"]
        except:
            op_d = ""
        try:
            analysis = data['analysis']
        except:
            analysis = ""
        try:
            difficult = data['difficult'],
        except:
            difficult = ""
        question = Question(
            context=data["question"],
            op_a=op_a,
            op_b=op_b,
            op_c=op_c,
            op_d=op_d,
            answer=data["key"],
            analysis=analysis,
            type=data["type"],
            difficult=difficult,
            user_id=session['user_id']
        )
        questions.append(question)
    db.session.add_all(questions)
    db.session.commit()
    return str(len(questions))


# 上传图片并识别文字
@main.route("/uploadPic/", methods=["GET", "POST"])
@user_login
def uploadPic():
    file = request.files['file']
    client = AipOcr("19349052", "zMmuGapmixFb7EadTd9mGkml", "otYt6L9yR9bOOyFiVzMHIIdiDGbsi2nE")  # 百度AI
    image = file.stream.read()
    options = {}
    options["detect_direction"] = "true"
    content = client.basicAccurate(image, options)
    return render_template("question/question_add3.html", content=content)  # 渲染模板


# 上传Excel并导入
@main.route("/uploadExcel/", methods=["POST"])
@user_login
def uploadExcel():
    file = request.files['file']
    f = file.read()  # 文件内容
    data = xlrd.open_workbook(file_contents=f)
    names = data.sheet_names()  # 返回book中所有工作表的名字
    questions = []
    for name in names:
        if name == "单选题":
            type = 1
        elif name == "多选题":
            type = 2
        elif name == "判断题":
            type = 3
        elif name == "填空题":
            type = 4
        elif name == "简答题":
            type = 5
        else:
            type = None
        if (data.sheet_loaded(name) and type != None):  # 检查sheet是否导入完毕,并且判断是否是可导入的题型
            table = data.sheet_by_name(name)
            nrows = table.nrows  # 获取该sheet中的有效行数
            for i in range(1, nrows):
                row = table.row_values(i)  # 获取行列数据
                if type == 1 or type == 2:
                    question = Question(
                        context=row[0],
                        op_a=row[1],
                        op_b=row[2],
                        op_c=row[3],
                        op_d=row[4],
                        answer=row[5],
                        analysis=row[6],
                        difficult=row[7],
                        state=transform(row[8], 1),
                        is_public=transform(row[9], 0),
                        type=type,
                        user_id=session['user_id']
                    )
                elif type == 3:
                    question = Question(
                        context=row[0],
                        answer=transform(row[1], 0),
                        analysis=row[2],
                        difficult=row[3],
                        state=transform(row[4], 1),
                        is_public=transform(row[5], 0),
                        type=type,
                        user_id=session['user_id']
                    )
                else:
                    question = Question(
                        context=row[0],
                        answer=row[1],
                        analysis=row[2],
                        difficult=row[3],
                        state=transform(row[4], 1),
                        is_public=transform(row[5], 0),
                        type=type,
                        user_id=session['user_id']
                    )
                questions.append(question)
    db.session.add_all(questions)
    db.session.commit()
    return jsonify(len(questions))


def transform(context, num):
    if context == "是" or context == "对":
        num = 1
    elif context == "否" or context == '错':
        num = 0
    elif context == None:
        num = num
    return num


# 试题删除
@main.route("/question_del/<int:id>", methods=["GET", "POST"])
@user_login
def question_del(id=None):
    question = Question.query.get_or_404(id)
    db.session.delete(question)
    db.session.commit()
    flash("试题删除成功", "ok")
    addOplog("删除试题")
    return redirect(url_for('main.question_list', page=1))


# 试卷列表
@main.route("/test_list/", methods=["GET"])
@user_login
def test_list():
    page = request.args.get('page', 1, type=int)
    keyword = request.args.get('keyword', '', type=str)
    user_id = session['user_id']
    if keyword:
        filters = and_(or_(and_(Test.state == 1,Test.is_public==1),
                           and_(Test.user_id == user_id,or_(Test.is_public == 0,Test.state==0))),
                       Test.test_name.like("%" + keyword + "%"))
        page_data = Test.query.filter(filters).paginate(page=page, per_page=10)
    else:
        filters = or_(and_(Test.state == 1, Test.is_public == 1),
                      and_(Test.user_id == user_id, or_(Test.is_public == 0, Test.state == 0)))
        page_data = Test.query.filter(filters).paginate(page=page, per_page=10)
    return render_template("test/test_list.html", page_data=page_data, keyword=keyword)


# 题目添加页
@main.route("/test_add_html/", methods=["GET", "POST"])
@user_login
def test_add_html():
    type = request.args.get('type')
    if type == "1":
        return render_template("test/test_add.html")
    else:
        filters = and_(Question.user_id == User.id, Question.state == 1, Question.type == Question_type.id,
                       or_(and_(Question.user_id == User.id, Question.is_public == 0), Question.is_public == 1))
        result = Question.query.with_entities(Question.id).filter(filters).all()
        total = len(result)
        return render_template("test/test_add_html.html", total=total)


# 试题数据
@main.route("/getResource/", methods=["GET", "POST"])
@user_login
def getResource():
    page = request.values.get('page', 1, type=int)
    filters = and_(Question.user_id == User.id, Question.state == 1, Question.type == Question_type.id,
                   or_(and_(Question.user_id == User.id, Question.is_public == 0), Question.is_public == 1))
    page_data = Question.query.with_entities(Question.id, Question.context, Question.op_a, Question.op_b, Question.op_c,
                                             Question.op_d, Question.answer, User.username,
                                             Question_type.name).filter(filters).paginate(page=page, per_page=10)
    data = {}
    data["has_next"] = page_data.has_next
    data["has_prev"] = page_data.has_prev
    data["items"] = queryToDict(page_data.items)
    data["next_num"] = page_data.next_num
    data["page"] = page_data.page
    data["pages"] = page_data.pages
    data["per_page"] = page_data.per_page
    data["prev_num"] = page_data.prev_num
    data["total"] = page_data.total
    test = jsonify(data)
    return test


# 试卷添加
@main.route("/test_add/", methods=["GET", "POST"])
@user_login
def test_add():
    test_name = request.values.get('test_name', type=str)
    state = request.values.get('state', type=int)
    is_public = request.values.get('is_public', type=int)
    score = request.values.get('score', type=int)
    questionIds = request.values.getlist('questionIds[]')
    scores = request.values.getlist('scores[]')
    id_score = dict(zip(questionIds, scores))
    test = Test(
        test_name=test_name,
        state=state,
        is_public=is_public,
        score=score,
        user_id=session['user_id'],
        count=len(id_score)
    )
    db.session.add(test)
    db.session.flush()
    list = []
    for key, value in id_score.items():
        test_detail = Test_detail(
            test_id=test.id,
            question_id=key,
            score=value
        )
        list.append(test_detail)
    db.session.add_all(list)
    db.session.commit()
    addOplog("创建[" + test.test_name + "]试题")
    return "ok"  # 页面跳转


# 随机组题试卷添加
@main.route("/test_add2/", methods=["GET", "POST"])
@user_login
def test_add2():
    count = request.values.get('count', type=int)
    filters = and_(Question.user_id == User.id, Question.state == 1, Question.type == Question_type.id,
                   or_(and_(Question.user_id == User.id, Question.is_public == 0), Question.is_public == 1))
    questions = Question.query.with_entities(Question.id, Question.context, Question_type.name,
                                             Question_type.id).filter(filters).all()
    results = sample(questions, count)
    return render_template("test/test_add2.html", results=results)


# 试卷编辑
@main.route("/test_edit_html/<int:id>", methods=["GET", "POST"])
@user_login
def test_edit_html(id=None):
    test = Test.query.get_or_404(id)
    filters = and_(Test_detail.test_id == id, Test_detail.question_id == Question.id, Question_type.id == Question.type)
    test_details = Test_detail.query.with_entities(Question.id, Question.context, Question_type.name, Test_detail.score,
                                                   Question_type.id).filter(filters).all()
    return render_template("test/test_edit.html", test=test, results=test_details)  # 渲染模板


# 试卷编辑
@main.route("/test_edit/", methods=["GET", "POST"])
@user_login
def test_edit():
    id = request.values.get('id', type=int)
    test = Test.query.get_or_404(id)
    test_name = request.values.get('test_name', type=str)
    state = request.values.get('state', type=int)
    is_public = request.values.get('is_public', type=int)
    score = request.values.get('score', type=int)
    questionIds = request.values.getlist('questionIds[]')
    scores = request.values.getlist('scores[]')
    id_score = dict(zip(questionIds, scores))

    test.test_name = test_name
    test.state = state
    test.is_public = is_public
    test.score = score
    test.user_id = session['user_id']
    test.count = len(id_score)

    db.session.add(test)
    db.session.flush()
    del_detail = Test_detail.query.filter(Test_detail.test_id == id).all()
    [db.session.delete(u) for u in del_detail]
    db.session.flush()
    list = []
    for key, value in id_score.items():
        test_detail = Test_detail(
            test_id=id,
            question_id=key,
            score=value
        )
        list.append(test_detail)
    db.session.add_all(list)
    db.session.commit()
    return "ok"  # 页面跳转


# 试卷删除
@main.route("/test_del/<int:id>", methods=["GET", "POST"])
@user_login
def test_del(id=None):
    test = Test.query.get_or_404(id)
    del_detail = Test_detail.query.filter(Test_detail.test_id == id).all()
    [db.session.delete(u) for u in del_detail]
    db.session.delete(test)
    db.session.commit()
    flash("试题删除成功", "ok")
    addOplog("删除试题")
    return redirect(url_for('main.test_list', page=1))


# 考试列表
@main.route("/exam_list/", methods=["GET"])
@user_login
def exam_list():
    page = request.args.get('page', 1, type=int)
    keyword = request.args.get('keyword', '', type=str)
    user_id = session['user_id']
    if keyword:
        filters = and_(Examination.test_id == Test.id, Examination.is_join == 1, Examination.to_user == user_id,
                       or_(Test.test_name.like("%" + keyword + "%")))
        page_data = Examination.query.join(Test).filter(filters).paginate(page=page, per_page=10)
    else:
        page_data = Examination.query.join(Test).filter(Examination.test_id == Test.id, Examination.is_join == 1,
                                                        Examination.to_user == user_id).paginate(page=page, per_page=10)
    return render_template("exam/exam_list.html", page_data=page_data, keyword=keyword,nowTime = datetime.now())


# 创建考试
@main.route("/exam_add/", methods=["GET", "POST"])
@user_login
def exam_add():
    form = ExamForm()
    user_id = session["user_id"]
    form.test_id.choices = [(v.id, v.test_name) for v in
                            Test.query.filter(Test.state == 1, or_(and_(Test.is_public == 0, Test.user_id == user_id),
                                                                   Test.is_public == 1)).all()]
    members = Friends.query.with_entities(User.id, User.username).filter(Friends.friend_id == User.id,
                                                                         Friends.self_id == user_id).all()
    if form.validate_on_submit():
        data = form.data
        test = Test.query.get_or_404(data["test_id"])
        members = request.values.getlist('members')
        exam = Examination(
            test_id=data["test_id"],
            startTime=data["startTime"],
            endTime=data["endTime"],
            count=(Test.query.with_entities(Test.count).filter(Test.id == data["test_id"]).first()).count,
            time=data["time"],
            from_user=session['user_id'],
            to_user=session['user_id'],
            is_join=1
        )
        db.session.add(exam)
        db.session.flush()
        messages = []
        for member in members:
            exam = Examination(
                test_id=data["test_id"],
                startTime=data["startTime"],
                endTime=data["endTime"],
                count=(Test.query.with_entities(Test.count).filter(Test.id == data["test_id"]).first()).count,
                time=data["time"],
                from_user=session['user_id'],
                to_user=member
            )
            db.session.add(exam)
            db.session.flush()

            message = Message(
                to_user=member,
                from_user=session["user_id"],
                context=session['user'] + '邀您参加<a class="err" href="/join_exam/' + str(exam.id) + '">' + test.test_name + '</a>，点击考试参加'
            )
            messages.append(message)
        db.session.add_all(messages)
        db.session.commit()
        addOplog("添加考试")
        flash("添加考试成功!", "ok")
        return redirect(url_for('main.exam_list'))
    return render_template("exam/exam_add.html", form=form, members=members)


# 考试
@main.route("/join_exam/<int:id>", methods=["GET", "POST"])
@user_login
def join_exam(id=None):
    exam = Examination.query.get_or_404(id)
    exam.is_join = 1
    db.session.add(exam)
    db.session.commit()
    return redirect(url_for("main.exam_list"))


# 考试
@main.route("/paper/", methods=["GET", "POST"])
@user_login
def paper():
    id=request.values.get("id",type=int)
    exam = Examination.query.get_or_404(id)
    questions = Test_detail.query.filter(Test_detail.test_id == exam.test_id).all()
    return render_template("exam/paper.html", exam=exam, questions=questions)


# 保存答案
@main.route("/postanswer/", methods=["GET", "POST"])
@user_login
def postanswer():
    examdetails = request.get_json()
    exams = []
    for examdetail in examdetails:
        data = json.loads(s=json.dumps(examdetail))
        question = Question.query.filter(Question.id == data['question_id']).first()
        detail = ExaminationDetail(
            test_id=data["test_id"],
            question_id=data['question_id'],
            score=data["score"],
            answer_post=data["answer_post"],
            unique_id=data["unique_id"],
            answer=question.answer
        )
        #语义匹对
        #语义匹对小于0.9 且两者答案不一致
        if data['type']==1 or data['type'] == 2:
            if detail.answer_post == question.answer:
                detail.score = detail.score
                detail.is_true = 1
            else:
                detail.score = 0
                detail.is_true = 0
        else :
            client = AipNlp("19710337", "BpykpHp1GxO5BUF1sMTd5tGp", "ecoHICOhB5pSRGIQupFwoUG5UcTNOMiD")  # 百度AI
            result = client.simnet(detail.answer_post, question.answer).get('score')
            if result>0.9:
                detail.score = detail.score
                detail.is_true = 1
            else:
                detail.score = 0
                detail.is_true = 0
        exams.append(detail)
    db.session.add_all(exams)
    db.session.commit()
    return str(len(exams))


# 计算成绩
@main.route("/getScore/", methods=["GET", "POST"])
@user_login
def getScore():
    unique_id = request.values.get('unique_id', type=str)
    exam_id = request.values.get('exam_id', type=int)
    time = request.values.get('time', type=int)
    count = request.values.get('count', type=int)
    scores = db.session.query(func.sum(ExaminationDetail.score).label("scores")).filter(
        ExaminationDetail.unique_id == unique_id).scalar()
    exam = Examination.query.get_or_404(exam_id)
    examResult = ExaminationResult(
        unique_id=unique_id,
        to_user=exam.to_user,
        from_user=exam.from_user,
        test_name=exam.test_id,
        count=count,
        time=time,
        score=scores
    )
    db.session.add(examResult)
    db.session.commit()
    return str(scores.real)


# 考试结果
@main.route("/examResult_list/", methods=["GET", "POST"])
@user_login
def examResult_list():
    page = request.args.get('page', 1, type=int)
    keyword = request.args.get('keyword', '', type=str)
    user_id = session["user_id"]
    if keyword:
        filters = and_(ExaminationResult.test_name == Test.id, ExaminationResult.to_user == user_id,
                       or_(Test.test_name.like("%" + keyword + "%")))
        page_data = ExaminationResult.query.filter(filters).order_by(ExaminationResult.unique_id.desc()).paginate(
            page=page, per_page=10)
    else:
        page_data = ExaminationResult.query.filter(ExaminationResult.to_user == user_id).order_by(ExaminationResult.unique_id.desc()).paginate(
            page=page, per_page=10)
    return render_template("exam/examResult_list.html", page_data=page_data, keyword=keyword)


# 错题库
@main.route("/examResult/", methods=["GET", "POST"])
@user_login
def examResult():
    unique_id = request.values.get('unique_id', type=str)
    exam = ExaminationResult.query.filter(ExaminationResult.unique_id==unique_id).first();
    examList = ExaminationDetail.query.filter(ExaminationDetail.unique_id == unique_id).all()
    return render_template("exam/examResult.html", exam = exam,examList=examList)


# 好友列表
@main.route("/friend_list/", methods=["GET", "POST"])
@user_login
def friend_list():
    page = request.args.get('page', 1, type=int)
    keyword = request.args.get('keyword', '', type=str)
    user_id = session["user_id"]
    if keyword:
        page_data = Friends.query.filter(Friends.self_id == user_id,
                                         Friends.friend.username.like("%" + keyword + "%")).paginate(page=page,
                                                                                                     per_page=10)
    else:
        page_data = Friends.query.filter(Friends.self_id == user_id).paginate(page=page, per_page=10)
    return render_template("user/friend_list.html", page_data=page_data, keyword=keyword)


# 删除好友
@main.route("/friend_del/<int:self_id>&<int:friend_id>", methods=["GET", "POST"])
@user_login
def friend_del(self_id=None, friend_id=None):
    filters = or_(and_(Friends.self_id == self_id, Friends.friend_id == friend_id),
                  and_(Friends.self_id == friend_id, Friends.friend_id == self_id))
    friends = Friends.query.filter(filters).all()
    for friend in friends:
        db.session.delete(friend)
    db.session.commit()
    flash("删除好友成功", "ok")
    return redirect(url_for('main.friend_list', page=1))


# 查找用户
@main.route("/findUser/", methods=["GET", "POST"])
@user_login
def findUser():
    info = request.values.get('info')
    user_id = session["user_id"]
    filters = and_(User.id != user_id, or_(User.username == info, User.email == info, User.phone == info))
    users = User.query.with_entities(User.id, User.username, User.email, User.phone, User.face).filter(filters).all()
    if len(users) == 0:
        return "err"
    return jsonify(users)


# 好友添加页面
@main.route("/friend_add/", methods=["GET", "POST"])
@user_login
def friend_add():
    friend_id = request.values.get("id", type=int)
    friend = Friends.query.filter(Friends.self_id==session["user_id"],Friends.friend_id==friend_id).first();
    if friend:
        return 'err'
    friends = []
    friend = Friends(
        self_id=session["user_id"],
        friend_id=friend_id
    )
    friends.append(friend)
    friend2 = Friends(
        self_id=friend_id,
        friend_id=session["user_id"]
    )
    friends.append(friend2)
    db.session.add_all(friends)
    db.session.commit()
    return "ok"


# 消息管理
@main.route("/message/", methods=["GET", "POST"])
@user_login
def message():
    page = request.args.get('page', 1, type=int)
    keyword = request.args.get('keyword', '', type=str)
    user_id = session["user_id"]
    filters = and_(Message.to_user == user_id, Message.from_user == User.id,
                   or_(User.username.like("%" + keyword + "%"),
                       Message.context.like("%" + keyword + "%")))
    if keyword:
        page_data = Message.query.filter(filters).order_by(Message.is_read,Message.addtime.desc()).paginate(page=page, per_page=10)
    else:
        page_data = Message.query.filter(Message.to_user == user_id).order_by(Message.is_read,Message.addtime.desc()).paginate(
            page=page, per_page=10)
    return render_template("user/message_list.html", page_data=page_data, keyword=keyword)


# 获得消息管理
@main.route("/getMessage/", methods=["GET", "POST"])
@user_login
def getMessage():
    is_read = request.values.get('is_read', type=int)
    user_id = session["user_id"]
    messages = Message.query.with_entities(Message.id, Message.context, User.username, User.face,
                                           func.date_format(Message.addtime, "%Y-%m-%d %H:%i:%s")). \
        filter(Message.to_user == user_id, Message.is_read == is_read, Message.from_user == User.id).all()
    return jsonify(messages)


# 获得消息详情
@main.route("/getMessageDetail/<int:id>", methods=["GET", "POST"])
@user_login
def getMessageDetail(id=None):
    message = Message.query.get_or_404(id)
    message.is_read = 1
    db.session.add(message)
    db.session.commit()
    return render_template("user/message_detail.html", message=message)


# 删除消息管理
@main.route("/delMessage/<int:id>", methods=["GET", "POST"])
@user_login
def delMessage(id=None):
    message = Message.query.get_or_404(id)
    db.session.delete(message)
    db.session.commit()
    flash("删除成功！", "ok")
    return redirect(url_for('main.message', page=1))


# 报表管理
@main.route("/statement/", methods=["GET", "POST"])
@user_login
def statement():
    user_id = session['user_id']
    result = {}
    state = 0
    is_public = 0
    tests = Test.query.filter(Test.user_id == user_id).all()
    test_ids = []
    for test in tests:
        test_ids.append(test.id)
        if test.state == 1:
            state += 1
        if test.is_public == 1:
            is_public += 1
    exams = Examination.query.filter(Examination.test_id.in_(test_ids)).all()
    exams_not_null = Examination.query.with_entities(Examination.id).filter(
        and_(Examination.test_id.in_(test_ids), Examination.is_join != 0)).all()
    exams_self = ExaminationResult.query.filter(ExaminationResult.to_user == user_id).all()
    exams_result = db.session.query(func.max(ExaminationResult.score).label("max"),
                                    func.min(ExaminationResult.score).label("min"),
                                    func.avg(ExaminationResult.score).label("avg")).filter(
        ExaminationResult.to_user == user_id).all()
    result['test_count'] = len(tests)
    result['state'] = state
    result['is_public'] = is_public
    result['exams'] = len(exams)
    result['exams_not_null'] = len(exams_not_null)
    try:
        result['exams_percent'] = '{:.2%}'.format(float(len(exams_not_null)) / float(len(exams)))
    except:
        result['exams_percent'] = 0
    result['exams_self'] = len(exams_self)
    result['score_max'] = exams_result[0].max
    result['score_min'] = exams_result[0].min
    result['score_avg'] = exams_result[0].avg
    result['Date'] = datetime.now().date()
    result['myExam_xAxis'] = []
    result['myExam_yAxis'] = []
    for exam in exams_self:
        result['myExam_xAxis'].append(exam.test.test_name)
        result['myExam_yAxis'].append(exam.score)
    result2 = myTest()
    result3 = myTests()
    return render_template("exam/statement.html", result=result, result2=result2, result3=result3, )


# 考试报表总计
def myTests():
    user_id = session['user_id']
    result = {}
    exams_result = db.session.query(Test.test_name, func.max(ExaminationResult.score).label("max"),
                                    func.min(ExaminationResult.score).label("min"),
                                    func.avg(ExaminationResult.score).label("avg")).filter(
        ExaminationResult.from_user == user_id, ExaminationResult.test_name == Test.id).group_by(
        ExaminationResult.test_name).all()

    result['myTests_xAxis'] = []
    result['myTests_Max'] = []
    result['myTests_Min'] = []
    result['myTests_avg'] = []
    for exam in exams_result:
        result['myTests_xAxis'].append(exam.test_name)
        result['myTests_Max'].append(exam.max)
        result['myTests_Min'].append(exam.min)
        result['myTests_avg'].append(float(exam.avg))
    return result


# 考试报表单试卷
def myTest():
    user_id = session['user_id']
    exams_result = ExaminationResult.query.filter(
        ExaminationResult.from_user == user_id, ExaminationResult.test_name == Test.id).all()
    result = {}
    for exam in exams_result:
        try:
            result[exam.test_name]['myTest_xAxis'].append(exam.user.username)
            result[exam.test_name]['myTest_yAxis'].append(exam.score)
        except:
            result[exam.test_name] = {}
            result[exam.test_name]['myTest_xAxis'] = []
            result[exam.test_name]['myTest_yAxis'] = []
            result[exam.test_name]['test_name'] = exam.test.test_name
            result[exam.test_name]['myTest_xAxis'].append(exam.user.username)
            result[exam.test_name]['myTest_yAxis'].append(exam.score)
    return result
