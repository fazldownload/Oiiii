-- Execute no SQL Editor do Supabase, uma vez.
-- Antes: crie o seu usuário em Authentication > Users > Add user.
-- Troque o email abaixo pelo seu email de administrador.
create table if not exists public.site_data (
 id integer primary key check (id=1),
 content jsonb not null
);
create table if not exists public.admins (
 user_id uuid primary key references auth.users(id) on delete cascade
);
alter table public.site_data enable row level security;
alter table public.admins enable row level security;
create policy "Todos leem site" on public.site_data for select to anon, authenticated using (true);
create policy "Admins editam site" on public.site_data for update to authenticated using (exists(select 1 from public.admins where user_id=auth.uid())) with check (exists(select 1 from public.admins where user_id=auth.uid()));
insert into public.site_data(id,content) values(1,'{"settings":{"brand":"Fazl Xiter","footer":"Fazlxiter2026","background":"#070d1c","heroTitle":"Downloads oficiais","heroSubtitle":"Arquivos, tutoriais e atualizações em um só lugar.","showHome":true},"products":[]}'::jsonb) on conflict(id) do nothing;
insert into public.admins(user_id) select id from auth.users where email='SEU_EMAIL_AQUI' on conflict do nothing;
insert into storage.buckets (id,name,public,file_size_limit) values('downloads','downloads',true,47185920) on conflict(id) do update set public=true;
create policy "Admins enviam arquivos" on storage.objects for insert to authenticated with check(bucket_id='downloads' and exists(select 1 from public.admins where user_id=auth.uid()));
create policy "Admins apagam arquivos" on storage.objects for delete to authenticated using(bucket_id='downloads' and exists(select 1 from public.admins where user_id=auth.uid()));
-- Downloads públicos são servidos pelo bucket público; qualquer pessoa com o link poderá baixar.
