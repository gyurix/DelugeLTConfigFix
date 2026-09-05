# Deluge ltConfig Fix

- One-line repair for the **ltConfig 2.0.0** Deluge plugin (tunes the download engine with profiles like "High Performance Seed").
- Bug: once any custom settings are saved, the plugin crashes at startup (`Failed to start plugin: ltConfig`) and the profile is silently ignored.
- Cause: `src/ltconfig/core.py:317` deletes entries from a list while reading through it, which Python forbids.
- Fix: `for k in settings.keys():` → `for k in list(settings.keys()):` — nothing else changed.
- Repo: `original/` = untouched upstream egg, `src/` = fixed source, `build.sh` = packs the installable file, `README.md` = this guide.
- History: commit 1 = original, commit 2 = fix + build + guide.

<details>
<summary>What you need</summary>

- A Linux computer with Deluge installed (`deluged` is enough).
- Helper tools: `git`, `python3`, `zip`/`unzip`.
- About 5 minutes.
</details>

<details>
<summary>Install the tools (Ubuntu / Debian)</summary>

- `sudo apt update`
- `sudo apt install -y git python3 zip unzip`
- Deluge itself, if missing: `sudo apt install -y deluged deluge-console`
</details>

<details>
<summary>Build</summary>

- `git clone git@github.com:gyurix/DelugeLTConfigFix.git`
- `cd DelugeLTConfigFix`
- `./build.sh`
- Result: `ltConfig-2.0.0-fixed.egg` (the repaired plugin).
</details>

<details>
<summary>Install into Deluge</summary>

- Plugins live in `~/.config/deluge/plugins/` on the Deluge computer.
- Stop Deluge.
- Back up the current file: `cp ~/.config/deluge/plugins/ltConfig-2.0.0.egg ~/ltConfig-2.0.0.egg.backup`
- Install the fixed one: `cp ltConfig-2.0.0-fixed.egg ~/.config/deluge/plugins/ltConfig-2.0.0.egg`
- Start Deluge and switch ltConfig on.
- Tested on Deluge 2.2.0 + libtorrent 1.2.20 on Debian.
</details>

<details>
<summary>Check it works</summary>

- In `~/.config/deluge/deluged.log`: `Found plugin: ltConfig 2.0.0` is there, `Failed to start plugin` is gone, `Core enabled` appears.
- ltConfig shows as enabled in Deluge and your profile survives a restart.
</details>

<details>
<summary>If something goes wrong</summary>

- Torrents and settings are unharmed by a plugin failure.
- Roll back: stop Deluge, `cp ~/ltConfig-2.0.0.egg.backup ~/.config/deluge/plugins/ltConfig-2.0.0.egg`, start Deluge.
- The untouched original is also kept in this repo under `original/`.
</details>

<details>
<summary>Credits</summary>

- ltConfig is by Ratanak Lun (https://github.com/ratanakvlun/Deluge-ltConfig); this repo only fixes the line above.
</details>
