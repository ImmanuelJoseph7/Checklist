# Kids Daily Checklist

A time-based daily checklist app with a reward system to encourage kids to complete their tasks.

## Features

- **Time-Based Checklists**: Automatically switches between checklists based on day and time
- **Holiday Mode**: Separate all-day checklist on school holiday weekdays, driven by term dates
- **Weekend Schedules**: Special checklists for Saturday (all-day) and Sunday (morning/evening)
- **Progress Tracking**: Visual progress bar showing completion percentage
- **Reward System**: Earn kindness coins for completing tasks on time
- **Live Countdown Timers**: Shows time remaining to earn rewards
- **TV Unlock**: Green banner unlocks TV/device time on holidays when morning tasks + lunch done before 2:30pm
- **Jobs**: Earn dollars for household jobs (plant watering, dishwasher) — tracked separately from coins
- **Bonus Tasks**: Daily behaviour tasks worth 1 coin each
- **Persistent Coins & Dollars**: Totals saved across sessions
- **Auto-Reset**: Checklists reset automatically
- **Dinner Tracking**: Separate dinner section with its own coin reward on evenings

## Daily Schedule

### Weekdays in School Term (Monday-Friday)
- **Morning checklist**: 12am (midnight) - 12pm (noon)
- **Evening checklist**: 12pm (noon) - 12am (midnight)
- Morning resets at midnight, evening resets at noon

### Weekdays in School Holidays (Monday-Friday)
- **Single all-day checklist** with morning and afternoon sections
- Resets at midnight

### Saturday
- **Single all-day checklist** (visible all day)
- Resets at midnight
- No time-based reward deadline

### Sunday
- **Morning checklist**: 12am (midnight) - 12pm (noon)
- **Evening checklist**: 12pm (noon) - 12am (midnight)
- Morning resets at midnight, evening resets at noon

## School Term Dates (2026)

- **Term 1**: 27 Jan – 2 Apr
- **Term 2**: 21 Apr – 26 Jun
- **Term 3**: 15 Jul – 18 Sep
- **Term 4**: 6 Oct – 27 Nov

Any weekday outside these ranges activates Holiday Mode. Update `CONFIG.termDates` in `index.html` each year.

## Checklists

### Weekday Morning
🙏 Pray • 🛏️ Make Bed • 🚽 Wee Wee • 🪥 Brush Teeth • 💧 Wash face • 🧴 Moisturise • 👔 Wear uniform • 🍱 Pack lunchbag • 💧 Pack water bottle • 🎒 Pack bag • 🍳 Eat breakfast • 👟 Put on socks & shoes

### Weekday Evening
🍱 Put lunchbox in sink (finish food if not empty) • 🧊 Put ice pack FLAT in freezer • 🚽 Poo Poo • 🚿 Shower • 🧴 Moisturise • 📝 Homework • 📚 Library Book • 📖 Read Bible • 🍽️ Dinner (separate section)

### Holiday Morning Section
🙏 Pray • 🛏️ Make Bed • 🚽 Wee Wee • 🪥 Brush Teeth • 💧 Wash face • 🚽 Poo Poo • 🚿 Shower • 🧴 Moisturise • 👕 Get Dressed • 🍳 Eat breakfast • 📚 Read for 30 minutes • 🤝 Play with sibling without fighting for 30 minutes • 📖 Read Bible

### Holiday Afternoon Section
🍽️ Eat lunch • 📚 Read for 30 minutes • 🌳 Play outside for 30 minutes • 🍽️ Dinner (separate section)

### Saturday (All Day)
🙏 Pray • 🛏️ Make Bed • 💧 Wash face • 🚽 Wee Wee • 🚿 Shower • 🪥 Brush Teeth • 🧴 Moisturise • 👕 Get Dressed • 🍳 Eat breakfast • 💧 Fill water bottle • 🍽️ Eat lunch • 🚽 Poo Poo • 🍽️ Eat dinner • 📖 Read Bible

### Sunday Morning
🙏 Pray • 🛏️ Make Bed • 🚽 Wee Wee • 🚿 Shower • 🪥 Brush Teeth • 💧 Wash face • 🧴 Moisturise • 👕 Get Dressed • 💧 Fill water bottle • 🥞 Eat breakfast • 👟 Put on socks & shoes

### Sunday Evening
🚽 Poo Poo • 📖 Read Bible • 🍽️ Dinner (separate section)

## Reward System

### Weekday Morning
- 🌟 **3 coins** if completed before 7:45am
- ⭐ **1 coin** if completed before 8:00am

### Weekday Evening
- 🌟 **3 coins** if completed before 5:00pm
- ⭐ **1 coin** if completed before 6:00pm
- 🍽️ **+1 bonus coin** if dinner finished by 7:00pm

### Holiday (all-day)
- 🌟 **3 coins** if morning section completed before noon
- 🌟 **3 coins** if afternoon section completed before 7:00pm
- 📺 **TV/device time unlocked** if morning tasks + lunch done before 2:30pm

### Saturday
- 🌟 **3 coins** when all tasks completed (anytime, no deadline)

### Sunday Morning
- 🌟 **3 coins** if completed before 9:30am

### Sunday Evening
- 🌟 **3 coins** if completed before 5:00pm
- ⭐ **1 coin** if completed before 6:00pm
- 🍽️ **+1 bonus coin** if dinner finished by 7:00pm

### Bonus Tasks (all days except Saturday morning)
- ⭐ **1 coin each**, awarded immediately on check, reversed on uncheck

### Jobs (evenings + Saturday)
- 🪴 Watered plants with sibling — **50¢**
- 🪴 Watered plants by myself — **$1.00** (mutually exclusive with above)
- 🍽️ Empty the dishwasher — **50¢**
- Dollars tracked separately from coins with daily and total totals

## How It Works

1. **Open the app** — correct checklist appears automatically based on day, time, and term dates
2. **Check off tasks** — progress bar updates as you complete items
3. **Complete before deadline** — earn coins based on completion time
4. **Celebration modal** — pops up when you earn coins showing total
5. **TV unlock** — green banner appears on holidays when conditions are met
6. **Coins & dollars persist** — totals saved even after closing the browser
7. **Auto-reset** — checklists reset automatically at scheduled times
8. **One reward per period** — can't earn coins multiple times for the same checklist

## Files

- `index.html` — Main checklist interface (entire app)
- `manage.html` — Deprecated, will be replaced during database migration
- `README.md` — This documentation
- `TODO.md` — Tracked issues and future plans
- `JOBS_FEATURE.md` — Notes on the jobs/dollars feature

## For Parents

- Use "Reset Checklist" button to clear the current checklist (coins kept)
- Use "Reset Total" buttons to clear all-time coins or dollars
- Update `CONFIG.termDates` in `index.html` at the start of each school year
- To test a specific date/time, set `TEST_TIME` in `index.html` (set back to `null` when done)

## Tech Stack

Pure HTML, CSS, and JavaScript with localStorage for data persistence. No server or database required — runs entirely in the browser.

## Deployment

### GitHub Pages
1. Push to GitHub
2. Go to Settings → Pages
3. Select "main" branch as source
4. Access at `https://<username>.github.io/<repo-name>/`

### Local Use
Simply open `index.html` in any modern web browser. Works offline once loaded.
