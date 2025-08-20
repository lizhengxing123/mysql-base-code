-- 自连接
select a.name, b.name
from employee a,
     employee b
where a.parent_id = b.id;


select a.name, b.name
from employee a
left outer join employee b on a.parent_id = b.id;
