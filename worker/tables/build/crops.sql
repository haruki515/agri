drop table if exists crops;
drop sequence if exists crops_seq;

create sequence crops_seq;
create table crops as
  id bigint primary key default nextval('crops_seq'),
select distinct on (crops)
  crops 
from
  chemical_information_master
;
