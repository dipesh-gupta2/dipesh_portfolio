# Studio setup: edit the website from a browser

This connects the website to a free Supabase database, so you can change any text, add or remove projects, roles, skills, record entries and award cards, upload photos, see a live preview and publish. You do all of that in the studio, without touching code.

It takes about 20 minutes, once. Button names on Supabase, GitHub and Vercel change a little over time; look for the closest match.

## How it fits together

| Piece | What it does |
|---|---|
| `index.html` | The website. On every visit it asks Supabase for the published words. If the database is slow, asleep or not set up, it shows the words it was built with, so the site never breaks. |
| `admin/index.html` | The studio, at `yoursite.vercel.app/admin/`. Sign-in, editor, live preview, publish and versions. |
| `config.js` | The database address and its public key. Both start empty. |
| `supabase/setup.sql` | Creates the tables, the rules and the photo folder in Supabase. |
| `.github/workflows/keep-alive.yml` | Pings the database every three days so the free plan does not put it to sleep. |
| `vercel.json` | Safety headers: other websites cannot embed your pages, and search engines skip the studio. |

## 1. Put the new files on GitHub

Copy everything from this folder into your `portfolio` folder, replacing `index.html`, then push:

```bash
cd portfolio
git add -A
git commit -m "Studio: edit the site from the browser"
git push
```

If you upload through the GitHub website instead: drag in the files and the `admin` and `supabase` folders. Folders whose names start with a dot are often hidden or skipped, so add the keep-alive file by hand: **Add file**, then **Create new file**, type the name `.github/workflows/keep-alive.yml`, paste the contents of that file, and commit.

Vercel republishes by itself. The site looks exactly as before, and `/admin/` opens the studio in a try-it-out mode where nothing is saved.

## 2. Create the database

1. Go to supabase.com and sign in with GitHub.
2. Click **New project**. Name it `portfolio`, let it generate a database password (save it in your password manager; the website does not need it), pick the region closest to you (for India, Mumbai), and keep the **Free** plan.
3. Wait a minute or two while it starts.

## 3. Run the setup script

1. In the left bar, open **SQL Editor**, then **New query**.
2. Open `supabase/setup.sql`, copy all of it, paste it in, and press **Run**.
3. It should say **Success. No rows returned**. Running it again later is safe.

The script lets anyone read only the published words, and lets only the account with the email `dipeshg976@gmail.com` change anything. If you will sign in with another email, change it near the top of the script before you run it.

## 4. Lock the door, then make your account

1. Open **Authentication**, then **Sign In / Providers** (on some versions, **Providers** or **Settings**). Turn **off** "Allow new users to sign up" and save. Email sign-in stays on.
2. Open **Authentication**, then **Users**, then **Add user**, then **Create new user**.
3. Enter `dipeshg976@gmail.com` and a strong password you do not use anywhere else. Tick **Auto Confirm User** and create the user.

## 5. Tell the website where the database is

1. Open **Project Settings**, then **API Keys**. Copy the **Publishable key** (it starts with `sb_publishable_`). If you only see "anon" and "service_role", copy the **anon** key.
2. Copy the **Project URL** (under **Project Settings**, then **Data API**, or from the **Connect** button). It looks like `https://abcdefgh.supabase.co`.
3. Put both in `config.js`:

```js
window.SITE_CONFIG = {
  supabaseUrl: 'https://abcdefgh.supabase.co',
  supabaseKey: 'sb_publishable_...'
};
```

4. Commit and push (or edit `config.js` on GitHub and commit).

The publishable key is meant to be public: the rules from step 3 decide what it can do. Never put a **secret** or **service_role** key in any file of the site.

## 6. Open the studio

1. Open your website, scroll to the very bottom, and click the line **©2026 Dipesh Gupta** five times quickly. The studio opens. You can also type `/admin/` after your address.
2. Sign in with the email and password from step 4.
3. Pick a part of the site on the left, change the words, and watch the preview on the right. Your draft saves itself as you type.
4. Press **Publish**. Visitors see the new version on their next visit.

The first time you sign in, the studio starts from the words already on the site.

## 7. Turn on the keep-alive

1. On GitHub, open the repository's **Actions** tab. If it asks, enable workflows.
2. Click **Keep the database awake**, then **Run workflow**. A green tick means it reached the database.

From then on it runs every three days by itself.

## Using the studio

- **Lists**: every list (projects, roles, skills, record parts, award cards, links) has **Add**, and each item has move up, move down, duplicate and delete.
- **New part of the record**: in **Education and research**, press **Add list part** for anything new, such as a certifications list. It sits over the same giant water words, with its own title, number and entry in the menu. The giant words themselves are edited at the top of that screen.
- **Events and photos**: open **Events and photos**, press **Add event**, fill in the name and date, then **Upload photos** (pick many at once). The star sets the cover, the arrows set the order. On the site each event is a row in the record with its cover; clicking it opens a full-screen gallery where the photos come in row by row, and any photo opens on its own with arrows, swipe and the keyboard. Events without photos show as a plain line. You can also add a second, separate events part from **Education and research** with **Add events part**.
- **Whole new sections**: open **Added sections** (under Your sections) and pick a look: **Text and photo** (like About), **Cards** (like Projects), **List over water words** (like Education, with the same glowing giant words), **Events with photos** (like Events) or **Moving rows** (like Skills). Choose **Where it goes** (any place on either page, after a section you already have) and a **Name in the menu**. The preview jumps to the new section as soon as you add it or move it. Text and Cards can be light like the page, dark or blue.
- **Photos**: uploads are made smaller on your computer first (about 1800 px across, plus a small copy for grids), so each is usually a few hundred KB. A project photo replaces the drawn cover; the About photo fills the dark card.
- **Versions**: every publish is kept (the newest 50). **Restore** copies an old version into your draft; it goes live only when you publish.
- **Discard changes** throws away the draft and goes back to what is live.
- **Phone / Desktop** switches the preview size. On a phone, the **Edit / Preview** buttons take turns.

## Free plan limits

- Supabase Free: 500 MB database, 1 GB of photo storage, 5 GB of downloads a month, and a project is paused after a week without use (the keep-alive handles this). Your words take well under 1 MB.
- Vercel Hobby: free for personal, non-commercial sites, which a portfolio is.
- GitHub Actions on a private repository: 2,000 free minutes a month; the keep-alive uses about one minute every three days.

## If something goes wrong

- **The studio says the website is not connected**: `config.js` is still empty on the live site, or Vercel has not finished publishing.
- **"That email and password do not match"**: check the user in **Authentication**, then **Users**. You can reset the password there.
- **Saving or publishing fails with a security message**: the email you signed in with is not the one in the setup script. Fix the email in the script and run it again.
- **The site shows older words**: the database was asleep or unreachable, so the site fell back to the words it was built with. Open the studio once (that wakes it) and check the keep-alive on GitHub.
- **Locked out on a shared computer**: press **Sign out** when you finish. The sign-in is remembered in that browser until you do.
