drop table if exists crops;

create table crops as
select 
  row_number() over (order by crops) as id,
  crops 
from
  chemical_information_master
  group by crops
;
