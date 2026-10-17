# Disk-CleanUp-Tool

![Shell](https://img.shields.io/badge/Shell-Bash-4EAA25?logo=gnubash&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Linux-blue)

A lightweight Bash script that monitors disk usage on the root partition (`/`) and automatically clears the `/tmp` directory when usage reaches a configurable threshold. Every run is logged with a timestamp.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [How It Works](#how-it-works)
- [Automate with Cron](#automate-with-cron)
- [Warning](#warning)
- [Contributing](#contributing)

## Features

- Checks the disk usage percentage of `/`
- Cleans `/tmp/*` automatically when usage is at or above the threshold
- Logs every run to `cleanup.log` with timestamps (also prints to the terminal)
- Easy to schedule with `cron`

## Requirements

- Linux or any Unix-like system with Bash
- Standard tools: `df`, `awk`, `grep`, `tr`, `tee`, `date`
- `sudo` privileges (needed to remove files in `/tmp` owned by other users)

## Installation

```bash
git clone https://github.com/Aymane-Khmissou/Disk-CleanUp-Tool.git
cd Disk-CleanUp-Tool
chmod +x clean_disk.sh
```

## Usage

```bash
./clean_disk.sh
```

### Example output

Disk usage below the threshold:

```
[2026-10-17 10:30:00] Disk storage normal
```

Disk usage at or above the threshold:

```
[2026-10-17 10:30:00] WARNING: Disk storage is high!
```

## Configuration

Edit the variables at the top of `clean_disk.sh`:

| Variable | Default       | Description                                         |
|----------|---------------|-----------------------------------------------------|
| `MAX`    | `80`          | Disk usage percentage that triggers the cleanup     |
| `LOG`    | `cleanup.log` | Path of the log file (relative to where you run it) |

## How It Works

1. Reads the usage percentage of `/` using `df`.
2. Compares it with `MAX`.
3. If usage is **>= MAX**, it logs a warning and runs `sudo rm -rf /tmp/*`.
4. Otherwise, it logs that disk usage is normal.

## Automate with Cron

To run the script every day at 3:00 AM:

```bash
crontab -e
```

Add the line (use absolute paths):

```
0 3 * * * /path/to/Disk-CleanUp-Tool/clean_disk.sh
```

> **Note:** since the script uses `sudo`, cron needs passwordless sudo for this to work. Alternatively, add the job to root's crontab with `sudo crontab -e`.

## Warning

This script runs `rm -rf /tmp/*`, which **permanently deletes everything in `/tmp`**. Running applications may rely on files there (sockets, session files, temporary data). Test it on a non-critical machine before using it on production servers.

## Contributing

Contributions are welcome!

1. Fork the repository
2. Create a branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m "Add my feature"`
4. Push the branch: `git push origin feature/my-feature`
5. Open a Pull Request

Ideas for improvements:

- Clean other locations (package cache, old logs, etc.)
- Make the threshold and paths configurable via command-line arguments
- Send a notification (email, Slack) when cleanup is triggered

## Author

**Aymane Khmissou** - [@Aymane-Khmissou](https://github.com/Aymane-Khmissou)
