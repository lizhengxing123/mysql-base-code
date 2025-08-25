# 索引语法

# 1、创建索引
-- create index 索引名 on 表名 (字段名);
create index idx_user_name on tb_user (name);

create unique index idx_user_phone on tb_user (phone);

create index idx_user_pro_age_sta on tb_user (profession, age, status);

create index idx_user_email on tb_user(email);

# 2、删除索引
-- drop index 索引名 on 表名;
drop index idx_user_email on tb_user;

# 3、查看索引
-- show index from 表名;
show index from tb_user;

