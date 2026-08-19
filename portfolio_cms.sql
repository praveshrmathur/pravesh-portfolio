-- Run once in Supabase SQL Editor.
create table if not exists public.site_settings (id integer primary key,settings jsonb not null default '{}'::jsonb,updated_at timestamptz not null default now());
insert into public.site_settings(id,settings) values(1,'{}'::jsonb) on conflict(id) do nothing;
alter table public.site_settings enable row level security;
drop policy if exists "site settings public read" on public.site_settings;
create policy "site settings public read" on public.site_settings for select to anon,authenticated using(true);
drop policy if exists "site settings authenticated write" on public.site_settings;
create policy "site settings authenticated write" on public.site_settings for all to authenticated using(true) with check(true);
alter table public.site_settings replica identity full;
