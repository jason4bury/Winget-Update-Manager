<p align="center">
  <img src="assets/logo.png" alt="Winget Update Manager logo" width="160">
</p>

# Winget Update Manager

A friendly window for winget: check for updates, upgrade, install and remove apps without the command line.

![Version](https://img.shields.io/badge/version-v1.03-5B7CFA)
![Platform](https://img.shields.io/badge/platform-Windows%2010%20%7C%2011-0078D6?logo=windows)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1%20%7C%207-5391FE?logo=powershell&logoColor=white)
![Licence](https://img.shields.io/badge/licence-MIT-green)
![Last commit](https://img.shields.io/github/last-commit/jason4bury/Winget-Update-Manager)

## ✨ Features

- **Check for updates** on launch, with outdated apps in a sortable list (Name, Id, Version, Available, Source).
- **Upgrade All**, or **Upgrade Selected** for one or several apps (Ctrl+click or Shift+click to pick more than one).
- **Search** winget's sources and **Install Selected** from the results.
- **Installed Apps** lists everything on the PC, including apps that didn't come from winget, with **Uninstall Selected**.
- **Exclude Selected** keeps chosen apps out of Upgrade All. Exclusions are winget pins, so they also apply to `winget upgrade --all` and to unattended mode.
- **Export List** and **Import List** copy a set of apps from one PC to another (`winget export` / `winget import`).
- **Details pane** that fills in by itself when you select an app: the publisher, licence, description, release notes and tags, plus Homepage and Release Notes buttons.
- **Live log** with a progress card, a Cancel button that also stops the installer winget started, and **Save Log**.
- **Tidy up new desktop icons** that installs and upgrades leave behind, only removing icons whose names match the apps involved.
- **Reset Sources** and **Diagnose Network** for the "Failed when searching source" errors, including proxy and SSL inspection checks.
- **Unattended mode** (`-UpgradeAll`) for Task Scheduler or Intune, with a log file and winget's exit code.
- **Light or dark**: the **Look** button picks Light, Dark or the same as Windows. **Help** (or F1) explains every button.
- Friendly pop-ups that say what each button does. For risky ones, Enter picks the safe answer.

## 🖼️ Screenshots

![Main window](docs/screenshots/main-window.png)

## 📋 Requirements

- Windows 10 or 11 with [App Installer](https://apps.microsoft.com/detail/9nblggh4nns1), which provides winget. winget 1.5 or later is needed for excluding apps (`winget pin`).
- Windows PowerShell 5.1 (built into Windows). PowerShell 7 also works when running the script yourself.
- Administrator rights. The app asks for them (UAC) when it starts.

## 📦 Installation

1. Download `Winget-Update-Manager-v1.03.zip` from the [latest release](../../releases/latest) and unzip it wherever you like to keep it.
2. Double-click **Winget Update Manager.cmd** in the unzipped folder. It makes a **Winget Update Manager** shortcut there and in the Start menu, and starts the app. From then on, use the shortcut, the Start menu or a pinned taskbar button.

The app asks for administrator rights (UAC) each time it starts. Nothing is installed and no Windows settings are changed. The shortcut runs the script with PowerShell's execution policy bypassed for that run only.

**From the repo:** clone it and double-click **Start Winget Update Manager.cmd**, or run:

```powershell
powershell -ExecutionPolicy Bypass -File .\src\Winget-Update-Manager.ps1
```

The script relaunches itself elevated, and in STA mode under PowerShell 7, so it can be started from any prompt.

### Why no exe

Home tools used to ship as PS2EXE exes, and antivirus programs (ESET among them) kept flagging those exes as generic trojans by mistake. A plain script and a shortcut give the same one-click start without the false alarms, and you can read exactly what runs. Up to v1.01 this app was `Winget Update Manager v1.01.exe`; from v1.02 it's the script release above.

### Build a release

Double-click **Build.cmd** in the repo folder. It reads `build.json`, checks every script for syntax errors and that `$script:AppVersion` matches the newest `CHANGELOG.md` entry, runs PSScriptAnalyzer if it's installed, copies the release files into `..\Builds\Winget Update Manager v<version>\`, zips that folder for the GitHub release, refreshes `..\Builds\Winget Update Manager.lnk` (what the Home Launcher starts) and scans the result with ESET's command-line scanner if it's installed.

## 🚀 Usage

Start Winget Update Manager (the shortcut, the Start menu, or **Winget Update Manager.cmd**) and accept the UAC prompt. It checks for updates straight away. Use the sidebar to switch between updates, search results, installed apps and excluded apps, then select apps in the list and use the matching **Selected** button. Type in the filter box to narrow the list; it only changes what's shown.

### Unattended mode (Task Scheduler or Intune)

Point the task at the script in the release folder (or `src\` in the repo) and tick **Run with highest privileges**:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Tools\Winget Update Manager v1.03\Winget-Update-Manager.ps1" -UpgradeAll -Silent
```

Started without admin rights, it asks for them (UAC), waits for the elevated run and returns winget's exit code.

| Switch | What it does |
| --- | --- |
| `-UpgradeAll` | Runs `winget upgrade --all` with no window. Excluded apps are skipped. |
| `-Silent` | Writes only to the log file, nothing to the console. Use this for scheduled tasks. |
| `-LogPath <file>` | Where to write the log (see Configuration for the default). |
| `-SkipUnknown` | Leaves out apps whose installed version winget can't detect. |
| `-IncludeStore` | Also uses the Microsoft Store (`msstore`) source. |
| `-KeepDesktopIcons` | Doesn't remove desktop icons created by the upgrades. |

It works as SYSTEM too: winget isn't on SYSTEM's PATH, so the app finds it in the App Installer folder. Apps installed for one user only aren't visible to SYSTEM and won't be upgraded that way.

### Troubleshooting

**"The msstore source requires that you view the following agreements"**
The Microsoft Store source needs an agreement accepted interactively. Leave "Skip Microsoft Store source" ticked (the default) to avoid it.

**"Failed when searching source; results will not be included: winget"**
Try **Reset Sources** first. If that doesn't help, run **Diagnose Network**: winget uses WinHTTP, which has its own proxy setting separate from the browser's, and web filters doing SSL inspection can corrupt winget's source download. `cdn.winget.microsoft.com` may need adding to the filter's inspection bypass list.

**`0x8a15000f` / "Data required by the source is missing"**
The local copy of the source index is damaged. From an elevated prompt:

```powershell
winget source remove -n winget
winget source add -n winget -a https://cdn.winget.microsoft.com/cache -t "Microsoft.PreIndexed.Package"
```

**An app is still listed after upgrading it**
Some packages list a different version in winget from the one the app reports to Windows (for example Internet Download Manager 6.43.18.1 in winget, 6.43.18 in Windows), so winget keeps offering the same update. The log explains this when it happens. It's harmless; **Exclude Selected** hides it until a newer version comes out.

## ⚙️ Configuration

| What | Where |
| --- | --- |
| Settings (checkboxes, window size and position, log height) | `%APPDATA%\Winget Update Manager\settings.json` |
| Unattended mode logs | `%ProgramData%\Winget Update Manager\Logs\upgrade-<date>-<time>.log` |
| Excluded apps | Stored by winget itself as pins (`winget pin list`) |

Settings from versions before v1.00 (`%APPDATA%\WingetUpdateManager`) are copied across on first run. There is no other configuration and no config file to edit.

## 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md).

## 📄 Licence

MIT. See [LICENSE](LICENSE).
