# Dipesh Gupta - portfolio

A two-page portfolio with a built-in editor (the studio).

| File | What it is |
|---|---|
| `index.html` | Both pages of the site; all styles and scripts are inside it |
| `reel.mp4`, `reel-poster.jpg` | The video on page one and its still picture |
| `favicon.ico`, `favicon.svg`, `apple-touch-icon.png`, `icon-192.png`, `icon-512.png`, `site.webmanifest` | The site icon in the browser tab, on phones and in search results |
| `config.js` | Where the site finds its database (empty until you set it up) |
| `admin/index.html` | The studio: sign in, edit, preview, publish |
| `supabase/setup.sql` | Run once in Supabase to create the tables, rules and photo folder |
| `.github/workflows/keep-alive.yml` | Keeps the free database awake |
| `vercel.json` | Safety headers for Vercel |
| `SETUP.md` | Step-by-step setup for the studio |

Keep the file names as they are; the pages find each other by these names.

## Hosting

GitHub (private repository) holds the files and Vercel publishes them. Every push to `main` republishes the site.

## The studio

Without a database the site shows the words it was built with, and `/admin/` opens in a try-it-out mode. To edit for real, follow `SETUP.md`.

The key in `config.js` is the public "publishable" key, which is safe to show: the database rules decide what it can do. Never put a secret or service_role key in any file here.
