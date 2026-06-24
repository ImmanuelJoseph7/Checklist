// Supabase client + DB-driven state helpers
const SUPABASE_URL = 'https://pcqxqkqigtdtgfstwlbl.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBjcXhxa3FpZ3RkdGdmc3R3bGJsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODE5NDg4MTYsImV4cCI6MjA5NzUyNDgxNn0.w499x0bOIs_JkWAuTmY_Qr-KxrG3nPr2uV37UO0w8M0';

const _supabaseLib = window.supabase;
const sb = _supabaseLib ? _supabaseLib.createClient(SUPABASE_URL, SUPABASE_ANON_KEY) : null;

// Session
const Session = {
  getProfileId() { return localStorage.getItem('checklist_profile_id'); },
  getProfileName() { return localStorage.getItem('checklist_profile_name'); },
  setProfile(id, name) {
    localStorage.setItem('checklist_profile_id', id);
    localStorage.setItem('checklist_profile_name', name);
  },
  clear() {
    localStorage.removeItem('checklist_profile_id');
    localStorage.removeItem('checklist_profile_name');
  },
  isLoggedIn() { return !!this.getProfileId(); }
};

// DB operations
const DB = {
  async getProfiles() {
    const { data, error } = await sb.from('profiles').select('id, name, avatar_emoji').order('name');
    if (error) throw error;
    return data;
  },

  async verifyPin(profileId, pin) {
    const { data, error } = await sb.rpc('verify_pin', { p_id: profileId, p_pin: pin });
    if (error) return null;
    return data;
  },

  async getConfig() {
    const { data, error } = await sb.from('config').select('*');
    if (error) throw error;
    const config = {};
    data.forEach(row => { config[row.key] = row.value; });
    return config;
  },

  async getAllChecklists() {
    const { data, error } = await sb.from('checklists')
      .select('*, checklist_items(*)').order('sort_order');
    if (error) throw error;
    return data;
  },

  // Get today's state for a kid + slug (or create empty)
  async getState(profileId, date, slug) {
    const { data, error } = await sb.from('daily_state')
      .select('*')
      .eq('profile_id', profileId).eq('date', date).eq('checklist_slug', slug)
      .maybeSingle();
    if (error) throw error;
    return data;
  },

  // Upsert state (called on every tick)
  async saveState(state) {
    const { data, error } = await sb.from('daily_state')
      .upsert(state, { onConflict: 'profile_id,date,checklist_slug' })
      .select().single();
    if (error) throw error;
    return data;
  },

  // History: get all states for a kid in a date range
  async getHistory(profileId, startDate, endDate) {
    const { data, error } = await sb.from('daily_state').select('*')
      .eq('profile_id', profileId)
      .gte('date', startDate).lte('date', endDate)
      .order('date');
    if (error) throw error;
    return data;
  }
};
