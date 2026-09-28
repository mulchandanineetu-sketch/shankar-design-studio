alter table orders add column if not exists logo_url text;

insert into storage.buckets (id, name, public)
values ('Design', 'Design', true)
on conflict (id) do nothing;

update storage.buckets
set public = true,
    file_size_limit = 2097152,
    allowed_mime_types = array['image/png', 'image/jpeg']
where id = 'Design';

drop policy if exists "Design anon upload" on storage.objects;

create policy "Design anon upload"
on storage.objects
for insert
to anon
with check (bucket_id = 'Design');
