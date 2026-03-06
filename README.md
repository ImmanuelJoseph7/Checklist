# Kids Daily Checklist

A time-based daily checklist app with a reward system to encourage kids to complete their tasks.

## Features

- **Time-Based Checklists**: Automatically switches between morning and evening checklists based on time of day
- **Weekend Schedules**: Special checklists for Saturday (all-day) and Sunday (morning/evening)
- **Progress Tracking**: Visual progress bar showing completion percentage
- **Reward System**: Earn kindness coins for completing tasks on time
- **Live Countdown Timers**: Shows time remaining to earn rewards
- **Persistent Coins**: Total coins saved across sessions
- **Auto-Reset**: Checklists reset automatically
- **Customizable**: Edit checklist items via manage.html

## Daily Schedule

### Weekdays (Monday-Friday)
- **Morning checklist**: 12am (midnight) - 12pm (noon)
- **Evening checklist**: 12pm (noon) - 12am (midnight)
- Morning resets at midnight
- Evening resets at noon

### Saturday
- **Single all-day checklist** (visible all day)
- Resets at midnight
- No time-based rewards

### Sunday
- **Morning checklist**: 12am (midnight) - 12pm (noon)
- **Evening checklist**: 12pm (noon) - 12am (midnight)
- Morning resets at midnight
- Evening resets at noon

## Checklists

### Weekday Morning
🙏 Pray • 🛏️ Make Bed • 🚽 Wee Wee • 🪥 Brush Teeth • 💧 Wash face • 🧴 Moisturise • 👔 Wear uniform • 🍱 Pack lunchbag • 💧 Pack water bottle • 🎒 Pack bag • 🍳 Eat breakfast • 👟 Put on socks & shoes

### Weekday Evening
🍱 Put lunchbox in sink (finish food if not empty) • 🧊 Put ice pack FLAT in freezer • 🚽 Poo Poo • 🚿 Shower • 🧴 Moisturise • 📝 Homework • 📚 Library Book • 🍽️ Dinner • 📖 Read Bible

### Saturday (All Day)
🙏 Pray • 🛏️ Make Bed • 🚽 Wee Wee • 🚿 Shower • 🪥 Brush Teeth • 💧 Wash face • 🧴 Moisturise • 👕 Wear Clothes • 💧 Fill water bottle • 🍽️ Eat meal • 👟 Put on socks & shoes • 🚽 Poo Poo • 📖 Read Bible

### Sunday Morning
🙏 Pray • 🛏️ Make Bed • 🚽 Wee Wee • 🚿 Shower • 🪥 Brush Teeth • 💧 Wash face • 🧴 Moisturise • 👕 Wear Clothes • 💧 Fill water bottle • 🥞 Eat breakfast • 👟 Put on socks & shoes

### Sunday Evening
🚽 Poo Poo • 🍽️ Dinner • 📖 Read Bible

## Reward System

### Weekday Morning
- 🌟 **3 coins** if completed before 7:45am
- ⭐ **1 coin** if completed before 8:00am
- Live countdown timers show time remaining

### Weekday Evening
- 🌟 **3 coins** if completed before 5:00pm
- ⭐ **1 coin** if completed before 6:00pm
- 🍽️ **+1 bonus coin** if dinner finished by 7:00pm
- Live countdown timers (3 timers total)

### Saturday
- 🌟 **3 coins** when all tasks completed (anytime, no deadline)
- No timers displayed

### Sunday Morning
- 🌟 **3 coins** if completed before 7:45am
- ⭐ **1 coin** if completed before 8:00am
- Live countdown timers show time remaining

### Sunday Evening
- 🌟 **3 coins** if completed before 5:00pm
- ⭐ **1 coin** if completed before 6:00pm
- 🍽️ **+1 bonus coin** if dinner finished by 7:00pm
- Live countdown timers (3 timers total)

## How It Works

1. **Open the app** - The correct checklist appears automatically based on day and time
2. **Check off tasks** - Progress bar updates as you complete items
3. **Complete before deadline** - Earn coins based on completion time
4. **Celebration modal** - Pops up when you earn coins showing total
5. **Coins persist** - Your total coins are saved even after closing the browser
6. **Auto-reset** - Checklists reset automatically at scheduled times
7. **One reward per period** - Can't earn coins multiple times for the same checklist

## Files

- `index.html` - Main checklist interface
- `manage.html` - Admin page to customize checklist items
- `README.md` - This documentation

## Usage

### For Kids
1. Open `index.html` in a browser
2. Check off tasks as you complete them
3. Watch the progress bar fill up
4. Complete all tasks before the deadline to earn coins!

### For Parents
1. Visit `manage.html` to customize checklist items
2. Use "Reset Coins" button if needed to clear total coins
3. Bookmark the page or add to home screen for easy access

## Tech Stack

Pure HTML, CSS, and JavaScript with localStorage for data persistence. No server or database required - runs entirely in the browser.

## Deployment

### GitHub Pages
1. Push to GitHub
2. Go to Settings → Pages
3. Select "main" branch as source
4. Access at `https://<username>.github.io/<repo-name>/`

### Local Use
Simply open `index.html` in any modern web browser. Works offline once loaded.
