/* Where the website and the studio find the database.
   Fill in both values from Supabase: Project Settings, then API Keys (the Project URL is under Data API).
   The key here is the public "publishable" key (it starts with sb_publishable_, or on older projects
   it is the long "anon" key). It is meant to be seen: the database's own rules decide what it may do.
   Never put a "secret" or "service_role" key in this file.
   With both left empty the site simply shows the words it was built with. */
window.SITE_CONFIG = {
  supabaseUrl: 'https://mzmcyzfjxxqjxhdkrakv.supabase.co',
  supabaseKey: 'sb_publishable_RnZrEPctqSRUr7GEJNHA_w_BEK-y12D'
};
