drop table if exists insects;

create table insects as
select
  row_number() over (order by insects) as id,
  insects
from
  chemical_information_master
  group by insects
;
