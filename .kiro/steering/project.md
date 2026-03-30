# Kids Daily Checklist — Project Steering

## What This Is
A single-file browser app (`index.html`) for kids to complete daily checklists. No build tools, no dependencies, no server. Pure HTML/CSS/JS with `localStorage` for persistence.

## Files
- `index.html` — entire app, all logic inline
- `manage.html` — deprecated, ignore it
- `README.md` — documentation
- `TODO.md` — tracked issues and future plans
- `JOBS_FEATURE.md` — notes on the jobs/dollars feature

## Architecture
Everything lives in `index.html`:
- **CONFIG** object — reward deadlines, coin amounts, term dates
- **DEFAULT_ITEMS** object — all checklist items for every schedule type
- **Storage** helper — thin wrapper around `localStorage`
- All logic is synchronous; no async, no fetch

### Schedule Types (`type` variable)
| Value | When |
|---|---|
| `morning` | Weekday in term, before noon |
| `evening` | Weekday in term, noon–midnight |
| `holiday` | Weekday outside term dates, all day |
| `saturday` | All day Saturday |
| `sundayMorning` | Sunday, before noon |
| `sundayEvening` | Sunday, noon–midnight |

`isHoliday` boolean is computed at startup using `CONFIG.termDates` and local date (not UTC).

### Holiday Mode
- Single all-day checklist with two named sections: `holidayMorning` and `holidayAfternoon`
- Items stored as a combined array in `holidayChecked` (morning items first, then afternoon by index offset)
- Morning reward: 3 coins if all morning items checked before noon (`holidayMorningCompleted`)
- Afternoon reward: 3 coins if all afternoon items checked before 7pm (`holidayAfternoonCompleted`)
- TV unlock: green banner if all morning items + lunch (first afternoon item) checked before 2:30pm
- TV unlock modal only fires once per day (`holidayTVUnlockShown`)
- Unchecking a morning item removes morning reward coins; unchecking any item removes afternoon reward coins

### Sections per checklist
- **main** — primary tasks (keyed by `type`)
- **dinner** — shown on evenings + holiday afternoons, separate coin reward (not on holiday)
- **bonus** — behaviour tasks, 1 coin each, shown afternoon/evening
- **jobs** — plant watering + dishwasher, rewards in dollars (not coins), shown evenings + Saturday + holiday afternoons

### Storage key patterns
- `{type}Checked` / `{type}Completed` / `{type}CompletedCoins` — main checklist state
- `holidayMorningCompleted` / `holidayMorningCompletedCoins`
- `holidayAfternoonCompleted` / `holidayAfternoonCompletedCoins`
- `holidayTVUnlockShown`
- `morningBonusChecked`, `eveningBonusChecked`, `morningBonusRewards`, `eveningBonusRewards`
- `eveningJobsChecked`, `saturdayJobsChecked`, `sundayEveningJobsChecked`, `holidayAfternoonJobsChecked`
- `totalCoins`, `dailyCoins`, `totalDollars`, `dailyDollars`
- `lastReset` — ISO string, used for auto-reset logic

### Reward system
- **Weekday morning**: 3 coins before 7:45am, 1 coin before 8:00am
- **Sunday morning**: 3 coins before 9:30am
- **Evening (weekday + Sunday)**: 3 coins before 5pm, 1 coin before 6pm, +1 coin for dinner before 7pm
- **Saturday**: 3 coins on full completion, no timer
- **Holiday morning**: 3 coins if all morning items done before noon
- **Holiday afternoon**: 3 coins if all afternoon items done before 7pm (no dinner coin)
- **Bonus tasks**: 1 coin each, awarded immediately on check, reversed on uncheck
- **Jobs**: dollars (not coins), watering jobs are mutually exclusive

### Auto-reset
- Midnight resets: all checklists, bonus, jobs, dailyCoins, dailyDollars
- Noon resets: morning checklist only (weekdays/Sunday)

### Term dates (update each year in CONFIG.termDates)
2026: Term 1 Jan 27–Apr 2, Term 2 Apr 21–Jun 26, Term 3 Jul 15–Sep 18, Term 4 Oct 6–Nov 27

## Planned Work
- Supabase database integration for multi-device sync (see TODO.md) — will also replace manage.html with a proper management UI
- `TEST_TIME` variable in `index.html` (set to `null` for real time) can be used for testing specific days/times

## Coding Conventions
- Keep everything in `index.html` unless explicitly asked to split files
- Minimal code — no unnecessary abstractions
- No external libraries or frameworks
- Preserve existing Storage key naming patterns when adding new state
