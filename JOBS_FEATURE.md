# Jobs Feature Implementation

## Overview
Added a new "Jobs" section to the evening checklist that tracks plant watering tasks and rewards with dollars (separate from coins).

## Features Implemented

### 1. Jobs Data Structure
- Two mutually exclusive jobs:
  - 🪴 Watered plants with sibling - 50¢
  - 🪴 Watered plants by myself - $1.00

### 2. Mutually Exclusive Selection
- Only ONE job can be checked per day
- Checking a new job automatically unchecks the previous one
- Dollars are adjusted accordingly when switching jobs

### 3. Dollar Tracking System
- **Separate from coins** - completely independent tracking
- **Total dollars** - persists across sessions
- **Daily dollars** - resets at midnight
- Display format: `💵 Total: $X.XX | Today: $X.XX`

### 4. Celebration Modal
- Shows when a job is completed
- Displays:
  - Amount earned (50¢ or $1)
  - Today's total dollars
  - All-time total dollars

### 5. Reset Functionality
- Jobs reset daily at 3pm (with evening checklist)
- Daily dollars reset at midnight
- Manual "Reset Total" button to clear all-time dollars

### 6. Display Location
- Appears at the bottom of the evening checklist
- Shows total dollars in section title
- Only visible during evening time (after 3pm)

### 7. Schedule
- **Weekday evenings**: 3pm - midnight
- **Sunday evenings**: 3pm - midnight
- **Saturday**: Not shown (no evening checklist)
- **Morning**: Not shown

## Technical Implementation

### New Functions Added
- `getDollars()` - Get total dollars
- `getDailyDollars()` - Get today's dollars
- `addDollars(amount)` - Add dollars to totals
- `removeDollars(amount)` - Remove dollars from totals
- `formatDollars(amount)` - Format as currency ($X.XX)
- `shouldShowJobs()` - Check if jobs should be displayed
- `getJobsChecked()` - Get currently checked job
- `saveJobsChecked(index)` - Save checked job
- `checkJobsCompletion(index)` - Award dollars and show modal
- `toggleJob(index)` - Handle job checkbox toggle with mutual exclusivity
- `resetDollars()` - Reset total dollars to $0.00

### Storage Keys
- `totalDollars` - All-time dollar total
- `dailyDollars` - Today's dollar total
- `eveningJobsChecked` - Weekday evening job selection
- `eveningJobsCompleted` - Weekday evening completion flag
- `eveningJobsCompletedDollars` - Weekday evening dollars earned
- `sundayEveningJobsChecked` - Sunday evening job selection
- `sundayEveningJobsCompleted` - Sunday evening completion flag
- `sundayEveningJobsCompletedDollars` - Sunday evening dollars earned

### Auto-Reset Logic
- Jobs reset at 3pm (with evening checklist)
- Daily dollars reset at midnight
- Completion flags and checked state cleared

## Usage

1. Open the app during evening time (after 3pm)
2. Scroll to the bottom to see the Jobs section
3. Check ONE job (either with sibling or by yourself)
4. Celebration modal shows dollars earned
5. Total dollars displayed at top and in section title
6. Jobs reset automatically at 3pm next day
7. Use "Reset Total" button if needed to clear all-time dollars

## Testing Checklist

- [ ] Jobs appear only during evening time
- [ ] Only one job can be checked at a time
- [ ] Checking second job unchecks first and adjusts dollars
- [ ] Celebration modal shows correct amounts
- [ ] Total dollars persist after page refresh
- [ ] Daily dollars reset at midnight
- [ ] Jobs reset at 3pm
- [ ] Reset Total button works
- [ ] Works on weekday evenings
- [ ] Works on Sunday evenings
- [ ] Doesn't appear on Saturday or mornings
