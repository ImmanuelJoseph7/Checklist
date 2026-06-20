# Supabase Migration Plan

## Overview
Migrate Kids Daily Checklist from localStorage single-page app to Supabase-backed multi-user app.

## New Capabilities
1. **Parent config page** — CRUD checklists, items, rewards, term dates
2. **Kid logins** — name + PIN (no email/password)
3. **History view** — calendar showing coins/dollars earned per day

## Database Schema

### `profiles` (kids)
| Column | Type | Notes |
|--------|------|-------|
| id | uuid (PK) | |
| name | text | Display name |
| pin | text | 4-digit PIN (hashed) |
| avatar_emoji | text | e.g. "🦁" |
| created_at | timestamptz | |

### `checklists`
| Column | Type | Notes |
|--------|------|-------|
| id | uuid (PK) | |
| slug | text | e.g. "morning", "evening", "holiday", "saturday", "sundayMorning" |
| title | text | Display title |
| schedule_type | text | "time_based" or "all_day" |
| active_days | text[] | e.g. ["mon","tue","wed","thu","fri"] |
| start_hour | int | null for all_day |
| end_hour | int | null for all_day |
| is_holiday_only | bool | |

### `checklist_items`
| Column | Type | Notes |
|--------|------|-------|
| id | uuid (PK) | |
| checklist_id | uuid (FK) | |
| text | text | Item text with emoji |
| section | text | "main", "dinner", "bonus", "jobs" |
| sort_order | int | |
| dollars | numeric | null unless jobs |
| job_group | text | null unless jobs (for mutual exclusion) |

### `rewards`
| Column | Type | Notes |
|--------|------|-------|
| id | uuid (PK) | |
| checklist_id | uuid (FK) | |
| section | text | "main", "dinner" |
| coins | int | |
| deadline_hour | int | |
| deadline_minute | int | |
| message | text | Celebration message |
| priority | int | Higher = checked first (3-coin before 1-coin) |

### `config`
| Column | Type | Notes |
|--------|------|-------|
| key | text (PK) | e.g. "term_dates", "tv_unlock_hour" |
| value | jsonb | |

### `daily_log`
| Column | Type | Notes |
|--------|------|-------|
| id | uuid (PK) | |
| profile_id | uuid (FK) | |
| date | date | |
| checklist_slug | text | |
| checked_items | int[] | Indices of checked items |
| completed_at | timestamptz | When all main items were done |
| coins_earned | int | |
| dollars_earned | numeric | |
| bonus_coins | int | |

### `coin_totals` (materialized/computed)
| Column | Type | Notes |
|--------|------|-------|
| profile_id | uuid (FK, PK) | |
| total_coins | int | |
| total_dollars | numeric | |

## App Structure (new files)

```
/
├── index.html          → Kid checklist (refactored, reads from Supabase)
├── login.html          → Kid login (name + PIN)
├── history.html        → Calendar view of earnings
├── admin.html          → Parent config page (replaces manage.html)
├── js/
│   ├── supabase.js     → Supabase client init + helpers
│   ├── auth.js         → PIN-based auth logic
│   └── checklist.js    → Core checklist logic (extracted from index.html)
├── css/
│   └── styles.css      → Shared styles (extracted from index.html)
└── sql/
    └── schema.sql      → Database migration
```

## Auth Approach
- No Supabase Auth (overkill for kids + PIN)
- Custom `profiles` table with hashed PINs
- Session stored in localStorage (`current_profile_id`)
- Parent access via a separate PIN or password in `config` table
- RLS policies filter by `profile_id` from a custom header or service role for simplicity

## Implementation Order
1. **Schema** — Create tables + seed with current DEFAULT_ITEMS data
2. **Auth (login.html)** — Kid picker + PIN entry
3. **Checklist (index.html)** — Refactor to read config from Supabase, write progress to `daily_log`
4. **History (history.html)** — Calendar grid showing coins/dollars per day
5. **Admin (admin.html)** — Parent config page for checklists, items, rewards, term dates
6. **Cleanup** — Remove localStorage fallback, deploy

## Questions Before Starting
1. Do you have your Supabase project URL and anon key ready?
2. How many kids? (So I can seed the profiles)
3. Do you want parent login to be a separate PIN, or a full password?
4. Should the app still work offline (queue writes), or is always-online acceptable?
