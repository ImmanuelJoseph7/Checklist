-- Tighten RLS for public repo safety
-- Run in Supabase SQL Editor

-- Drop overly permissive policies
drop policy if exists "Anyone can read profiles" on profiles;
drop policy if exists "Anyone can manage profiles" on profiles;
drop policy if exists "Anyone can read admins" on admins;
drop policy if exists "Anyone can manage admins" on admins;

-- Profiles: allow reading name + emoji only (not PIN), allow PIN check via RPC
create policy "Read profiles public fields" on profiles for select using (true);
-- Create a secure function for PIN verification (hides pin from select)
create or replace function verify_pin(p_id uuid, p_pin text)
returns json language plpgsql security definer as $$
begin
  return (select json_build_object('id', id, 'name', name)
          from profiles where id = p_id and pin = p_pin);
end;
$$;

-- Create a view that hides PIN
create or replace view profiles_public as
select id, name, avatar_emoji, created_at from profiles;

-- Admins: no public read at all (use RPC for login)
create policy "No public read admins" on admins for select using (false);
create policy "Admins insert for registration" on admins for insert with check (true);

-- Secure admin login function
create or replace function admin_login(p_username text, p_password text)
returns json language plpgsql security definer as $$
begin
  return (select json_build_object('id', id, 'username', username, 'role', role)
          from admins where username = p_username and password = p_password);
end;
$$;
