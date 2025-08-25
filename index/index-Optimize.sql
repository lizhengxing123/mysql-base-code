# 性能优化

# 1、查看数据库访问频次
show global status like 'Com_______';

# 2、慢查询日志
# 2.1 查看慢查询日志功能是否开启
show global variables like 'slow_query_log';
# 2.2 如果要开启，需要在 /etc/my.cnf 配置文件中添加如下配置
# 开启慢查询日志
-- slow_query_log = 1
# 设置慢查询阈值，单位为秒
-- long_query_time = 2
# 设置慢查询日志文件路径
-- slow_query_log_file = /var/log/mysql/slow.log

# 3、profile
# 3.1 查看数据库是否支持profile
select @@have_profiling;
# 3.2 查看profile功能是否开启
select @@profiling;

# 3.3 开启profile
set @@profiling = 1;

select *
from tb_user;

select *
from tb_user
where status = 0;

# 3.4 查看profile信息
show profiles;

# 3.5 查看profile详情
show profile for query 1;

# 3.6 查看cpu详情
show profile cpu for query 1;


# 4、explain执行计划
# 4.1 查看执行计划
explain select * from tb_user;

# 4.2 每一列的含义
-- id：表示表结构的查询顺序，id越大，越先执行，id相同，按顺序执行
-- select_type：表示查询类型，常见的有
    -- SIMPLE：简单查询，不包含子查询、union等
    -- PRIMARY：主查询，最外层的查询
    -- SUBQUERY：子查询
    -- UNION：union查询
-- type：表示查询的类型，性能从好到差为：
    -- null：不访问任何表
    -- system：访问系统表
    -- const：主键或唯一索引扫描
    -- eq_ref：唯一索引扫描
    -- ref：非唯一索引扫描
    -- range：范围扫描
    -- index：索引扫描
    -- ALL：全表扫描
-- possible_keys：表示可能使用的索引
-- key：表示实际使用的索引
-- key_len：表示索引的长度
-- ref：表示索引的引用
-- rows：表示扫描的行数
-- filtered：表示返回结果的行数占扫描行数的百分比，数值越大越好
-- Extra：表示额外的信息
