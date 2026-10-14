-- Dipesh Gupta portfolio: everything the website and the studio need in Supabase.
-- Paste all of this into Supabase > SQL Editor > New query, and press Run. Running it twice is safe.
-- If you ever sign in to the studio with a different email, change it in is_owner() below and run again.

-- 1. Who may change things: only the account with your email.
create or replace function public.is_owner() returns boolean
language sql stable
as $$ select coalesce((select auth.jwt() ->> 'email'), '') = 'dipeshg976@gmail.com' $$;

-- 2. The words of the website. Two rows: 'draft' (what you are editing) and 'published' (what visitors see).
create table if not exists public.site_content (
  id text primary key check (id in ('draft', 'published')),
  data jsonb not null,
  updated_at timestamptz not null default now()
);

-- 3. Every publish is kept here, so an old version can be restored. Only the newest 50 are kept.
create table if not exists public.site_history (
  id bigint generated always as identity primary key,
  data jsonb not null,
  created_at timestamptz not null default now()
);

create or replace function public.trim_history() returns trigger
language plpgsql security definer set search_path = public
as $$
begin
  delete from public.site_history where id not in (select id from public.site_history order by id desc limit 50);
  return null;
end $$;
drop trigger if exists trim_history on public.site_history;
create trigger trim_history after insert on public.site_history for each statement execute function public.trim_history();

-- 4. Row rules: visitors may read only the published row; you may do everything.
alter table public.site_content enable row level security;
alter table public.site_history enable row level security;

drop policy if exists "visitors read the live words" on public.site_content;
drop policy if exists "owner reads everything" on public.site_content;
drop policy if exists "owner adds" on public.site_content;
drop policy if exists "owner changes" on public.site_content;
drop policy if exists "owner removes" on public.site_content;
create policy "visitors read the live words" on public.site_content for select to anon, authenticated using (id = 'published');
create policy "owner reads everything" on public.site_content for select to authenticated using (public.is_owner());
create policy "owner adds" on public.site_content for insert to authenticated with check (public.is_owner());
create policy "owner changes" on public.site_content for update to authenticated using (public.is_owner()) with check (public.is_owner());
create policy "owner removes" on public.site_content for delete to authenticated using (public.is_owner());

drop policy if exists "owner keeps versions" on public.site_history;
create policy "owner keeps versions" on public.site_history for all to authenticated using (public.is_owner()) with check (public.is_owner());

grant select on public.site_content to anon, authenticated;
grant insert, update, delete on public.site_content to authenticated;
grant select, insert, delete on public.site_history to authenticated;
revoke all on public.site_history from anon;

-- 5. A public folder for photos, up to 5 MB each. Anyone can view them; only you can add, replace or remove them.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('media', 'media', true, 5242880, array['image/jpeg', 'image/png', 'image/webp', 'image/gif'])
on conflict (id) do update set public = true, file_size_limit = excluded.file_size_limit, allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "owner adds photos" on storage.objects;
drop policy if exists "owner sees photos" on storage.objects;
drop policy if exists "owner replaces photos" on storage.objects;
drop policy if exists "owner removes photos" on storage.objects;
create policy "owner adds photos" on storage.objects for insert to authenticated with check (bucket_id = 'media' and public.is_owner());
create policy "owner sees photos" on storage.objects for select to authenticated using (bucket_id = 'media' and public.is_owner());
create policy "owner replaces photos" on storage.objects for update to authenticated using (bucket_id = 'media' and public.is_owner());
create policy "owner removes photos" on storage.objects for delete to authenticated using (bucket_id = 'media' and public.is_owner());
