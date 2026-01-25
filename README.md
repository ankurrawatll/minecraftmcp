# Minecraft MCP Server

A Minecraft server setup for LAN multiplayer with world file synchronization via GitHub.

## Problem Statement

When hosting a LAN Minecraft server, the host's device may not always be available. This repository ensures that world files are continuously backed up and synchronized, allowing any team member to start the server with the latest world state.

## Repository Structure

```
MCServer/
├── world/              # World files (tracked in Git)
├── server.properties   # Server configuration
├── eula.txt           # EULA acceptance
├── ops.json           # Operator list
├── whitelist.json     # Whitelist (if enabled)
├── start.bat          # Server start script
└── README.md          # This file
```

## Prerequisites

1. **Java** - Minecraft server requires Java 17 or higher
2. **Git** - For syncing world files
3. **Minecraft Server JAR** - Download from [Minecraft.net](https://www.minecraft.net/en-us/download/server)

## Initial Setup

### 1. Clone the Repository

```bash
git clone https://github.com/ankurrawatll/minecraftmcp.git
cd minecraftmcp
```

### 2. Download Server JAR

Download the Minecraft server JAR file and place it in the repository root as `server.jar`.

You can download it from:
- [Minecraft Server Download](https://www.minecraft.net/en-us/download/server)

### 3. Configure Server

Edit `server.properties` to customize your server settings:
- `server-ip`: Your local IP address (for LAN)
- `server-port`: Port number (default: 25565)
- `max-players`: Maximum number of players
- `difficulty`: Difficulty level
- `gamemode`: Default game mode

### 4. Start the Server

**Windows:**
```bash
start.bat
```

**Linux/Mac:**
```bash
java -Xmx6000M -Xms4000M -jar server.jar nogui
```

## World File Synchronization Workflow

### When Stopping the Server

1. **Stop the server properly** (type `stop` in the server console)
2. **Commit and push world changes:**
   ```bash
   git add world/
   git commit -m "Update world files - [date/time or description]"
   git push origin main
   ```

### When Starting the Server

1. **Pull latest world files:**
   ```bash
   git pull origin main
   ```
2. **Start the server** using `start.bat` or the Java command

### Automated Sync Script

Use the provided `sync-world.bat` script to automate the sync process:

**Before starting server:**
```bash
sync-world.bat pull
```

**After stopping server:**
```bash
sync-world.bat push "Description of changes"
```

## Server Configuration

### Current Settings

- **World Name:** world
- **Difficulty:** hard
- **Game Mode:** survival
- **Max Players:** 10
- **Online Mode:** false (for LAN play)
- **Server IP:** Configured in server.properties

### Important Notes

- **Online Mode:** Currently set to `false` for LAN play. Set to `true` if you want to use official Minecraft authentication.
- **Whitelist:** Currently disabled. Enable in `server.properties` and manage via `whitelist.json`.
- **World Backup:** World files are automatically tracked in Git, providing version history and backup.

## Team Collaboration

### Best Practices

1. **Always pull before starting:** Ensure you have the latest world files
2. **Always push after stopping:** Share your changes with the team
3. **Use descriptive commit messages:** Help others understand what changed
4. **Coordinate server starts:** Only one person should run the server at a time

### Resolving Conflicts

If you encounter merge conflicts when pulling:
1. Stop the server if it's running
2. Resolve conflicts manually or use:
   ```bash
   git pull origin main --rebase
   ```
3. If conflicts persist, you may need to choose which version to keep

## Troubleshooting

### Server won't start
- Check Java version: `java -version` (need Java 17+)
- Ensure `server.jar` exists in the directory
- Check `eula.txt` is set to `eula=true`

### World files not syncing
- Ensure Git is properly configured
- Check repository remote: `git remote -v`
- Verify you have push permissions to the repository

### Connection issues
- Verify `server-ip` in `server.properties` matches your local IP
- Check firewall settings allow connections on port 25565
- Ensure all players are on the same network (for LAN)

## License

This repository contains Minecraft server files. Minecraft is a trademark of Mojang Studios. This setup is for personal/educational use.

## Contributing

When making changes:
1. Test locally first
2. Commit with clear messages
3. Push to main branch
4. Notify team members of updates

