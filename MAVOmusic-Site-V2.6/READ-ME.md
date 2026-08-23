# 📖 READ ME - running your own station (no programmer needed)

This is YOUR site manual. Two minutes of reading = full control forever.

## The 5 files that matter to you

| File | What it is |
|---|---|
| `playlists.js` | **THE song lists.** Add/remove all videos and shorts here - every screen reads it. |
| `index.html` | The home page (fire logo, menu, visitor counters). Rarely needs edits. |
| the other `.html` files | The 18 screens. You normally never open them. |
| `Localhost.ps1` | Double-click to test on your own PC → http://localhost:8000 |
| `Feedbacks-to-MD.ps1` | Turns the Netlify feedback export into numbered MD files (see below). |
| `CONTEXT.md` + `VERSION-LOG.md` | Project memory - for restore sessions with the AI, not for you. |

## ➕ Adding a song (long video or short - same recipe)

1. Open **`playlists.js`** in Notepad.
2. Find the list you want: `MAVO_LONGS` (full videos) or `MAVO_SHORTS` (verticals).
3. Scroll to the bottom of that list, to the line saying
   `// 👉 add new … entries ABOVE this line`.
4. Paste a line ABOVE it, in exactly this shape:
   ```js
   { url: "https://youtu.be/PASTE-YOUR-LINK", title: "A short description!" },
   ```
   - Links can be `youtu.be/…`, `youtube.com/watch?v=…`, `youtube.com/shorts/…`,
     or just the 11-letter ID. All work.
   - The `title` is whatever you want visitors to see. Keep the straight `"` quotes
     and the comma at the end of the line.
   - Adding **50 at once?** Just paste 50 lines. Nothing special needed.
5. **Ctrl+S** to save.
6. Check it: run `Localhost.ps1`, open http://localhost:8000 - the
   "Total videos in the spotlight" number on the home page jumps up automatically.
7. SONGS (the everyday job, V2.4): **no zip at all.** Open
   github.com/MAVOmusic/mavomusic-site → **playlists.js** → pencil icon → edit →
   **Commit changes** - the live site reads the lists from GitHub and updates
   itself within ~10 minutes. Works from any PC or your phone, zero uploads.
   SITE FILES (only when the design/screens change): re-zip the folder
   (Explorer → select all → Compress to ZIP) → Cloudflare → Workers & Pages →
   your mavomusic project → **New deployment** → drag the zip; then upload the
   same files into the GitHub repo (Add file → Upload files) so both match.
   (Netlify remains the untouched frozen backup - it charges credits per deploy,
   so just leave it alone.)

## ⚠ If a screen ever says "the list is empty"

99% of the time it's a typo in `playlists.js` - a missing comma, a smart quote
(`"` instead of `"`), or a missing brace. Since V2.4 the site uses the GITHUB
copy first, so check your last GitHub edit: repo → playlists.js → pencil →
look at the lines you just touched; fix, Commit, and the site heals itself
within ~10 minutes. (Safety net: if the GitHub copy cannot be read at all, the
site silently uses the packaged playlists.js from the zip - so an empty screen
means BOTH copies carry the typo.) Worst case: restore `playlists.js` from the
newest zip in `_To Attach/ZIP`.

## 🎛 What each screen does (cheat sheet)

- **Every screen deals a fresh shuffled queue on each visit** (V2.0) - nobody ever
  gets the same running order twice, and there is no "resume where I stopped"
  memory anymore. Each load starts at the top of a new deck.
- **The Marathon / Shorts Marathon** - everything back-to-back, sound on, forever.
- **Lucky Dip** - shuffled rounds, one video at a time; each dip starts from the
  visitor's own click ("🎲 Dip for the next one"). Nothing plays by itself.
- **TV Channels / Shorts TV** - channel-surfing with static hiss.
- **Jukebox** - keys 1–9 or taps; the box stays silent until a person picks a song.
- **Slow Drip** - one video per hour / one short per 15 min.
- **Prime Time** - evening broadcast window only.
- **MAVOradio / Bass Radio** - audio-first, live visualizer, video in the corner.
- **Pick & Play** - *the counting experiment:* autoplay is OFF; the visitor clicks
  each video's own ▶, then picks 1 of 5 when it ends. Views from here are as
  bulletproof as YouTube allows.
- **The Cinema / Shorts Cinema** - film-leader countdown between features.

## 🔢 Visitors counter

The four chips at the bottom (TODAY / WEEK / MONTH / ALL TIME) run on a free
badge service and count **page loads**, not unique humans. They reset themselves.
Nothing for you to manage.

## 🖱 The golden counting rule (hand-started plays)

Your own test proved it: **a view counts when a person presses play themselves.**
- Pick & Play, Jukebox and Lucky Dip (long + shorts) now wait for a human click
  for every single video. Autoplay stays ON only on the broadcast screens -
  Marathon, TV, Drip, Prime Time, Radio, Cinema - because their whole idea is
  a station that runs by itself.
- The home page tells visitors this rule under both menu sections. Keep those lines.

## 💬 The feedback box (Say it to the station)

- Visitors write name + message on the home page, right above the footer.
  Rules enforced on the page: name longer than 4 characters, message 10+ characters,
  no vulgar words, emojis welcome 🎸💚🔥❤️.
- A static website cannot write files into itself - so **Web3Forms** delivers the
  messages for you (since V2.3 / the Cloudflare move; Netlify Forms was the old
  engine). Every message lands **straight in your email inbox**, subject
  "MAVOmusic site feedback". You can also read them at web3forms.com → sign in
  with the email you used for the access key → your form → submissions
  (free plan keeps the last 30 days, 250 messages/month).
- Want them as numbered files? Copy the messages into a CSV (or export from the
  Web3Forms dashboard if it offers CSV), drop it next to `Feedbacks-to-MD.ps1`,
  right-click the script → *Run with PowerShell*. The script was built for the old
  Netlify CSV column names - if the Web3Forms export looks different, shout and
  the script gets a one-line update.

## 🔴 The stage on the home page (V2.0)

- When MAVO is OFF air, the middle frame shows two tabs - **LONG-FORM** and
  **SHORTS** - and plays the screens right there. The side menus load into that
  same stage, and the tab above it always lights the matching side by itself
  (left menu = LONG-FORM, right menu = SHORTS, never crossed). Shorts screens
  automatically get a phone-shaped 9:16 frame; long-form keeps the wide 16:9.
- When a stream window opens, the stage flips itself to **KICK / TWITCH** tabs
  and loads the Kick stream (autoplay asked, unmuted asked - browsers sometimes
  still force-mute embeds; one click inside the player fixes it).
- In the schedule sentence, **Kick** glows neon green and **Twitch** neon purple,
  both sitting 1px smaller than the rest of the line so they shine without shouting.
- The 12-day schedule speaks the visitor's language (V2.5): the timezone is
  auto-detected on page load, all rows show THEIR local start/end, and a little
  dropdown at the top of the plan lets anyone switch zones (the choice is
  remembered on their device). A stream that ended today greys out with
  "ended ✓" and the highlight jumps to the next stream by itself; a running
  stream shows a glowing LIVE NOW tag. Your overrides in index.html stay in UK
  wall time as always - the site converts for the visitors.
- Want a screen opened directly? Links like `mavomusic.co.uk/#marathon` or
  `mavomusic.co.uk/#shorts-pick-and-play` jump straight into that screen.
- The top menu (Home / About Me / Gallery / Song Search / Support) opens real
  pages above the station (V2.6). Their text lives inside `index.html` in the
  <template> blocks near the bottom - plain HTML, edit the words any time,
  nothing else to touch. Direct links like `mavomusic.co.uk/#/about` work too.

## 🖼 The backdrop

- The whole site's background is ONE file: `assets/bg-stairway.jpg` (the burning
  stairway), dimmed so the pages stay readable. Swap that file (keep the same
  name) and every one of the 19 pages re-skins in a single move. Embers float on
  top of it as before, just bigger and brighter since V2.0.

## 🧠 Good to know (honesty corner)

- YouTube counts ~4–5 replays per video per viewer per day. That applies to you,
  your friends, everyone. The site maximizes *eligible* plays; nobody can force more.
- Shorts views only register on YouTube's own player → that's what the
  **On-Site Surfer** Tampermonkey script (`_To Attach/JS/`) is for.
- Need to change a screen's timing (drip speed, prime-time hours, etc.)? Each
  screen still keeps its own small settings block at the top of its file -
  but SONGS always come from `playlists.js`.
