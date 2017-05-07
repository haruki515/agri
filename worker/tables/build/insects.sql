drop table if exists insects;

create table insects as
select distinct
  row_number() over (order by code) as id,
  insects
from
  chemical_information_master
;
