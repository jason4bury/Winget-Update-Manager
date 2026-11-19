# Changelog

All notable changes to this project are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), with versions written as
v<major>.<minor> to match the release folder names. History from before the move to this
numbering (1.0.0 to 1.15.4, as "WinGet GUI") is kept in
[docs/HISTORY-before-1.00.md](docs/HISTORY-before-1.00.md).

## [Unreleased]

## [1.03] - 2026-11-19
### Added
- **Dark look.** A new **Look** button in the header switches between **Light** (the look so far,
  and the default), **Dark** and **Auto** (the same as Windows). The cards, list, buttons, details,
  About, Help, the message boxes and the title bar all follow it; the blue header, the mascot and
  the bright message badges stay the same. The new look is used the next time it starts.
- **Help.** A **Help** button in the header (or F1) explains updates, finding and installing apps,
  exclusions, moving to another PC, the details pane and log, the options, and what to do when
  winget has trouble.
- About lists both under 1.03.

## [1.02] - 2026-11-16
### Changed
- **No exe any more.** Antivirus programs (ESET among them) kept flagging the PS2EXE exe as a
  generic trojan by mistake, so the release is now the script itself: download
  `Winget-Update-Manager-v1.02.zip`, unzip it and double-click **Winget Update Manager.cmd**.
  It makes a shortcut there and in the Start menu and starts the app. Settings, logs and
  exclusions are unchanged.
- The app asks for administrator rights itself (UAC) when it starts, as the exe did.
- The taskbar button shows the app's own icon, and pinning it pins the app.
- The icon is now `assets\Winget-Update-Manager.ico` (was `assets\icon.ico`).
- `Build.cmd` replaces the shared `Build-Tool.ps1` build: it makes the release folder, its zip
  and `Builds\Winget Update Manager.lnk` for the Home Launcher, and ESET-scans them.
- About window lists what's new in v1.02, and opens straight away after the first time
  (the winget version is looked up once per session).

### Fixed
- Unattended mode (`-UpgradeAll`) started without admin rights returned 0 straight away after
  asking for elevation. It now waits for the elevated run and returns winget's exit code.

## [1.01] - 2026-11-11
### Changed
- **Details show automatically.** Selecting an app fills the Details pane by itself, so the
  Show Details button has gone. There's a short pause after each change of selection, so
  arrowing down the list doesn't start a winget lookup for every row passed. Double-clicking
  an app still works.
- Lookups run in the background, separate from the main winget job, so the list stays usable
  while details load. Moving to another app drops a lookup that's still running.
- Details already looked at are kept for the session and appear instantly when you go back.
- Selecting several apps lists them in the Details pane and asks you to pick just one.
- A lookup that takes more than 60 seconds, or that fails, can be retried by double-clicking
  the app. A lookup over 60 seconds is stopped, with a note saying so.

## [1.00] - 2026-11-07
First release in the house style. It carries over everything from 1.15.4, plus the
fixes below from the pre-upload review.

### Changed
- One name everywhere: **Winget Update Manager**. The script is now
  `src/Winget-Update-Manager.ps1` and the built exe is `Winget Update Manager v1.00.exe`.
- Settings moved to `%APPDATA%\Winget Update Manager\settings.json`. Settings saved by
  earlier versions in `%APPDATA%\WingetUpdateManager` are copied across on first run.
- Unattended logs moved to `%ProgramData%\Winget Update Manager\Logs`.
- The window icon is read from `assets\icon.ico` when running the script from the repo.
- Desktop icon tidy-up ignores very common words such as "bit", "app" and "Microsoft"
  when matching shortcuts to packages, so a new "Bitwarden" icon isn't removed just
  because "Adobe Acrobat Reader (64-bit)" was updated at the same time.
- Upgrade All explains what will happen when the last check found nothing to update.
- About window shows the copyright and licence, and its "What's new" list now covers v1.00.
- Reset Sources and Excluded Apps have their own icons instead of sharing them with
  Upgrade All and Exclude Selected.
- The picture shown when a list is empty is a little smaller, so it stays sharp at 150%
  display scaling.
- Function names follow PowerShell's approved verbs and singular nouns (for example
  `Write-AppLog` instead of `Append-Log`), and every message box uses the app's name as its
  title.
- Builds use the shared `Build-Tool.ps1` with `build.json`, which replaces `Build-Exe.cmd`.

### Fixed
- A check, search or list that failed (for example because a source couldn't be reached)
  was shown as "You're all up to date" or an empty list. It now says that winget couldn't
  get the list and points to Reset Sources and Diagnose Network.
- A search containing `"` or `%` could break the winget command line. Those characters are
  now ignored.
- Closing the window while Diagnose Network was running left its temp script behind.
- The log was read from disk twice on each refresh during Upgrade All and Import List.
