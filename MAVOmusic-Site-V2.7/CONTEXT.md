# CONTEXT BLOCK - MAVOmusic site project
*Read this file first when restoring a session. Attach: latest ZIP + this file + VERSION-LOG.md*
*Last updated: 2026-08-21 · Current site version: V2.2*

## Current state (V2.2) - read me first
- **REQUEST LIBRARY / Song Search (V2.7):** `songlist.js` = window.MAVO_LIB, one
  giant "Artist - Title"-per-line string - 48,368 unique ACTIVE songs, built
  2026-08-23 from StreamerSonglist CSVs (uploads/Main Library Part1+2.csv).
  Remote-first load from GitHub Pages like playlists.js (index.html only; the
  18 screens don't need it). Regeneration = fresh CSVs + rerun the builder
  (recipe in the file header). Song Search: normalized-substring match, 12
  library rows + up to 8 extra video rows; library rows carry ▶ chips (from
  playlists.js `song:` fields keyed by normalized Artist - Title) and a
  data-copy="!sr Artist - Title" chip; generic [data-copy] delegation handles
  all copy chips with Copied ✓ flash. Videos → library meta: optional
  `song:` field in playlists.js (26/199 auto-linked; **owner now supplies
  band - song with every new batch** - keep filling it; that is the twin-link).
- **Support page:** studio fund + crypto wall (11 coins, per-address copy chips,
  XRP memo chip, network warning). **About Me:** no hometown ever (owner:
  "no stalkers"); bio facts = 33, HU-born, UK since 2014, bass 2017/2019.
  Gallery crest removed (owner photos pending). Phone nav = 2 wrapped rows (3+2).
- **CACHE GHOST LESSON (2026-08-23):** after the Cloudflare cutover the owner's
  PC kept receiving the V2.1-era home page (phone fine) = edge-cached stale
  HTML. Remedy: dashboard → Caching → Purge Everything. Prevention shipped:
  `_headers` file in every zip (html + data files = max-age 0 must-revalidate,
  assets = 1 day). If staleness reports return, purge first, then check _headers
  survived the upload (it must sit at zip ROOT, name exactly `_headers`).
- **SITE MENU + PAGES (V2.6):** topnav pills under the logos (HOME/ABOUT/GALLERY/
  SONG SEARCH/SUPPORT). Pages = fixed overlay (#pageWrap z70, stairway backdrop)
  filled from <template id="pg-..."> blocks inside index.html - owner edits copy
  in plain HTML there. Hash routes "#/about" style via {mavoPage} state
  (theatre's #slug + {mavoScreen} untouched; both popstate listeners coexist).
  Deep links open directly; Esc/X close; .cur marks the pill. Gallery walls =
  10+10 random tiles from playlists.js (i.ytimg.com thumbs, onerror hides them
  when offline), links open YouTube new tab. Song Search = client-side filter of
  both shelves, chips LONG/SHORT, max 40, YouTube outbound. Support = free-first
  cards + copy-the-link button. .jumpplan/.jumpfb inside pages close the page
  then drive the ftab + smooth scroll (stopPropagation so the V2.5 .jumpplan
  delegation never double-fires). jsdom-proven 13/13.
- **HOSTING MIGRATION (2026-08-22, owner approved):** Netlify credit pricing (300/mo,
  15/deploy + bandwidth drain) caps us at ~2 deploys/month. V2.2 is live on Netlify
  with 40 credits left. We move DNS + hosting to **Cloudflare Pages** (free:
  unlimited bandwidth, unlimited Direct Upload deploys, custom domain + free SSL).
  **MIGRATION COMPLETE 2026-08-22 (evening UK).** Web3Forms key received → V2.3 zip
  shipped the form swap (chip SITE V2.3, V2.0 retired from ZIP rotation; keeps
  V2.1/V2.2/V2.3). Owner uploaded the zip via the NEW unified dashboard: Workers &
  Pages → "mavomusic" (Cloudflare now hosts static zips as a Worker-static project,
  prod URL mavomusic.archtvuk.workers.dev - no .pages.dev in the new UI), deleted
  A 75.2.60.5 + www CNAME in DNS Records, attached BOTH custom domains (new UI shows
  rows in the Domains table, no "Active" label). Sandbox-verified: apex + www serve
  SITE V2.3 with server: cloudflare, cf-cache-status HIT (CF edge caching = faster
  worldwide). Test feedback mail arrived. Gotcha seen: owner's browser kept showing
  the old cached chip after the flip - fix = Ctrl+F5, not a bug.
  Email forward = Namecheap eforward MX rows (keep those MX rows forever).
  Plan: (1) owner adds domain to Cloudflare, flips Namecheap nameservers;
  (2) feedback form engine swaps Netlify Forms → Web3Forms (free 250/month, access
  key from web3forms.com - awaiting owner's key); (3) V2.3 zip = form swap + docs,
  deployed by owner as Cloudflare Pages Direct Upload "mavomusic"; (4) custom
  domains mavomusic.co.uk + www attached in Pages, old Netlify A/CNAME records
  deleted (few minutes of cutover only); Netlify V2.2 stays untouched as backup.
  (5) Later: GitHub repo serves playlists.js raw so song edits need NO deploy, plus
  GitHub Pages mirror as second backup. V2.1 URL normalization already handles both
  /name and /name.html, so Cloudflare pretty URLs cannot repeat the stuck-tab bug.
- **Future control-panel roadmap (owner wish 2026-08-22):** login + admin panel,
  visitor song-request inbox, searchable CDLC index downloadable from anywhere.
  Architecture agreed: files live in **NordLocker 1TB** (already paid, encrypted
  vault, zero-knowledge so NO public URLs / no API / no WebDAV - warehouse only);
  panel later = Cloudflare Workers + D1 (free tier) + admin login. CDLC shelf stays
  PRIVATE (copyright). Nothing built yet.
- **Schedule engine (V1.13):** repeating 4-on/4-off cycle - windowForDay(y,m,d),
  PATTERN_ANCHOR = 24 AUG 2026 (first marathon day), long [14,26] / short [14,17] UK
  wall time; STREAM_OVERRIDES map for overtime days. Never reintroduce a static plan.
  **V2.5 visitor-clock layer:** auto-detects Intl timezone; #tzPick dropdown (18
  curated zones, localStorage "mavo_tz", default auto) re-renders #calRows in the
  visitor's own clock; lon2epoch() = London wall -> epoch (2-pass DST settle);
  rows refresh every 60s with LIVE NOW (glowing, .onair) / "ended ✓" (.calrow.done)
  tags, (+1d) marker on visitor-day spill, highlight hops to TOMORROW once today's
  stream ends (the 5PM bug is dead); #waitline tells the next start in visitor
  time; .jumpplan links (top line + waitline) open the SCHEDULE tab and
  smooth-scroll to it; schedline lost its hardcoded "9AM EST / 2PM BST" text.
  Banner countdown math (londonNow / tick) is UNCHANGED and still London-absolute.
- **NETLIFY PRETTY URLS (V2.1 root-cause find):** the live site REWRITES every
  `.html` link to `/name` (Netlify post-processing) - card hrefs arrive as
  "/shorts-tv", not "shorts-tv.html". Any filename matching in JS must normalize
  first (`String(f).split("/").pop().replace(/\.html$/, "")`). routeToStage,
  popstate and deep-link lookup all normalize since V2.1. Never compare hrefs
  literally again. (This was the "tabs stuck on long form" bug.)
- **CENTER STAGE (V2.0/V2.1):** offline → exactly TWO tabs (LONG-FORM / SHORTS) over
  #liveHolder; the V1.14 mini screen-tabs were REMOVED (owner: the side cards are
  the pickers). The lit tab always mirrors the clicked side (left=long,
  right=shorts, auto-flip on opposite click); a tab press loads SHELF[cat][0]
  (Pick & Play). live → KICK/TWITCH, Kick autoloads; mode flip resets to long.
  Theatre keeps MAVO_openScreen + "⛶ BIG" pill; MAVO_routeToStage bridges cards.
  **V2.1: shorts screens (regex ^(shorts-|bass-)) load into a 9:16 phone frame**
  (.liveframe.tall, height 52vh desktop / 72vh phone); long-form stays 16:9.
- **FRESH QUEUE EVERY VISIT (V2.0):** the 14 queue screens shuffle a .slice() of
  MAVO_LONGS/MAVO_SHORTS at load and start at index 0 - never the same order
  twice. rememberProgress=false (marathon, cinema, shorts-marathon, shorts-cinema);
  prime-time pair ignores its stored start. pick-and-play & lucky-dip already random.
- **BACKDROP (V2.0):** assets/bg-stairway.jpg (owner's artwork) sits under ALL 19
  pages - veil 0.74/0.88 on index, 0.82/0.93 on screens. 6 assets total; zip = 31.
- **Follow links (V2.0):** .lico.kick neon green, .lico.twitch neon purple, both
  font-size calc(1em - 1px) vs the sentence.
- **COMPACT MODE (V2.1):** screens tuned for the small in-stage frame via
  `@media (max-height: 540-560px), (max-width: 480-560px)` - pick×2 (scrollable
  picker, smaller video, hint = one line, no "That's the click..." tail),
  cinema×2 (valance hidden, pills/HUD re-docked), radio×2 (video z-index 1 BEHIND
  #center z-index 2, all text double-glowed). Keep compact blocks when editing
  those files.
- **STATION FACTS (weave into copy, owner brief V1.14):** bassist; 48,000-song
  all-genre request list; Rocksmith live sight-reading; shorts point to long-form twins.
  Used in colnotes, live chatline, tagline wheel. Phones get LINES_PH (scroll wording,
  ≤660px via matchMedia) - never say left/right on mobile.
- **Tagline wheel:** 6 rotating 3-line mottos, 7s interval, #tagline fade 0.45s. Owner
  hates repetitive copy AND em-dashes - keep both fresh and hyphenated.
- **Schedule engine (V1.12, index) - SUPERSEDED, see the V1.13/V2.5 bullet above.**
- **Style rule (owner, V1.12):** NO em-dashes anywhere on the site ("robotic AI
  character") - plain hyphens only in all future edits.
- **Home content renders at 125% scale (V1.9):** `main { zoom: 1.25 }` - owner's call
  after A/B screenshots. Only <main> content; fixed overlays/canvas/FX excluded.
  **Mobile ≤660px (V1.10): zoom back to 1** + spacing block (gaps, line-heights,
  feedback h2 wraps with <small> on its own line). Phones were crushed at 1.25.
- **INDEX LAYOUT (V1.7/1.8):** three-column `.stagelayout` - LEFT = long-form cards,
  CENTER = Kick live box + feedback form (feedback lives INSIDE the center column under
  the chat link), RIGHT = shorts cards (breakpoints 1150px/660px; center first on small).
- **Menus show SIX cards per side (V1.8):** Prime Time, Lucky Dip, Jukebox (and their
  shorts twins) are UNLISTED per owner; their files still ship in the zip and work by
  direct URL. Headings are bare "Long-Form"/"Shorts"; tagline = "Twelve screens, one low end."
  Cards compacted via `.sidecol .card/.cicon/.cname/.cdesc` overrides.
- **19 pages** = index + 9 long-form (marathon, lucky-dip, tv-channels, jukebox, drip,
  prime-time, radio, cinema, pick-and-play) + 9 shorts twins (shorts-* prefix, except
  bass-radio.html). Songs live ONLY in `playlists.js` (window.MAVO_LONGS / MAVO_SHORTS).
- **Autoplay policy (owner doctrine):** HAND-START screens = pick-and-play, jukebox,
  lucky-dip (both formats) - each video waits for the visitor's own click, because the
  owner's Pick & Play test proved hand-started shorts/videos count. AUTOPLAY kept only
  where it defines the concept: marathon, tv-channels, drip, prime-time, radio, cinema.
  Index teaches visitors the rule with tip lines under both section headers.
- **PLAYLISTS VIA GITHUB (V2.4, 2026-08-22 night):** all 19 pages load playlists.js
  from https://mavomusic.github.io/mavomusic-site/playlists.js FIRST (GitHub Pages =
  proper JS MIME + ~10-min cache; raw.githubusercontent is text/plain+nosniff =
  browsers refuse it, never use it). Inline fallback right after: if
  window.MAVO_LONGS&&MAVO_SHORTS unset (missing file / offline / typo),
  document.write loads the packaged playlists.js - the classroom pattern, order-safe.
  Repo: github.com/MAVOmusic/mavomusic-site (owner account MAVOmusic), Pages from
  main/root - doubles as second live mirror (☰ pill goes to github.io root there -
  known quirk, primary domain unaffected). Song edits = pencil on GitHub → live
  ≤10 min, ZERO deploys. When shipping a zip, keep the packaged playlists.js equal
  to the GitHub one.
- **Feedback box** (index, above footer): Netlify Forms (`name=feedback`, AJAX POST to
  "/", honeypot `bot-field`). Validation: name >4 chars, msg ≥10, word-boundary vulgar
  filter, emojis OK. Owner reads: Netlify → site → Forms; `Feedbacks-to-MD.ps1` turns
  the CSV export into `feedbacks\Feedbacks (N).md`. Static hosting CANNOT write files -
  do not promise MD files being written by the site itself. **V2.3: engine SWAPPED to
  Web3Forms (action + AJAX fetch to api.web3forms.com/submit, hidden access_key +
  subject fields, checkbox honeypot named botcheck, res.json success check). Owner
  reads messages in his email inbox or web3forms.com dashboard. The old Netlify POST
  "/" code is gone - Netlify Forms receives nothing after V2.3.**
- **FX spec:** cursor = `assets/bass-cursor.png` 24×22 plain transparent bass from
  uploads/0.gif (REAL GIF transparency - never black-key it, and per the owner: NO neon
  border, keep it raw), hotspot `23 0`, CSS `cursor: url("assets/bass-cursor.png") 23 0, auto;`
  on 19 pages.
- **Home-page LIVE box (V1.6, tabbed V1.11):** two tabs (KICK/TWITCH) load their embed
  lazily on click into #liveHolder - kick: player.kick.com/mavomusic?autoplay=true&muted=false;
  twitch: player.twitch.tv/?channel=mavomusic&muted=false&parent=location.hostname (parent
  REQUIRED by Twitch). Chat line under it swaps per tab (#liveChat). Schedule line platform-neutral.
- **Theatre & history (V1.6):** openScreen pushes `#slug` (history.pushState); Back =
  closeScreen via popstate; Forward reopens; deep links `/​#shorts-marathon` auto-open.
  Address bar never shows raw .html names - that was the owner's V1.5 "back button glitch".
  Slap = DUAL rings only: green #39ff14 + blue #00cfff (random 60–170px size, 15–75px
  rise, 0.55–0.9s). Embers = 150 loud particles (shadowBlur 26, white-hot 24%) on the
  9 SHORTS pages ONLY - on ≤660px phones they drop back to the classic values
  (130 / blur 16 / 18% / V1.14 radii) via `const mb = matchMedia("(max-width: 660px)")`
  in each ember IIFE (V2.1); index keeps its bigger 64-particle field on ALL devices. EMBERS BOUNCE OFF the shorts box (#phone /
  #screen / #miniPlayer rect, remeasured 2×/sec) - side walls + underside slide, flash on
  impact; never drift across the video (V1.7). Radio equalizer = 42-bar JS visualizer on
  radio+bass-radio.
- **V1.4 catastrophe lesson:** a bulk CSS edit once ate the `</style>` tag on 8 shorts
  pages → blank sites (only pick-and-play, a fresh file, survived). AFTER EVERY BULK
  EDIT: verify `grep -c "</style>"` per file AND `node --check` every inline script
  (write temp files; node --check /dev/stdin is broken in the sandbox).
- zip rule: 19 html + playlists.js + 6 assets (incl. bg-stairway.jpg since V2.0) +
  CONTEXT.md + VERSION-LOG.md + READ-ME.md + Localhost.ps1 + Feedbacks-to-MD.ps1
  (31 entries) → `MAVOmusic-Site-V<X>.zip` flat (Netlify-ready);
  `_To Attach/` sorted mirrors (JPG/ added at V2.0); max 3 zips (kept: V2.0, V2.1,
  V2.2; V1.14 retired at V2.2).

## What this project is
The official **MAVOmusic** website: a family of standalone HTML "watch station" screens
that auto-play YouTube videos/Shorts in sequence from an editable list ("container")
at the top of each file. Purpose: help friends' (and MAVOmusic's own) videos/shorts get
real watched plays in sequence, without using YouTube's playlist feature.

- **Owner:** MAVOmusic (bass guitar channel), Scunthorpe UK (Europe/London), Windows PC.
- **Live site:** https://mavomusic.co.uk (primary; www also attached) · origin
  https://mavomusic.archtvuk.workers.dev · backup mirror https://mavomusic.netlify.app
- **Registrar:** Namecheap - `mavomusic.co.uk`, expires 2027-08-20 (.com was taken since 2010).
  Privacy via Nominet auto-redaction (WhoisGuard "not available" for .uk = normal, address hidden).
- **Host (since 2026-08-22 evening): Cloudflare** (free, Workers static hosting via
  Workers & Pages → project "mavomusic" → **New deployment** → Direct Upload zip).
  Unlimited deploys + unlimited bandwidth - replaces Netlify (kept untouched, frozen
  at V2.2, as the backup mirror https://mavomusic.netlify.app). Origin URL:
  mavomusic.archtvuk.workers.dev. HTTPS: Cloudflare edge cert (auto). DNS: Cloudflare
  nameservers (bayan/jen); both custom domains attached; email MX rows untouched.
- **Local testing:** `Localhost.ps1` (HttpListener port 8000) → http://localhost:8000 (serves index.html).
  file:// breaks embeds with YouTube "Error 153" - every page warns if served wrong.

## Architecture (V1.2 - IMPORTANT)
- `index.html` **IS the launcher** (no more redirect hop, no separate launcher file).
- Visitors open screens via a **full-window "theatre" iframe overlay** inside index.html -
  the address bar NEVER changes: it stays `mavomusic.co.uk` while watching. Esc or
  "✕ Back to station" closes the overlay. This is why no PHP is needed (Netlify is
  static-only; JS overlay does the job).
- Every player's "☰ Station" pill links to `/` with `target="_top"` (leaves the overlay
  correctly, works on localhost too).
- Player FILE NAMES are still how the site loads them internally; visitors never see them.
- **`assets/` folder (V1.3):** `icon-horns.png` favicon on all 19 pages (owner's hornv2
  rock-hand), `logo-red.png` + `logo-white.png` flanking the fire title, `club-c.png`
  (owner-supplied official Club logo, replaces the ♣ placeholder), `bass-cursor.png`
  (AI-generated Thunderbird-bass silhouette cursor; index-wide custom cursor + double-ring
  "slap" ripple on click). NOTE: inside the theatre iframe the cursor is the default arrow -
  cursor CSS only lives on index.html.
- **Visitor counter (V1.3):** footer chips TODAY / THIS WEEK / THIS MONTH / ALL TIME built
  client-side from free `visitor-badge.laobi.icu` badges with period-rotating page_ids
  (`mavomusic-site.day-YYYY-MM-DD`, `-week-YYYY-Www`, `-month-YYYY-MM`, `-total`). It counts
  PAGE LOADS, not unique humans; chips self-hide if the service is down (onerror). If a real
  unique-visitor backend is ever wanted, upgrade path = Netlify Function + Netlify Blobs.
- Counting audit (V1.3): grepped every sound-on player - no mute() anywhere; autoplay
  watchdog overlays intact. Friend's non-counting plays were NOT a code bug; see
  "House rules" bullet - same per-viewer caps apply to friends too.
- **V1.4 additions:** `bass-cursor.png` rebuilt from owner's 0.gif (sunburst Thunderbird,
  black-keyed, 2px neon-orange glow border, hotspot at headstock tip); cursor + quad neon
  rising slap waves now on ALL pages (index + every player; YouTube's own video surface
  still shows its default pointer - cross-origin iframe, can't style inside it);
  ~70 burning embers animate every SHORTS page behind the video frame (#phone/#screen/
  #miniPlayer boosted above the ember canvas, curtains stay above embers on Cinema);
  radio's 8 static bars replaced with a 42-bar randomized bass-weighted visualizer
  (both radio pages); "Friend Radio" → "MAVOradio".

## File inventory (V1.4)
Root: `index.html` (fire-letter launcher, 3×3 grids ×2, embers, theatre overlay, live
spotlight counters) + **`playlists.js` - THE master song lists (the only file the owner
edits for songs; every screen reads `window.MAVO_LONGS` / `window.MAVO_SHORTS` from it,
index shows "Total videos in the spotlight: N" from it; optional per-video
`song: "Artist - Title"` links it into the request library)** + **`songlist.js` -
the 48,368-song request library for Song Search (window.MAVO_LIB, rebuilt from the
stream's CSV exports)** + `_headers` (cache rules, V2.7) + `READ-ME.md` (owner's manual).
Long-form (9): `marathon.html` · `lucky-dip.html` · `tv-channels.html` · `jukebox.html` ·
`drip.html` · `prime-time.html` · `radio.html` (station "MAVOradio", 42-bar live visualizer) ·
`cinema.html` · `pick-and-play.html` (manual-click experiment; autoplay OFF).
Shorts (9): `shorts-marathon.html` · `shorts-lucky-dip.html` · `shorts-tv.html` ·
`shorts-jukebox.html` · `shorts-drip.html` · `shorts-prime-time.html` · `bass-radio.html` ·
`shorts-cinema.html` · `shorts-pick-and-play.html`.
**Removed in V1.4:** both Loop Arena pages → replaced by Pick & Play
(`loop-arena.html`→`pick-and-play.html`, `shorts-loop-arena.html`→`shorts-pick-and-play.html`).

**Renamed in V1.2 (old → new):** YouTube - Fullscreen→marathon · YouTube - Shuffle Marathon→lucky-dip ·
YouTube - TV Channels→tv-channels · YouTube - Jukebox→jukebox · YouTube - Drip Feed→drip ·
YouTube - Prime Time→prime-time · YouTube - Radio→radio · YouTube - Loop Leaderboard→loop-arena ·
YouTube Shorts - Fullscreen→shorts-marathon · YouTube Shorts - Shuffle→shorts-lucky-dip ·
YouTube Shorts - TV Channels→shorts-tv · YouTube Shorts - Jukebox→shorts-jukebox ·
YouTube Shorts - Drip Feed→shorts-drip · YouTube Shorts - Prime Time→shorts-prime-time ·
YouTube Shorts - Radio→bass-radio · YouTube Shorts - Loop Leaderboard→shorts-loop-arena.
**Removed in V1.2:** the 4 CCTV wall pages (Player/Simple × long/shorts) - "not relevant on a
live website" per owner; they survive only inside the V1.0/V1.1 zips.

Browser-side extra (NOT on the website): `YouTube Shorts - On-Site Surfer.user.js` v1.1 -
Tampermonkey userscript that tours the Shorts list on youtube.com itself, because embedded
Shorts plays don't reliably count as views (YouTube rule since March 2025).

## New in V1.2: The Cinema / Shorts Cinema
Picture-house screen: velvet curtains, projector film-grain, circular film-leader countdown
(3-2-1 with tick sound) between every video/short, INTERMISSION card + reload at programme end
(re-checks for new links). Uses the shared player engine (click-to-start with sound, 6s autoplay
watchdog overlay, progress memory keys `yt_cinema_index_v1` / `yt_shorts_cinema_index_v1`).

## Current containers (master catalog, first 100 - owner files 2026-08-21)
**playlists.js = 100 long-form + 100 shorts** (master files "0001 - 0100"), in master
order. Titles = YouTube oEmbed verbatim (169 fetched); the 31 original boutique
one-liners kept. One flagged duplicate: **jnysCCBFHxs at LONG #0018/#0019** (kept as
delivered, comment in playlists.js, owner to confirm). l9CFRhtLGDo appears once in
the master - the old accidental duplicate is RESOLVED (owner's list is truth).
Home spotlight counters read list length automatically.

- House rules (do not regress) - **SONGS LIVE ONLY IN `playlists.js` (V1.4)**; per-screen
  timing knobs (drip speed, broadcast hours, leader length…) still live at the top of
  each screen's own file. **V2.4 add-on: the LIVE copy of playlists.js is the one in
  the GitHub repo (served via GitHub Pages); the packaged copy is the safety fallback
  - keep both identical whenever a zip ships.**
- Never YouTube playlists. No external dependencies; everything self-contained.
  Lists at the top of each file after "EDIT HERE"; full links or bare 11-char IDs both work.
- Visitor-facing voice everywhere on index.html (no editor/deploy jargon); filenames never displayed.
- Counting honesty (owner knows): own repeat views cap ~4–5/video/24h; muted loops = decoration;
  Shorts embeds don't count → On-Site Surfer. Long-form counting switches to first-frame on 2026-08-24.
- Socials footer: Kick/Twitch = MAVOmusic · YouTube = MAVOmusicYT · X = MAVO_music · Club = MAVOmusic.
  Icons are embedded data-URI favicons; **club.com had no favicon → purple ♣ placeholder SVG -
  replace when the real Club logo is known.**

## Versioning & tidy-workspace rules (owner's standing order)
1. Every edit session → new `MAVOmusic-Site-V<major.minor>.zip`. Zip contains site files flat
   (Netlify-ready / Cloudflare-Upload-ready) + `CONTEXT.md` + `VERSION-LOG.md` + `READ-ME.md`.
   Current: V2.2 (V2.3 = Web3Forms + migration docs, pending owner's access key).
2. `_To Attach/`: sorted subfolders by type - `ZIP/` `HTML/` `MD/` `JS/` `PS1/` `PNG/` `GIF/`
   `JPG/`. Nothing loose.
3. **Max 3 zips** in `_To Attach/ZIP/` - delete oldest when a 4th appears.

## Open items / pending
- **GITHUB PLAYLISTS PHASE - last mile (owner, right now):** repo + Pages exist,
  loader shipped in V2.4. Remaining: (1) extract MAVOmusic-Site-V2.4.zip, (2)
  GitHub repo → Add file → Upload files → drag ALL unzipped files incl. the
  assets folder → Commit, (3) Cloudflare → Workers & Pages → mavomusic →
  **New deployment** → same zip. Then song edits = GitHub pencil only.
  Zip V2.4 built this session; rotation retired V2.1 (kept: V2.2, V2.3, V2.4).
- Duplicate LONG jnysCCBFHxs = RESOLVED 2026-08-22: owner decided delete; the twin
  line (#0019) + NOTE comment are removed from the master playlists.js (longs = 99,
  counter auto). Owner had fixed his own PC copy earlier; workspace+live caught up.
  (Duplicate SHORT l9CFRhtLGDo had already been resolved by the master list.)
- "Also add a …" = CLOSED by owner 2026-08-22 ("was just a mistake, ignore it").
- Club icon placeholder pending real logo.
- Roadmap mentioned by owner: separate tabs/sections per friend ("different tabs for different
  friends") once their lists arrive; site to grow beyond YouTube pages ("more stuff").
  2026-08-22: owner confirmed the bigger dream - login + control panel with searchable CDLC
  archive (see roadmap bullet in Current state). NordLocker 1TB named as the file vault.
