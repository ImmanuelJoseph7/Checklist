-- Add admin roles and approval workflow
-- Run this in Supabase SQL Editor

alter table admins add column if not exists role text default 'pending';
-- roles: 'super', 'admin', 'pending'

-- Update existing admin to super
update admins set role = 'super' where username = 'admin';
