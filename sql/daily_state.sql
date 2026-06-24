-- Migration: Create daily_state table for fully DB-driven checklist
-- Run this in Supabase SQL Editor BEFORE testing the new branch

-- New table: live checklist state per kid per day per slug
create table if not exists daily_state (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid references profiles(id) on delete cascade,
  date date not null default current_date,
  checklist_slug text not null,
  checked_main uuid[] default '{}',
  checked_dinner uuid[] default '{}',
  checked_bonus uuid[] default '{}',
  checked_chores uuid[] default '{}',
  checked_jobs uuid[] default '{}',
  coins_earned int default 0,
  bonus_coins int default 0,
  chore_coins int default 0,
  dollars_earned numeric default 0,
  completed_at timestamptz,
  created_at timestamptz default now(),
  unique(profile_id, date, checklist_slug)
);

create index if not exists idx_daily_state_lookup on daily_state(profile_id, date, checklist_slug);

-- RLS
alter table daily_state enable row level security;
create policy "Read daily_state" on daily_state for select using (true);
create policy "Insert daily_state" on daily_state for insert with check (profile_id in (select id from profiles));
create policy "Update daily_state" on daily_state for update using (profile_id in (select id from profiles));
