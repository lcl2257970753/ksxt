import multiprocessing

bind = '127.0.0.1:5000'
workers = multiprocessing.cpu_count() * 2 + 1

backlog = 2048
worker_class = "gevent"
worker_connections = 1000
daemon = True
debug = True
proc_name = 'question'
pidfile = './log/gunicorn.pid'
errorlog = './log/gunicorn.log'
