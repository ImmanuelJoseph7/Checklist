// Supabase client init + helpers
const SUPABASE_URL = 'https://pcqxqkqigtdtgfstwlbl.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBjcXhxa3FpZ3RkdGdmc3R3bGJsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODE5NDg4MTYsImV4cCI6MjA5NzUyNDgxNn0.w499x0bOIs_JkWAuTmY_Qr-KxrG3nPr2uV37UO0w8M0';

const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// Session management
const Session = {
  getProfileId() {
    return localStorage.getItem('checklist_profile_id');
  },
  setProfileId(id) {
    localStorage.setItem('checklist_profile_id', id);
  },
  getProfileName() {
    return localStorage.getItem('checklist_profile_name');
  },
  setProfile(id, name) {
    localStorage.setItem('checklist_profile_id', id);
    localStorage.setItem('checklist_profile_name', name);
  },
  clear() {
    localStorage.removeItem('checklist_profile_id');
    localStorage.removeItem('checklist_profile_name');
  },
  isLoggedIn() {
    return !!this.getProfileId();
  }
};

// Data helpers with offline cache
const DB = {
  async getProfiles() {
    const { data, error } = await supabase.from('profiles').select('*').order('name');
    if (error) throw error;
    localStorage.setItem('cache_profiles', JSON.stringify(data));
    return data;
  },

  async verifyPin(profileId, pin) {
    const { data, error } = await supabase
      .from('profiles').select('id, name').eq('id', profileId).eq('pin', pin).single();
    if (error) return null;
    return data;
  },

  async getConfig() {
    const { data, error } = await supabase.from('config').select('*');
    if (error) throw error;
    const config = {};
    data.forEach(row => { config[row.key] = row.value; });
    localStorage.setItem('cache_config', JSON.stringify(config));
    return config;
  },

  async getChecklist(slug) {
    const { data, error } = await supabase
      .from('checklists').select('*, checklist_items(*), rewards(*)').eq('slug', slug).single();
    if (error) throw error;
    localStorage.setItem(`cache_checklist_${slug}`, JSON.stringify(data));
    return data;
  },

  async getAllChecklists() {
    const { data, error } = await supabase
      .from('checklists').select('*, checklist_items(*), rewards(*)').order('sort_order');
    if (error) throw error;
    localStorage.setItem('cache_all_checklists', JSON.stringify(data));
    return data;
  },

  async getDailyLog(profileId, date, checklistSlug, section) {
    const { data, error } = await supabase
      .from('daily_log').select('*')
      .eq('profile_id', profileId).eq('date', date)
      .eq('checklist_slug', checklistSlug).eq('section', section)
      .maybeSingle();
    if (error) throw error;
    return data;
  },

  async upsertDailyLog(log) {
    const { data, error } = await supabase
      .from('daily_log').upsert(log, { onConflict: 'profile_id,date,checklist_slug,section' })
      .select().single();
    if (error) throw error;
    return data;
  },

  async getHistory(profileId, startDate, endDate) {
    const { data, error } = await supabase
      .from('daily_log').select('*')
      .eq('profile_id', profileId)
      .gte('date', startDate).lte('date', endDate)
      .order('date');
    if (error) throw error;
    return data;
  },

  // Offline fallbacks
  getCachedConfig() {
    const cached = localStorage.getItem('cache_config');
    return cached ? JSON.parse(cached) : null;
  },
  getCachedChecklist(slug) {
    const cached = localStorage.getItem(`cache_checklist_${slug}`);
    return cached ? JSON.parse(cached) : null;
  },
  getCachedProfiles() {
    const cached = localStorage.getItem('cache_profiles');
    return cached ? JSON.parse(cached) : null;
  }
};
