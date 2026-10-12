# Dipesh Gupta - portfolio

The whole site is three files:

| File | What it is |
|---|---|
| `index.html` | Both pages of the site (all styles and scripts are inside it) |
| `reel.mp4` | The video on page one |
| `reel-poster.jpg` | The still picture shown before the video loads |

Keep the three names exactly as they are. The page looks for the video and the picture by these names, in the same folder.

## Put it online (about 10 minutes, free)

Button names on GitHub and Vercel change a little over time; look for the closest match.

### 1. GitHub: store the files
1. Create an account at github.com.
2. Click **New repository**. Name it `portfolio`, choose **Private**, click **Create repository**.
3. On the empty repository page click **uploading an existing file**.
4. Drag in `index.html`, `reel.mp4` and `reel-poster.jpg` (the three files themselves, not the zip).
5. Click **Commit changes**.

### 2. Vercel: publish them
1. Go to vercel.com and choose **Continue with GitHub**.
2. Click **Add New**, then **Project**.
3. Find `portfolio` in the list and click **Import**. If it is not listed, click the link to adjust GitHub permissions and allow Vercel to see that repository.
4. Leave every setting as it is (framework: **Other**) and click **Deploy**.
5. After about a minute Vercel shows your live address, ending in `.vercel.app`.

### 3. Updating later
Upload a new `index.html` to the same GitHub repository (**Add file**, then **Upload files**, then **Commit changes**). Vercel notices and republishes by itself.

## Good to know
- A private repository hides the project on GitHub. The published website is still public, and like any website its page code can be viewed in a browser.
- Never put passwords or secret keys in these files. When the admin page is added, its keys go into Vercel's settings, not into the repository.
