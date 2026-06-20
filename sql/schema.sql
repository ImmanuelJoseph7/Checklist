-- Kids Checklist - Supabase Schema
-- Run this in the Supabase SQL Editor

-- Profiles (kids)
create table profiles (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  pin text not null, -- stored as plain 4-digit for simplicity (kids app)
  avatar_emoji text default '😊',
  created_at timestamptz default now()
);

-- Checklists
create table checklists (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null, -- e.g. "morning", "evening", "holiday", "saturday"
  title text not null,
  active_days text[] default '{}', -- e.g. {"mon","tue","wed","thu","fri"}
  start_hour int, -- null = all day
  end_hour int,
  is_holiday_only boolean default false,
  sort_order int default 0
);

-- Checklist items
create table checklist_items (
  id uuid primary key default gen_random_uuid(),
  checklist_id uuid references checklists(id) on delete cascade,
  text text not null,
  section text not null default 'main', -- main, dinner, bonus, jobs
  sort_order int default 0,
  dollars numeric, -- only for jobs
  job_group text -- for mutual exclusion (e.g. "watering")
);

-- Rewards (per checklist/section)
create table rewards (
  id uuid primary key default gen_random_uuid(),
  checklist_id uuid references checklists(id) on delete cascade,
  section text not null default 'main', -- main, dinner
  coins int not null,
  deadline_hour int not null,
  deadline_minute int default 0,
  message text,
  priority int default 0 -- higher = checked first
);

-- App config (term dates, tv unlock time, etc.)
create table config (
  key text primary key,
  value jsonb not null
);

-- Daily log (progress + earnings per kid per day per checklist)
create table daily_log (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid references profiles(id) on delete cascade,
  date date not null default current_date,
  checklist_slug text not null,
  section text not null default 'main',
  checked_items int[] default '{}',
  coins_earned int default 0,
  dollars_earned numeric default 0,
  completed_at timestamptz,
  created_at timestamptz default now(),
  unique(profile_id, date, checklist_slug, section)
);

-- Admin users (parents)
create table admins (
  id uuid primary key default gen_random_uuid(),
  username text unique not null,
  password text not null, -- hashed
  created_at timestamptz default now()
);

-- Indexes
create index idx_daily_log_profile_date on daily_log(profile_id, date);
create index idx_checklist_items_checklist on checklist_items(checklist_id, sort_order);

-- Enable RLS
alter table profiles enable row level security;
alter table checklists enable row level security;
alter table checklist_items enable row level security;
alter table rewards enable row level security;
alter table config enable row level security;
alter table daily_log enable row level security;
alter table admins enable row level security;

-- RLS Policies: allow anon read on config/checklists (public app), restrict writes
create policy "Anyone can read profiles" on profiles for select using (true);
create policy "Anyone can read checklists" on checklists for select using (true);
create policy "Anyone can read checklist_items" on checklist_items for select using (true);
create policy "Anyone can read rewards" on rewards for select using (true);
create policy "Anyone can read config" on config for select using (true);
create policy "Anyone can read daily_log" on daily_log for select using (true);
create policy "Anyone can insert daily_log" on daily_log for insert with check (true);
create policy "Anyone can update daily_log" on daily_log for update using (true);
create policy "Anyone can read admins" on admins for select using (true);

-- Admin write policies (managed via service role or admin auth in app)
create policy "Anyone can manage profiles" on profiles for all using (true);
create policy "Anyone can manage checklists" on checklists for all using (true);
create policy "Anyone can manage checklist_items" on checklist_items for all using (true);
create policy "Anyone can manage rewards" on rewards for all using (true);
create policy "Anyone can manage config" on config for all using (true);
create policy "Anyone can manage admins" on admins for all using (true);
