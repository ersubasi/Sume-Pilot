# SUME Pilot — Deploy to Railway via GitHub

This folder is a ready-to-push repo that serves the SUME landing page as a static
site on **Railway**. Railway builds the included `Dockerfile` (a tiny Caddy web
server) and serves `index.html`.

```
railway-deploy/
├── index.html        ← the site
├── Dockerfile        ← Caddy static server
├── Caddyfile         ← binds to Railway's $PORT, serves /srv
├── railway.json      ← tells Railway to use the Dockerfile
├── .dockerignore
└── .gitignore
```

---

## Step 1 — Put this folder on GitHub

Open Terminal and run (paths already filled in for your machine):

```bash
cd "/Users/Ersubasi2013/Desktop/BE UK Invest/SUME/Sume Reading/SUME Designs/Landing Page/railway-deploy"

git init
git add .
git commit -m "SUME pilot landing page"
git branch -M main
```

Create an empty repo on GitHub (no README/license), then connect and push:

```bash
# replace YOUR-USERNAME with your GitHub username
git remote add origin https://github.com/YOUR-USERNAME/sume-pilot.git
git push -u origin main
```

> No GitHub CLI? Create the repo at https://github.com/new (name it `sume-pilot`),
> then copy the two commands GitHub shows under **"…or push an existing repository"** —
> they're the same `git remote add` + `git push` as above.

---

## Step 2 — Deploy on Railway

1. Go to https://railway.app and sign in.
2. **New Project → Deploy from GitHub repo**.
3. Authorize Railway to access your GitHub (first time only) and pick **`sume-pilot`**.
4. Railway detects the `Dockerfile` and builds automatically. Wait for the build to go green.

## Step 3 — Get your live URL

1. Open the service → **Settings → Networking**.
2. Click **Generate Domain**. Railway gives you a public URL like
   `https://sume-pilot-production-xxxx.up.railway.app`.
3. That's your live pilot. Every `git push` to `main` redeploys automatically.

---

## How it works (no action needed)

- Railway sets a `$PORT` environment variable at runtime.
- `Caddyfile` binds to `:{$PORT}` (falls back to `8080` locally), so the service
  listens on the right port automatically.
- `try_files {path} /index.html` keeps it working as a single-page site.

## Test it locally first (optional)

If you have Docker installed:

```bash
docker build -t sume-pilot .
docker run -p 8080:8080 -e PORT=8080 sume-pilot
# open http://localhost:8080
```

## Custom domain (later)

In **Settings → Networking → Custom Domain**, add e.g. `sume.co.uk` and follow the
DNS records Railway shows. Free Railway TLS is applied automatically.

---

### Updating the site
Edit `index.html` (the address and the Order/Instagram links are currently
placeholders), commit, and push — Railway redeploys on every push to `main`.
