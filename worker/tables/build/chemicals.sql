drop table if exists chemicals;

create table chemicals as
select
  row_number() over (order by code) as id
  ,*
from
  chemical_master
;
