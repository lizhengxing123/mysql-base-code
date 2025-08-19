-- 查看所有表
show tables;

-- 创建表
create table if not exists t1
(
    id   int comment '主键',
    name varchar(20) comment '姓名',
    age  int comment '年龄',
    sex  char(1) comment '性别'
) comment '表1';

-- 查询表结构
desc t1;

-- 查看建表语句
show create table t1;

-- 删除表
drop table if exists t1;


create table if not exists emp
(
    id         int comment '编号',
    work_no    varchar(10) comment '工号',
    name       varchar(10) comment '姓名',
    age        tinyint unsigned comment '年龄',
    sex        char(1) comment '性别',
    id_card    char(18) comment '身份证号',
    entry_date date comment '入职日期'
) comment '员工表';

-- 新增字段
alter table emp add nickname varchar(20) comment '昵称';

alter table employee add work_address varchar(50) comment '工作地址';

desc emp;

-- 修改字段类型
alter table emp modify nickname varchar(30);

-- 将旧字段修改为新字段
alter table emp change nickname username varchar(50) comment '用户名';

-- 删除字段
alter table emp drop username;

-- 修改表名
alter table emp rename to employee;

-- 删除指定表，并重新创建
truncate table employee;