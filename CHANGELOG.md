# Changelog

All notable changes to this project are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), with versions written as
v<major>.<minor> to match the exe names. History from before the move to this
numbering (1.0.0 to 1.15.4, as "WinGet GUI") is kept in
[docs/HISTORY-before-1.00.md](docs/HISTORY-before-1.00.md).

## [Unreleased]

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
