-- Weekly winners table
create table if not exists weekly_winners (
  id uuid primary key default gen_random_uuid(),
  week_start date not null, -- Monday of that week
  profile_id uuid references profiles(id) on delete cascade,
  coins int not null,
  created_at timestamptz default now(),
  unique(week_start)
);

alter table weekly_winners enable row level security;
create policy "Read weekly_winners" on weekly_winners for select using (true);
create policy "Insert weekly_winners" on weekly_winners for insert with check (true);
