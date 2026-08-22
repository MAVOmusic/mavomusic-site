# VERSION LOG - MAVOmusic site

## V2.5 - 2026-08-23
- **The mod request, delivered:** the schedule now speaks every visitor's
  timezone. Auto-detected on page load (Intl API), and a curated dropdown at
  the top of the 12-day plan (18 zones, London to Auckland) overrides it - the
  choice is remembered per device (localStorage mavo_tz). All rows convert from
  the UK work-rhythm to the visitor's own clock via a real epoch conversion
  (2-pass DST-settling), proven in tests: 2PM London = 9AM New York, half-odd
  zones like India 6:30PM, and the GMT↔BST switchover week all correct.
- **Top line de-vintaged:** the hardcoded "9:00 AM EST / 2:00 PM BST" sentence
  is gone; it now points at the live amber countdown and the plan link.
  Offline, the waitline itself tells the next start in the visitor's own time
  ("Kicks off at 09:00 your time (Sun 23 Aug · auto New York)").
- **Under-the-video fix without moving anything:** the "just under the video ↓"
  links (top line + waitline) switch to the SCHEDULE tab and smooth-glide the
  page to it - one tap instead of scroll-hunting. Pane stays put; offering to
  move the whole pane above the video remains on the table if the owner wants.
- **The 5PM bug fixed:** rows re-render every minute; once today's window ends,
  the row greys out with "ended ✓" and the highlight jumps to the next stream
  (TOMORROW). A live window shows a glowing LIVE NOW tag on its row. Marathons
  crossing midnight get a small (+1d) marker when the end spills into the
  visitor's next day.
- Bottom line for him: overrides in index.html stay UK wall time; the site does
  the translating. Chip SITE V2.5.

## V2.4 - 2026-08-22 (night)
- **Zero-upload songs, forever:** all 19 pages now load playlists.js primarily
  from GitHub Pages (mavomusic.github.io/mavomusic-site/playlists.js) - the
  owner edits songs in a browser (repo → playlists.js → pencil → Commit) and
  the live site follows within ~10 minutes. The remote script loads
  parser-blocking exactly like the old local one, so every screen behaves
  identically, online or on localhost.
- **Self-healing fallback:** right after the remote include, an inline check
  (`window.MAVO_LONGS && window.MAVO_SHORTS || document.write(...)`) loads the
  packaged playlists.js whenever the GitHub copy is missing, unreachable, or
  has a syntax slip - a typo online can never blank the station.
  (raw.githubusercontent.com was unusable: nosniff plain-text, browsers refuse
  to run it as a script - GitHub Pages serves proper JavaScript.)
- **Bonus third home:** the repo is also a full live mirror at
  mavomusic.github.io/mavomusic-site/ (feedback form works there too). Known
  quirk: on the mirror, the ☰ Station pill jumps to the github.io root;
  mavomusic.co.uk is unaffected. Netlify stays frozen as backup nr 2 (V2.2).
- **Owner decisions applied:** duplicate long jnysCCBFHxs deleted (was the
  #0019 twin) → 99 longs + 100 shorts, spotlight counter honestly reads 199.
  The mysterious "Also add a …" sentence was declared a typo of life. RIP.
- playlists.js header + READ-ME rewritten for the new flow (songs = GitHub,
  site files = Cloudflare zip + repo upload). Chip SITE V2.4.

## V2.3 - 2026-08-22
- **The Cloudflare move, code side:** the feedback box no longer uses Netlify Forms.
  It now posts to Web3Forms (free 250/month, access key embedded in the form,
  hCaptcha-grade honeypot field `botcheck`). Same on-page validation (name >4,
  message ≥10, vulgar filter), same "on MAVO's desk" success line, same honeypot.
  Submissions land in the owner's email inbox and the web3forms.com dashboard.
  Without this swap the form would have died the day the domain left Netlify.
- **New home prep:** the zip is host-agnostic (Cloudflare Pages Direct Upload ready,
  still fine for Netlify drag-drop as a backup mirror). Domain DNS moved to
  Cloudflare nameservers (bayan/jen) the same day; the live cutover to Cloudflare
  Pages happens when the owner uploads this zip there + attaches the custom domains.
- Version chip bumped to SITE V2.3 (it lagged one version behind since the
  playlists-only V2.2 never touched index.html).
- No screen/behaviour changes otherwise - 19 pages, playlists, FX all identical.

## V2.2 - 2026-08-21
- **The first 100 arrived:** playlists.js now carries the owner's master catalog
  0001-0100 on both shelves - 100 long-form + 100 shorts, in master order. Titles
  pulled live from YouTube oEmbed (169 videos, verbatim own titles); the 31
  hand-written boutique titles for the original entries were kept.
- **The master list answered two old questions:** l9CFRhtLGDo appears ONCE there
  (the old accidental duplicate is officially gone), while the long shelf has
  jnysCCBFHxs twice (#0018/#0019) - kept as delivered and comment-flagged for the
  owner to confirm.
- Spotlight counters on the home page update themselves (they read list length).

## V2.1 - 2026-08-21
- **THE STUCK-TAB BUG FOUND AND KILLED:** Netlify's "Pretty URLs" silently rewrites
  every card link on the live site from "name.html" to "/name" - the shelf matcher
  compared strings literally, so no card ever matched its shelf and the tab above
  the frame looked frozen (owner: "stays on long form tab"). Routing now matches by
  bare page name, both URL shapes, machine-tested with the live URL rewriting
  simulated 1:1 in jsdom (9/9 scenarios pass). Back/Forward and #deep-links got the
  same normalization. Bug lived since V1.13's stage routing - nobody noticed because
  V1.14's tab row did the picking.
- **Stage frame flips shape for shorts:** any shorts screen (incl. Bass Radio) now
  loads into a phone-shaped 9:16 frame (height 52vh desktop / 72vh phone), long-form
  stays 16:9 - same rule on PC and phone.
- **Embers on phones:** the 9 shorts pages fall back to the classic V1.14 sizing on
  screens ≤660px (radius / shadowBlur / count / white-hot odds all conditional via
  matchMedia); the bigger V2.0 embers stay on PC everywhere, and the home-page field
  stays big on all devices (owner: "can stay current... on main screen").
- **Pick & Play fits its frame (long + shorts):** compact mode in short frames -
  video sized to leave room for its one-line hint; the "That's the click that
  counts." half-sentence removed by owner request; picker becomes scrollable with
  clamped 3-line titles so all five choices fit; HUD pills re-docked to the corners.
- **Radio readable again (radio + bass-radio):** the corner video now sits BEHIND
  the radio UI (z-index flipped) and every text line got a double text-shadow
  (black base + ember glow) so video colours never eat the words. EQ glow bumped.
- **Cinema uncovered (long + shorts):** compact mode hides the top valance, narrows
  the side curtains, shrinks + re-docks the Next/Restart/Fullscreen pills and the
  HUD into the corners, and reserves top/bottom room around the picture.
- Version chip reads SITE V2.1.

## V2.0 - 2026-08-21
- **The big pre-overhaul edition** (owner: "our most important edit before full
  overhaul with new ideas later").
- **Tabs over the player, simplified hard:** the six mini screen-tabs are GONE
  (owner: "we have them on left and right side"). Offline now shows exactly TWO
  tabs - LONG-FORM and SHORTS - over the stage. The side cards stay the real
  screen pickers, and the tab above the frame always follows the click: left menu
  = LONG-FORM lit, right menu = SHORTS lit, never crossed; clicking the opposite
  side flips the tab automatically. A tab press opens that shelf's front screen
  (Pick & Play). LIVE still flips to KICK/TWITCH. Behaviour machine-tested in
  8 scenarios (boot, both sides, both tabs, live flip, re-flip).
- **Fresh queue on every visit:** all 14 queue screens (marathon, tv, drip, radio,
  cinema, jukebox, prime-time + their shorts twins) now SHUFFLE their deck at load
  and start at the top - never the same running order twice (owner: "This makes
  view enjoyment better"). Resume memory (localStorage) switched OFF on marathon /
  cinema / shorts-marathon / shorts-cinema and both prime-time files. Pick & Play
  and Lucky Dip were already random. Shuffle verified 5/5 unique deals.
- **Stairway backdrop site-wide:** the owner's stairway artwork
  (`assets/bg-stairway.jpg`) is now the page background on all 19 pages, under a
  dark veil - lighter on the home page (0.74/0.88), heavier on screens
  (0.82/0.93) so players stay clean.
- **Embers turned up ("bit bigger and more intense"):** shorts pages 130 → 150
  particles, radius +~40%, glow shadowBlur 16 → 26, white-hot odds 18% → 24%;
  home field 46 → 64, bigger and brighter too. Bounce-off-the-video physics
  untouched.
- **Follow line polish:** the Kick link glows neon green, Twitch glows neon
  purple, and both render exactly 1px smaller than the sentence
  (`font-size: calc(1em - 1px)`) so they stand out by colour, not by size.
- Version chip reads SITE V2.0.

## V1.14 - 2026-08-21
- **Offline stage tabs, done right:** LONG-FORM / SHORTS are now category tabs, each
  switching to its own shelf of SIX screen tabs (Pick & Play / Marathon / TV / Drip /
  Radio / Cinema, mini-sized, wrapping on small screens). No more "tab loads the same
  picker" weirdness - every tab is its own screen, playing inside the stage. Side cards
  routed into the stage light up the matching shelf tab automatically.
- **Station facts woven in** (owner brief): bassist; 48,000-song all-genre request list;
  Rocksmith live sight-reading; shorts usually point to their long-form twin. Now told
  by: both column notes, the chat line under the live player, and the tagline wheel.
- **Tagline wheel goes responsive:** desktop phrases keep left/right wording, phones
  (≤660px) get their own six lines written around scrolling ("The live stream up top,
  the shelves waiting below..." etc.).
- **Follow line earned its icons:** linked Kick + Twitch favicons inline in the schedule
  sentence (reused from the footer assets, no extra size).
- Grammar fix: "your press = the view" replaced with proper sentences on both columns.
- Version chip reads SITE V1.14.

## V1.13 - 2026-08-21
- **Schedule = the real work rhythm:** the plan is now a repeating 8-day cycle
  (4 marathon days 2PM-2AM, then 4 short days 2PM-5PM UK, anchored 24 AUG 2026) instead
  of the "back to normal after 31 AUG" fib. Overtime hook: add a day to
  STREAM_OVERRIDES in index.html ("YYYY-MM-DD": [14,17]) and that day goes short.
  Countdown + calendar share the same windowForDay function - one source of truth.
- **Calendar box rolls:** SCHEDULE tab now shows the next 12 days generated from the
  rhythm (TODAY labelled, marathons flagged, footer explains the 4-on/4-off pattern).
- **CENTER STAGE SWAP (main idea shipped):** when no live stream is running, the tabs
  above the middle frame become LONG-FORM / SHORTS and load Pick & Play (long or shorts)
  INTO the middle frame; side-column cards also route into the same stage while offline
  (with a small "⛶ BIG" pill for full-screen theatre). The moment the countdown hits a
  live window, the tabs flip back to KICK/TWITCH and the Kick stream loads front and
  center; cards return to overlay behaviour. No second option needed.
- **Rotating taglines:** six 3-line catchy mottos fade-rotate every 7 seconds under the
  fire title (first one is the owner's approved text).
- Version chip reads SITE V1.13.

## V1.12 - 2026-08-21
- **Every "—" purged** from all 19 pages + playlists.js (owner: "it's a robotic
  character"). Plain hyphens everywhere now, including the footer &mdash;.
- **Tagline is 3 lines** exactly as specced, ending "Pick a screen -> press play ->
  settle in."
- **WATCH NOW is schedule-aware:** during a stream window the green ON-AIR line shows;
  outside it, an amber "NEXT STREAM IN hh:mm:ss" counts down live, plus a "while you
  wait - check out the videos" pointer line. Windows computed in Europe/London with
  past-midnight marathon spillover handled; after 31 AUG it falls back to the regular
  daily 2PM-5PM. Logic unit-tested against 8 edge cases.
- **Schedule/Feedback tabber** (sits over the All Rights Reserved line, behaves like the
  KICK/TWITCH tabs): SCHEDULE is the default tab - a calendar box listing 21-31 AUG
  exactly as the owner announced (24-27 AUG flagged as 12h marathons, today's row gets a
  green outline); FEEDBACK tab holds the message form. Calendar rows render from the same
  STREAM_PLAN object that drives the countdown - one source of truth, both in
  index.html with an EDIT HERE comment.
- Version chip reads SITE V1.12.

## V1.11 - 2026-08-21
- **Kick + Twitch as two switchable tabs** above the live frame (over the feedback box):
  tab-styled KICK (green glow when active) / TWITCH (purple glow when active) buttons.
  No player loads until the visitor picks a platform (saves bandwidth, no double embeds);
  switching unloads the other. Chat/requests line under the player swaps variant per tab
  → kick.com/mavomusic or twitch.tv/mavomusic. Schedule line now platform-neutral.
  Twitch embed gets the required `&parent=<hostname>` automatically (works on the domain,
  the netlify mirror and localhost).
- Version chip reads SITE V1.11.

## V1.10 - 2026-08-21
- **Mobile pass (owner's phone screenshots):** the desktop 1.25 zoom made phones look
  crushed. Now ≤660px renders at zoom 1 with deliberate breathing room: larger gaps
  between sections/cards, ~1.65 line-heights on schedule/watch/chat/notes, padded
  cards, airier feedback rows. Desktop unchanged (still zoom 1.25).
- Feedback title on phones: "SAY IT TO THE STATION" keeps its line, the
  "· lands straight on MAVO's desk" note drops to its own second line (was falling off
  the right edge because of nowrap).
- Version chip reads SITE V1.10.

## V1.9 - 2026-08-20
- Home page now RENDERS like a 125% browser zoom at 100% zoom: `main { zoom: 1.25 }`.
  Owner compared screenshots: 125% was the sweet spot. Theatre overlay, ember canvases,
  slap FX and fixed HUDs are outside <main>, so they stay native-size on purpose.
  (Single knob: change 1.25 in the main rule if it ever feels too big on small laptops.)
- Version chip reads SITE V1.9.

## V1.8 - 2026-08-20
- **Menus trimmed to 6 per side:** Prime Time, Lucky Dip and Jukebox dropped from BOTH
  menu columns per owner. The six pages still exist in the package and open fine by
  direct URL (…/lucky-dip.html etc.) - just unlisted from the home page now.
- Column heading subtitles ("nine full screenings" / "nine quick bursts") removed;
  LONG-FORM and SHORTS headings stand centered alone. Tagline rewritten
  ("Twelve screens, one low end.").
- Cards slimmed: tighter padding, smaller icon/title/description, less column gap -
  the dead air at the top of each menu box is gone.
- **Feedback box moved into the center column** (right under the live-stream frame) -
  that was the dead space the owner flagged. Box is wider (100% of the middle column)
  and taller (title fits one line incl. the "lands straight on MAVO's desk" note,
  name/message fields enlarged, message area min-height 128px).
- Version chip reads SITE V1.8.

## V1.7 - 2026-08-20
- **Home page rebuilt around the live stream:** the menus now flank the Kick player -
  LONG-FORM column on the left, SHORTS column on the right, live stream in the middle.
  (Tablet ≤1150px: player on top, columns side by side; phone ≤660px: stacked player first.)
- Each column now tells visitors what the lists ARE: YouTube videos / Shorts recorded
  during the live streams, uploaded to the channel - "a growing database", plus the
  hand-start counting note survives inside each column.
- Production banner line ("You are on the official MAVOmusic station…") removed per
  owner; the localhost/file:// helper banners stay for local testing only.
- **Ember physics:** embers now BOUNCE OFF the shorts box - side-wall deflection +
  underside slide with a brightness flash on impact - instead of drifting across the
  video surface. Applies to all 9 shorts screens (target = #phone / #screen /
  #miniPlayer, remeasured every 500 ms).
- Version chip reads SITE V1.7.

## V1.6 - 2026-08-20
- **Cursor v3:** all neon border removed per owner - now the plain transparent bass from
  `0.gif` at the approved cursor size (24×22, hotspot 23 0) on all 19 pages.
- **LIVE box on the home page** (under the welcome, above the menus): schedule line in
  icy neon cyan - "LIVE every day from 9:00 AM EST / 2:00 PM BST, follow on Kick" -
  then the green-neon "WATCH NOW" call, then the embedded Kick player
  (`player.kick.com/mavomusic?autoplay=true&muted=false`, 16:9 neon-framed), and a line
  pointing chat + live song requests to the official stream page (kick.com/mavomusic).
  Note: browsers may still force-mute autoplaying embeds (their policy, not ours) -
  one click inside the player restores sound.
- **Back-button fix (theatre):** opening a screen now pushes `#screen-name` onto the
  address bar (always mavomusic.co.uk, never a raw .html filename). Browser Back closes
  the screen back to the menu, Forward reopens it, Esc/✕ behave the same, and
  `mavomusic.co.uk/#shorts-marathon`-style links now open that screen directly.
- Version chip reads SITE V1.6.

## V1.5 - 2026-08-20
- **CRITICAL FIX - shorts screens restored:** the V1.4 ember-CSS edit had swallowed the
  `</style>` closing tag on all 8 older shorts screens (browser swallowed the whole page
  as CSS → blank). Root cause found and fixed; only Pick & Play (fresh file) survived V1.4.
- **Cursor v2 (owner's icon, done right):** rebuilt from `uploads/0.gif` using its REAL
  GIF transparency (no black background), shrunk 51×48 → 24×22 (true cursor size),
  crisp 2px **red neon border** + tight red halo. Hotspot now `23 0` (headstock tip)
  on all 19 pages.
- **Slap waves: back to DUAL** - exactly 2 rings per click, neon **green #39ff14** +
  neon **blue #00cfff** only (random size/rise kept). Updated on all 19 pages.
- **Embers finally visible:** ~130 glowing particles per shorts page (bigger radii,
  white-hot sparks mixed in, 16px fire glow, higher brightness) - still behind the
  video frame and cinema curtains. Home page embers boosted modestly (46, soft glow).
- **Hand-start doctrine (the counting rule):** Jukebox (long+shorts) and Lucky Dip
  (long+shorts) no longer auto-chain - every video waits for the visitor's own click
  (jukebox: pick a card / key; lucky dip: "🎲 Dip for the next one" button; pick & play
  already manual). Autoplay stays ONLY on the broadcast screens where it defines the
  concept: Marathon, TV Channels, Slow Drip, Prime Time, Radio, Cinema (+ shorts twins).
  Owner's own Pick & Play test confirmed: hand-started shorts DO count now.
- **Menu order:** Pick & Play is now the FIRST card in both sections. Tip lines under
  both menu headers teach visitors: views count only when a person presses play.
- **Feedback box:** on the home page above the footer. Name >4 chars, message ≥10 chars,
  vulgar-word filter (word-boundary safe - "bass"/"Scunthorpe" pass), emojis welcome 🎸💚🔥❤️.
  Delivered by Netlify Forms (static sites cannot write files; Netlify collects them).
  `Feedbacks-to-MD.ps1` converts the Netlify CSV export into numbered
  `feedbacks\Feedbacks (1).md / (2) / (3)…` for the owner.
- Version chip reads SITE V1.5.

## V1.4 - 2026-08-20
- **Master playlists:** new `playlists.js` holds MAVO_LONGS + MAVO_SHORTS once; all 18
  players + the home page read from it. Home page now shows live "Total videos in the
  spotlight: N" counters under both section headers. `READ-ME.md` added - the owner's
  self-service editing manual (add songs in Notepad, save, re-zip, deploy).
- **Pick & Play replaces Loop Arena** (long + shorts): autoplay OFF, the visitor picks
  1 of 5 random tracks (thumbnail cards) and starts each video with YouTube's own ▶ -
  the bulletproof-view experiment the owner asked for. "STARTED BY HAND" live counter.
- **FX everywhere:** new cursor from owner's 0.gif (sunburst Thunderbird, 2px glowing
  border), quad neon random-sized rising slap waves on every page; ~70 burning embers
  on all shorts pages (behind video frame & cinema curtains); radio gets a 42-bar
  randomized live visualizer on both radio pages; "Friend Radio" renamed MAVOradio.

## V1.3 - 2026-08-20
- **Branding round:** tab title is now just "MAVOmusic"; horns favicon (owner's hornv2.png)
  on all 19 pages; red + white MAVOmusic logos flank the flaming title (sized to fit);
  official blue-C Club logo replaces the ♣ placeholder in the socials row.
- **Bass identity pack:** Thunderbird-bass mouse cursor across the home page
  (AI-generated silhouette, white-keyed to transparency) + a double-ring "slap" soundwave
  ripple on every click.
- **Visitor counter:** footer row TODAY / THIS WEEK / THIS MONTH / ALL TIME via
  visitor-badge.laobi.icu badges with period-rotating page_ids (counts page loads,
  not uniques; self-hides if the free service is unreachable).
- New `assets/` folder served flat (works on Netlify + Localhost.ps1); `_To Attach/PNG/`
  added to the attachment bundle. V1.0 zip retired per the 3-zip rule.
- Counting audit: no muted playback exists anywhere in the sound-on family - watched
  plays are as eligible as YouTube allows; per-viewer daily caps are policy, not a bug.

## V1.2 - 2026-08-20
- **Theatre architecture:** `index.html` is now the launcher itself; screens open in a
  full-window iframe overlay, so the address bar ALWAYS reads `mavomusic.co.uk` - no page
  names in the URL, no PHP required (Netlify is static; JS overlay does the routing).
- **Face-lift for visitors:** removed the CCTV Wall Player + Simple pages on both sides
  (editor tools, not visitor features) → 8 each; added **The Cinema / Shorts Cinema**
  (film-leader countdown, projector grain, velvet curtains) → **9 long + 9 shorts in two
  3×3 grids**. All card titles/descriptions rewritten in visitor voice; file names no
  longer displayed; "20 screens / edit-re-zip" tagline gone.
- **Professional file names:** all players renamed (e.g. `YouTube - Fullscreen.html` →
  `marathon.html`, `YouTube Shorts - Radio.html` → `bass-radio.html`; full map in CONTEXT.md).
  Players' back link is now "☰ Station" → `/` (target `_top`); page titles rebranded.
- **Extra effects:** floating ember particle field + hover glow/tilt on cards.
- `Localhost.ps1` default page now `index.html`; PS1 now kept in `_To Attach/PS1/`.
- Version chip on the footer reads SITE V1.2.

## V1.1 - 2026-08-20
- Launcher rebranded: "Welcome to MAVOmusic!" flaming fire letters; footer became
  "MAVOmusic 2026 - All Rights Reserved." + socials line with embedded brand icons,
  bold red-burning name links (Kick/Twitch/YouTube/X/Club).
- Own-content containers everywhere: 16 long-form + 16 Shorts (titles auto-fetched via
  oEmbed) across all 20 players and the On-Site Surfer userscript (→ v1.1).
  ⚠ l9CFRhtLGDo appears twice in the Shorts list (pasted twice; flagged).
- Environment-aware banner; versioning + `_To Attach/` structure + 3-zip retention created;
  CONTEXT.md + VERSION-LOG.md now ship inside every zip.

## V1.0 - 2026-08-20
- First public release: index redirect + launcher + 10 long-form + 10 Shorts players;
  deployed to Netlify ("mavomusic"); custom domain mavomusic.co.uk attached via Namecheap
  DNS (A @ 75.2.60.5, CNAME www → mavomusic.netlify.app); Let's Encrypt HTTPS live.
- Players: sequential fullscreens (click-to-start + swipe-up Shorts), CCTV walls, Shuffle,
  TV Channels, Jukebox, Drip Feed, Prime Time, Radio, Loop Leaderboard.
- On-Site Surfer userscript created (embedded Shorts don't count views → play them on
  youtube.com itself via Tampermonkey).
