-- Seed data - matches current DEFAULT_ITEMS and CONFIG from index.html

-- Kids (2 profiles - update names as needed)
insert into profiles (name, pin, avatar_emoji) values
  ('Kid 1', '1234', '🦁'),
  ('Kid 2', '5678', '🦊');

-- Admin
insert into admins (username, password) values
  ('admin', 'changeme'); -- change this after first login

-- Config
insert into config (key, value) values
  ('term_dates', '[{"start":"2026-01-27","end":"2026-04-02"},{"start":"2026-04-21","end":"2026-06-26"},{"start":"2026-07-15","end":"2026-09-18"},{"start":"2026-10-06","end":"2026-11-27"}]'),
  ('morning_end_hour', '12'),
  ('bonus_start_hour', '15'),
  ('tv_unlock_hour', '14'),
  ('tv_unlock_minute', '30');

-- Checklists
insert into checklists (slug, title, active_days, start_hour, end_hour, is_holiday_only, sort_order) values
  ('morning', '🌅 Morning Checklist', '{mon,tue,wed,thu,fri}', 0, 12, false, 1),
  ('evening', '🌙 Evening Checklist', '{mon,tue,wed,thu,fri}', 12, 24, false, 2),
  ('holiday', '🏖️ Holiday Checklist', '{mon,tue,wed,thu,fri}', null, null, true, 3),
  ('saturday', '☀️ Saturday Checklist', '{sat}', null, null, false, 4),
  ('sundayMorning', '☀️ Sunday Morning Checklist', '{sun}', 0, 12, false, 5),
  ('sundayEvening', '🌙 Sunday Evening Checklist', '{sun}', 12, 24, false, 6);

-- Morning items
insert into checklist_items (checklist_id, text, section, sort_order) values
  ((select id from checklists where slug='morning'), '🙏 Pray', 'main', 1),
  ((select id from checklists where slug='morning'), '🛏️ Make Bed', 'main', 2),
  ((select id from checklists where slug='morning'), '🚽 Wee Wee', 'main', 3),
  ((select id from checklists where slug='morning'), '🪥 Brush Teeth', 'main', 4),
  ((select id from checklists where slug='morning'), '💧 Wash face', 'main', 5),
  ((select id from checklists where slug='morning'), '🧴 Moisturise', 'main', 6),
  ((select id from checklists where slug='morning'), '👔 Wear uniform', 'main', 7),
  ((select id from checklists where slug='morning'), '🍱 Pack lunchbag', 'main', 8),
  ((select id from checklists where slug='morning'), '💧 Pack water bottle', 'main', 9),
  ((select id from checklists where slug='morning'), '🎒 Pack bag', 'main', 10),
  ((select id from checklists where slug='morning'), '🍳 Eat breakfast', 'main', 11),
  ((select id from checklists where slug='morning'), '👟 Put on socks & shoes', 'main', 12);

-- Morning bonus
insert into checklist_items (checklist_id, text, section, sort_order) values
  ((select id from checklists where slug='morning'), '😴 I went to sleep last night without mucking around!', 'bonus', 1);

-- Evening items
insert into checklist_items (checklist_id, text, section, sort_order) values
  ((select id from checklists where slug='evening'), '🍱 Put lunchbox in sink (finish food if not empty)', 'main', 1),
  ((select id from checklists where slug='evening'), '🧊 Put ice pack FLAT in freezer', 'main', 2),
  ((select id from checklists where slug='evening'), '🚽 Poo Poo', 'main', 3),
  ((select id from checklists where slug='evening'), '🚿 Shower', 'main', 4),
  ((select id from checklists where slug='evening'), '🧴 Moisturise', 'main', 5),
  ((select id from checklists where slug='evening'), '📝 Homework', 'main', 6),
  ((select id from checklists where slug='evening'), '📚 Library Book', 'main', 7),
  ((select id from checklists where slug='evening'), '📖 Read Bible', 'main', 8);

-- Evening dinner
insert into checklist_items (checklist_id, text, section, sort_order) values
  ((select id from checklists where slug='evening'), '🍽️ Dinner', 'dinner', 1);

-- Evening bonus
insert into checklist_items (checklist_id, text, section, sort_order) values
  ((select id from checklists where slug='evening'), '😊 I used manners today!', 'bonus', 1),
  ((select id from checklists where slug='evening'), '🤗 I was polite by responding to others with a happy smile!', 'bonus', 2),
  ((select id from checklists where slug='evening'), '👂 I listened to mummy and daddy immediately!', 'bonus', 3);

-- Evening jobs
insert into checklist_items (checklist_id, text, section, sort_order, dollars, job_group) values
  ((select id from checklists where slug='evening'), '🪴 Watered plants with sibling', 'jobs', 1, 0.50, 'watering'),
  ((select id from checklists where slug='evening'), '🪴 Watered plants by myself', 'jobs', 2, 1.00, 'watering'),
  ((select id from checklists where slug='evening'), '🍽️ Empty the dishwasher', 'jobs', 3, 0.50, null);

-- Holiday morning items
insert into checklist_items (checklist_id, text, section, sort_order) values
  ((select id from checklists where slug='holiday'), '🙏 Pray', 'main', 1),
  ((select id from checklists where slug='holiday'), '🛏️ Make Bed', 'main', 2),
  ((select id from checklists where slug='holiday'), '🚽 Wee Wee', 'main', 3),
  ((select id from checklists where slug='holiday'), '🪥 Brush Teeth', 'main', 4),
  ((select id from checklists where slug='holiday'), '💧 Wash face', 'main', 5),
  ((select id from checklists where slug='holiday'), '🚽 Poo Poo', 'main', 6),
  ((select id from checklists where slug='holiday'), '🚿 Shower', 'main', 7),
  ((select id from checklists where slug='holiday'), '🧴 Moisturise', 'main', 8),
  ((select id from checklists where slug='holiday'), '👕 Get Dressed', 'main', 9),
  ((select id from checklists where slug='holiday'), '🍳 Eat breakfast', 'main', 10),
  ((select id from checklists where slug='holiday'), '📚 Read for 30 minutes', 'main', 11),
  ((select id from checklists where slug='holiday'), '🤝 Play with sibling without fighting for 30 minutes', 'main', 12),
  ((select id from checklists where slug='holiday'), '📖 Read Bible', 'main', 13);

-- Holiday afternoon items
insert into checklist_items (checklist_id, text, section, sort_order) values
  ((select id from checklists where slug='holiday'), '🍽️ Eat lunch', 'afternoon', 1),
  ((select id from checklists where slug='holiday'), '📚 Read for 30 minutes', 'afternoon', 2),
  ((select id from checklists where slug='holiday'), '🌳 Play outside for 30 minutes', 'afternoon', 3);

-- Holiday dinner
insert into checklist_items (checklist_id, text, section, sort_order) values
  ((select id from checklists where slug='holiday'), '🍽️ Dinner', 'dinner', 1);

-- Saturday items
insert into checklist_items (checklist_id, text, section, sort_order) values
  ((select id from checklists where slug='saturday'), '🙏 Pray', 'main', 1),
  ((select id from checklists where slug='saturday'), '🛏️ Make Bed', 'main', 2),
  ((select id from checklists where slug='saturday'), '💧 Wash face', 'main', 3),
  ((select id from checklists where slug='saturday'), '🚽 Wee Wee', 'main', 4),
  ((select id from checklists where slug='saturday'), '🚿 Shower', 'main', 5),
  ((select id from checklists where slug='saturday'), '🪥 Brush Teeth', 'main', 6),
  ((select id from checklists where slug='saturday'), '🧴 Moisturise', 'main', 7),
  ((select id from checklists where slug='saturday'), '👕 Get Dressed', 'main', 8),
  ((select id from checklists where slug='saturday'), '🍳 Eat breakfast', 'main', 9),
  ((select id from checklists where slug='saturday'), '💧 Fill water bottle', 'main', 10),
  ((select id from checklists where slug='saturday'), '🍽️ Eat lunch', 'main', 11),
  ((select id from checklists where slug='saturday'), '🚽 Poo Poo', 'main', 12),
  ((select id from checklists where slug='saturday'), '🍽️ Eat dinner', 'main', 13),
  ((select id from checklists where slug='saturday'), '📖 Read Bible', 'main', 14);

-- Saturday jobs
insert into checklist_items (checklist_id, text, section, sort_order, dollars, job_group) values
  ((select id from checklists where slug='saturday'), '🪴 Watered plants with sibling', 'jobs', 1, 0.50, 'watering'),
  ((select id from checklists where slug='saturday'), '🪴 Watered plants by myself', 'jobs', 2, 1.00, 'watering'),
  ((select id from checklists where slug='saturday'), '🍽️ Empty the dishwasher', 'jobs', 3, 0.50, null);

-- Sunday Morning items
insert into checklist_items (checklist_id, text, section, sort_order) values
  ((select id from checklists where slug='sundayMorning'), '🙏 Pray', 'main', 1),
  ((select id from checklists where slug='sundayMorning'), '🛏️ Make Bed', 'main', 2),
  ((select id from checklists where slug='sundayMorning'), '🚽 Wee Wee', 'main', 3),
  ((select id from checklists where slug='sundayMorning'), '🚿 Shower', 'main', 4),
  ((select id from checklists where slug='sundayMorning'), '🪥 Brush Teeth', 'main', 5),
  ((select id from checklists where slug='sundayMorning'), '💧 Wash face', 'main', 6),
  ((select id from checklists where slug='sundayMorning'), '🧴 Moisturise', 'main', 7),
  ((select id from checklists where slug='sundayMorning'), '👕 Get Dressed', 'main', 8),
  ((select id from checklists where slug='sundayMorning'), '💧 Fill water bottle', 'main', 9),
  ((select id from checklists where slug='sundayMorning'), '🥞 Eat breakfast', 'main', 10),
  ((select id from checklists where slug='sundayMorning'), '👟 Put on socks & shoes', 'main', 11);

-- Sunday Evening items
insert into checklist_items (checklist_id, text, section, sort_order) values
  ((select id from checklists where slug='sundayEvening'), '🚽 Poo Poo', 'main', 1),
  ((select id from checklists where slug='sundayEvening'), '📖 Read Bible', 'main', 2);

-- Sunday Evening dinner
insert into checklist_items (checklist_id, text, section, sort_order) values
  ((select id from checklists where slug='sundayEvening'), '🍽️ Dinner', 'dinner', 1);

-- Rewards
insert into rewards (checklist_id, section, coins, deadline_hour, deadline_minute, message, priority) values
  -- Morning
  ((select id from checklists where slug='morning'), 'main', 3, 7, 45, '🎉 Amazing! You earned 3 kindness coins!', 2),
  ((select id from checklists where slug='morning'), 'main', 1, 8, 0, '⭐ Good job! You earned 1 kindness coin!', 1),
  -- Evening
  ((select id from checklists where slug='evening'), 'main', 3, 17, 0, '🎉 Amazing! You earned 3 kindness coins!', 2),
  ((select id from checklists where slug='evening'), 'main', 1, 18, 0, '⭐ Good job! You earned 1 kindness coin!', 1),
  ((select id from checklists where slug='evening'), 'dinner', 1, 19, 0, '🍽️ Dinner done! +1 coin!', 1),
  -- Holiday
  ((select id from checklists where slug='holiday'), 'main', 3, 12, 0, '🎉 Morning done! 3 coins earned!', 1),
  ((select id from checklists where slug='holiday'), 'afternoon', 3, 19, 0, '🎉 Afternoon done! 3 coins earned!', 1),
  -- Saturday
  ((select id from checklists where slug='saturday'), 'main', 3, 23, 59, '🎉 Saturday done! 3 coins!', 1),
  -- Sunday Morning
  ((select id from checklists where slug='sundayMorning'), 'main', 3, 9, 30, '🎉 Sunday morning done! 3 coins!', 1),
  -- Sunday Evening
  ((select id from checklists where slug='sundayEvening'), 'main', 3, 17, 0, '🎉 Sunday evening done! 3 coins!', 2),
  ((select id from checklists where slug='sundayEvening'), 'main', 1, 18, 0, '⭐ Good job! 1 coin earned!', 1),
  ((select id from checklists where slug='sundayEvening'), 'dinner', 1, 19, 0, '🍽️ Dinner done! +1 coin!', 1);
