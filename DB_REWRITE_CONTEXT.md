# DB-Driven Rewrite - Context

## Key Decision
Replace ALL localStorage state with Supabase `daily_state` table. Each tick writes to DB. No Save button needed.

## Table: daily_state
- profile_id, date, checklist_slug (unique together)
- checked_main uuid[] — item UUIDs that are checked
- checked_dinner uuid[]
- checked_bonus uuid[]  
- checked_chores uuid[]
- checked_jobs uuid[]
- coins_earned int (calculated from flags)
- bonus_coins int
- chore_coins int
- dollars_earned numeric
- completed_at timestamptz

## How Items Work
- Items loaded from `checklist_items` table (via DB.getAllChecklists())
- Each item has a UUID (`id` field)
- When kid ticks an item, its UUID goes into the appropriate checked_* array
- On page load, fetch today's state from DB → render checked items by matching UUIDs

## What Stays the Same
- All timing logic (CONFIG, time detection, holiday detection)
- All reward calculation rules (deadlines, coin amounts)
- Visual design / HTML / CSS
- Login flow
- Admin panel

## What Changes
- Storage.get/set → replaced with in-memory state + DB write
- No more localStorage keys for checked/completed/rewards
- No Save button
- No auto-save-before-reset
- No login-clear-coins
- Coins total = sum from all daily_state rows for that profile

## Flow
1. Page loads → determine slug from time
2. Fetch today's daily_state for this kid + slug
3. Fetch checklist_items for this slug (cached)
4. Render: match checked UUIDs to items
5. On tick: update in-memory state → calculate coins → write to DB → re-render
6. On untick: reverse coins → update DB → re-render
