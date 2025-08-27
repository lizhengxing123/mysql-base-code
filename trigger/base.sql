# 触发器
-- 触发器是在指定的事件发生时自动执行的一段代码。
-- 触发器的类型
-- 1、insert 触发器：new 表示插入的新数据。
-- 2、update 触发器：old 表示更新前的数据，new 表示更新后的数据。
-- 3、delete 触发器：old 表示删除前的数据。
-- 触发器只支持行级触发器，不支持语句级触发器。

# 语法
-- 1、创建触发器
-- create trigger trigger_name
-- before/after insert/update/delete
-- on table_name for each row
-- begin
--      触发器代码
-- end;

-- 2、删除触发器
-- drop trigger trigger_name;

-- 3、查看触发器
-- show triggers;

create table if not exists user_logs
(
    id             int primary key auto_increment,
    operation      varchar(20)  not null comment '操作类型[insert|update|delete]',
    operate_time   datetime     not null comment '操作时间',
    operate_id     int          not null comment '操作的原始数据id',
    operate_params varchar(500) not null comment '操作参数'
);

show triggers;
drop trigger if exists user_trigger_insert;

-- 插入数据触发器
create trigger user_trigger_insert
    after insert
    on tb_user
    for each row
begin
    insert into user_logs(operation, operate_time, operate_id, operate_params)
    values ('insert', now(), new.id,
            concat('插入数据[',
                   new.id, ',',
                   new.name, ',',
                   new.phone, ',',
                   new.email, ',',
                   new.profession, ',',
                   new.age, ',',
                   new.gender, ',',
                   new.status, ',',
                   new.create_time,
                   ']'));
end;

insert into tb_user(name, phone, email, profession, age, gender, status, create_time)
values ('干将莫邪', '13800009000', 'ganjiangmoye@qq.com', '法师', 40, 1, 2, now());

-- 更新数据触发器
drop trigger if exists user_trigger_update;
create trigger user_trigger_update
    after update
    on tb_user
    for each row
begin
    insert into user_logs(operation, operate_time, operate_id, operate_params)
    values ('update', now(), new.id,
            concat('更新之前的数据[',
                   old.id, ',',
                   old.name, ',',
                   old.phone, ',',
                   old.email, ',',
                   old.profession, ',',
                   old.age, ',',
                   old.gender, ',',
                   old.status, ',',
                   old.create_time,
                   ']',
                   ' | 更新之后的数据[',
                   new.id, ',',
                   new.name, ',',
                   new.phone, ',',
                   new.email, ',',
                   new.profession, ',',
                   new.age, ',',
                   new.gender, ',',
                   new.status, ',',
                   new.create_time,
                   ']'));
end;

update tb_user
set profession = '射手'
where id = 12;

-- 修改了多少行，就会触发多少次
update tb_user
set profession = '射手'
where id <= 5;

-- 删除数据触发器
drop trigger if exists user_trigger_delete;
create trigger user_trigger_delete
    after delete
    on tb_user
    for each row
begin
    insert into user_logs(operation, operate_time, operate_id, operate_params)
    values ('delete', now(), old.id,
            concat('删除数据[',
                   old.id, ',',
                   old.name, ',',
                   old.phone, ',',
                   old.email, ',',
                   old.profession, ',',
                   old.age, ',',
                   old.gender, ',',
                   old.status, ',',
                   old.create_time, ']'));
end;

delete from tb_user
where id = 32;
