class SelectGroupHaving
  select * from `ra_project` as p
  inner join ra_gysbj gys on p.id = gys.`ra_project_id`
where gys.price =
(select min(gys_reslut.price) from ra_gysbj as gys_reslut
where gys.`ra_project_id` = gys_reslut.`ra_project_id`  )
and p.`status` in (60, 61) and gys.user_id = 19220

group by gys.ra_project_id, gys.gys_id
having  min(gys.price) ;

select gys_self.* from ra_gysbj as gys_self
inner join ra_project as ra_pro on gys_self.ra_project_id = ra_pro.id
where
ra_pro.status in (60, 61) and gys_self.user_id = 19220 and
gys_self.price =
(select min(gys_rel.price) from `ra_gysbj` as gys_rel where gys_self.`ra_project_id` = gys_rel.ra_project_id ) ;


select * from ra_gysbj where ra_project_id = 158;
SELECT s1.article, dealer, s1.price
FROM shop s1
JOIN (
  SELECT article, MAX(price) AS price
  FROM shop
  GROUP BY article) AS s2
  ON s1.article = s2.article AND s1.price = s2.price;

group by gys.ra_project_id, gys.gys_id


select distinct gys.* from `ra_project` as p inner join ra_gysbj gys on p.id = gys.`ra_project_id` where p.`status` in (60, 61)  group by gys.ra_project_id, gys.gys_id ;
end