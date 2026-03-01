# Kids Daily Checklist - TODO

## Completed ✅
- [x] Add morning bonus section with "I went to sleep last night without mucking around!" task
- [x] Separate morning and evening bonus tasks
- [x] Fix syntax errors in bonus implementation

## Pending Issues

### Issue 1: Refactor index.html for Better Readability
**Priority:** Medium  
**Description:** Improve code organization and reduce duplication in index.html

**Tasks:**
- [ ] Consolidate duplicate bonus logic (morning/evening follow same pattern)
- [ ] Create reusable functions for state management
- [ ] Separate data configuration from business logic
- [ ] Group related functions together (all bonus functions, all state functions, etc.)
- [ ] Add code comments for major sections
- [ ] Simplify conditional logic where possible

**Benefits:**
- Easier to maintain and debug
- Cleaner codebase for future database migration
- Reduced code duplication

---

### Issue 2: Supabase Database Integration
**Priority:** High (Future Enhancement)  
**Description:** Migrate from localStorage to Supabase for proper data persistence and multi-device sync

**Phase 1: Setup & Planning**
- [ ] Create Supabase project
- [ ] Design database schema
  - `checklist_items` table (id, type, text, emoji, order)
  - `daily_progress` table (id, user_id, date, checklist_type, checked_items, completed_at)
  - `user_coins` table (id, user_id, total_coins, last_updated)
  - `bonus_rewards` table (id, user_id, date, bonus_type, items_completed)
- [ ] Set up Row Level Security policies
- [ ] Create database migrations

**Phase 2: Backend Integration**
- [ ] Add Supabase JS client to index.html
- [ ] Create API wrapper functions for database operations
- [ ] Replace localStorage calls with Supabase queries
- [ ] Implement error handling and retry logic
- [ ] Add loading states for async operations

**Phase 3: Authentication (Optional)**
- [ ] Add Supabase Auth for multiple users/kids
- [ ] Create login/signup page
- [ ] Add user profile management
- [ ] Implement user-specific data filtering

**Phase 4: Admin Interface**
- [ ] Build new manage.html from scratch for Supabase
- [ ] Add CRUD operations for all checklist types
- [ ] Add real-time updates for checklist changes
- [ ] Create admin interface for managing users (if multi-user)
- [ ] Add emoji picker or reference guide

**Phase 5: Offline Support (Optional)**
- [ ] Implement service worker for offline functionality
- [ ] Add local caching with sync on reconnect
- [ ] Handle conflict resolution for offline edits

**Phase 6: Testing & Deployment**
- [ ] Test all CRUD operations
- [ ] Test multi-user scenarios
- [ ] Test offline/online transitions
- [ ] Deploy to production
- [ ] Migrate existing localStorage data to Supabase

**Benefits:**
- Data persists across devices
- Multi-user support (multiple kids)
- Real-time sync
- Better data management and reporting
- Foundation for future features (analytics, parent dashboard, etc.)

---

### Issue 3: Documentation Updates
**Priority:** Low  
**Description:** Update README.md to reflect new features

**Tasks:**
- [ ] Document morning bonus section
- [ ] Update reward system section with morning bonus details
- [ ] Add troubleshooting section
- [ ] Document manage.html usage (once updated)
- [ ] Add database migration guide (once Supabase is integrated)

---

## Summary

**Total Issues to Create: 3**

1. **Issue #1:** Refactor index.html for Better Readability
2. **Issue #2:** Supabase Database Integration (Epic - can be broken into 6 sub-issues)
3. **Issue #3:** Documentation Updates

**Recommended Priority Order:**
1. Issue #2 (Supabase Integration) - Most impactful, enables future growth
2. Issue #1 (Refactor) - Makes Issue #2 easier to implement
3. Issue #3 (Documentation) - Ongoing as features are completed

**Note:** Skipping manage.html updates since it will be rebuilt from scratch during Supabase migration (Phase 4).
