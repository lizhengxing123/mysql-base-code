# insert 优化

-- 1、批量插入，每次插入不超过1000条
-- insert into tb_user values (),(),()

-- 2、手动事务提交
start transaction;
-- insert into tb_user values (),(),()
-- insert into tb_user values (),(),()
-- ...
commit;

-- 3、主键顺序插入

# 大批量数据插入
-- 使用 load 命令

-- 1、客户端连接数据库时，需要加上参数 --local-infile
-- mysql --local-infile -u root -p
-- 2、设置全局参数 local_infile = 1，表示开启从本地加载文件导入数据
set global local_infile = 1;
-- 3、执行 load 命令
load data local infile 'D:/tb_user.csv'
into table tb_user
fields terminated by ','
lines terminated by '\n';
