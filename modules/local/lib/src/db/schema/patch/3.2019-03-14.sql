alter table address add column rhif_id text;
alter table address add constraint address_rhif_id_fkey foreign key (rhif_id) references rhif(rhif_id) on delete restrict;