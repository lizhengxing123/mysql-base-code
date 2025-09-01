# 慢查询日志
-- 慢查询日志，记录了所有的慢查询操作
show variables like '%slow_query_log%';
show variables like '%long_query_time%';

-- 默认情况下，不会记录管理语句，也不会记录不使用索引进行查找的查询
-- 可以通过设置参数来开启记录
set global log_slow_admin_statements = 1;
set global log_queries_not_using_indexes = 1;
