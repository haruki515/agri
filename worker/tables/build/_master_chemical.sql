drop table if exists _master_chemical;

create table _master_chemical as
select
  row_number() over (order by code) as index
  ,*
from
  chemicals
;
