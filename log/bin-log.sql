# 二进制日志
-- 二进制日志，记录了所有的 DDL 和 DML 语句，用于数据恢复和主从复制
-- 查看二进制日志
show variables like '%log_bin%';

-- 日志格式
-- 1、STATEMENT
    -- 基于sql语句的日志记录，记录的是sql语句，占用空间小，对数据进行修改的sql语句都会记录
-- 2、ROW
    -- 基于行的日志记录，记录的是每一行数据的变化，占用空间大（默认）
-- 3、MIXED
    -- 混合模式，根据语句的类型，选择 statement 或 row 模式

show variables like '%binlog_format%';

-- 查看二进制日志
-- mysqlbinlog [参数选项] [文件名称]
-- 参数选项有：
-- --base64-output=DECODE_OUTPUT
    -- 1、-d：指定数据库，只列出指定数据库的相关操作
    -- 2、-o：忽略掉日志中前n行命令
    -- 3、-v：将行事件（数据变更）转换为sql语句
    -- 4、-w：将行事件（数据变更）转换为sql语句，并输出注释信息

-- 日志删除
-- 1、删除全部日志
reset master;

-- 2、删除编号之前的日志
purge master logs to 'binlog.000002';

-- 3、删除日期之前的日志
purge master logs before '2023-01-01 00:00:00';
