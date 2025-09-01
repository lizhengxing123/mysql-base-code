# 主从复制
-- 主从复制是指将主数据库的DDL和DML操作通过二进制日志传到从数据库中，
-- 从数据库通过读取二进制日志，重做这些操作，从而实现主从数据的一致。

-- MYSQL支持一台主库同时向多台从库进行复制，从库也可以作为其他从库的主库，实现链状复制

-- 优点：
-- 1、主库故障时，可以快速切换到从库，实现高可用
-- 2、实现读写分离，降低主库访问压力
-- 3、可以在从库中进行备份，以避免备份期间影响主库服务

-- 原理
-- 1、主库的数据变更都记录在二进制日志中
-- 2、从库通过连接主库，获取主库的二进制日志，写入到从库的中继日志中
-- 3、从库重做中继日志中的事件，保持数据一致

-- 配置
-- https://www.bilibili.com/video/BV1Kr4y1i7ru?spm_id_from=333.788.player.switch&vd_source=97e4871747b6e43793eaa0ddb1bb5191&p=161

-- 0、前提：需要两台mysql服务器
-- 0.1 开放3306端口
-- firewall-cmd --zone=public --add-port=3306/tcp --permanent
-- 0.2 重启防火墙
-- firewall-cmd --reload

-- 1、主库配置
-- 1.1 修改配置文件
# mysql服务id，保证整个集群环境中唯一，范围 1~2^32-1，默认为1
-- server-id=1
# 是否只读，1为只读，0为读写
-- read-only=0
# 不需要同步的数据库
-- binlog-ignore-db=mysql
# 需要同步的数据库
-- binlog-do-db=test

-- 1.2 重启mysql服务
-- systemctl restart mysqld

-- 1.3 登录主库，创建远程连接的账号，并授予主从复制的权限
-- 登录主库
-- mysql -u root -p
-- 创建账号
-- create user 'slave'@'%' identified with mysql_native_password by '123456';
-- 授予主从复制的权限
-- grant replication slave on *.* to 'slave'@'%';
-- 刷新权限
-- flush privileges;

-- 1.4 查看二进制日志坐标
show master status;
-- file: 从哪个文件开始推送
-- position: 从文件哪个位置开始推送
-- binlog_ignore_db：指定不需要同步的数据库
-- binlog_do_db：指定需要同步的数据库

-- 2、从库配置
-- 2.1 修改配置文件
# mysql服务id，保证整个集群环境中唯一，范围 1~2^32-1，默认为1
-- server-id=2
# 是否只读，1为只读，0为读写
-- read-only=1
# 超级管理员权限，1为只读，0为读写
-- super-read-only=1

-- 2.2 重启mysql服务
-- systemctl restart mysqld

-- 2.3 登录从库，设置主库配置
-- 登录从库
-- mysql -u root -p
-- 设置主库配置
-- 8.0.23 之后的语法
-- change replication source to source_host='192.168.1.10', source_user='slave', source_password='123456', source_log_file='mysql-bin.000001', source_log_pos=156;
-- 8.0.23 之前的语法
change master to master_host='192.168.1.10', master_user='slave', master_password='123456', master_log_file='mysql-bin.000001', master_log_pos=156, master_port=3306;

-- 2.4 启动从库复制线程
-- start slave; # 8.0.22 之前
-- start replica; # 8.0.22 之后

-- 2.5 查看从库复制状态
-- show slave status; # 8.0.22 之前
-- show replica status; # 8.0.22 之后