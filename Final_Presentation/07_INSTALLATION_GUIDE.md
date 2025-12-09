# Installation & Setup Guide
## NSU CSE499 - GTA V Roleplay Server

---

## Table of Contents
1. Prerequisites
2. System Requirements
3. Installation Steps
4. Configuration
5. First Launch
6. Testing
7. Troubleshooting
8. Maintenance

---

## 1. Prerequisites

### Required Software
- [ ] **MySQL Server** (8.0 or MariaDB 10.6+)
- [ ] **FiveM Server** (Latest artifact)
- [ ] **Git** (for version control)
- [ ] **Text Editor** (VS Code recommended)

### Required Accounts
- [ ] **FiveM Account** - https://keymaster.fivem.net/
- [ ] **Discord Account** (for webhooks)
- [ ] **Rockstar Games Account** (for testing)

### Knowledge Prerequisites
- Basic command line usage
- Basic SQL knowledge
- Text file editing
- Port forwarding (if hosting at home)

---

## 2. System Requirements

### Minimum Requirements
- **CPU:** Intel Core i5-4590 / AMD FX-8350 (4 cores @ 3.0 GHz)
- **RAM:** 8 GB
- **Storage:** 50 GB SSD
- **Network:** 100 Mbps down/up
- **OS:** Windows Server 2019 / Ubuntu 20.04

### Recommended Requirements
- **CPU:** Intel Core i7-8700 / AMD Ryzen 7 2700X (8 cores @ 3.5 GHz)
- **RAM:** 16 GB
- **Storage:** 100 GB NVMe SSD
- **Network:** 1 Gbps down/up
- **OS:** Windows Server 2022 / Ubuntu 22.04 LTS

### Network Requirements
- **Ports to Open:**
  - `30120` (TCP/UDP) - Game server
  - `30110` (TCP) - HTTP server
  - `3306` (TCP) - MySQL (if remote)
  - `40120` (TCP) - txAdmin (optional)

---

## 3. Installation Steps

### Step 1: Install MySQL/MariaDB

#### Windows:
1. Download MySQL from https://dev.mysql.com/downloads/installer/
2. Run installer
3. Choose "Server only" installation
4. Set root password (remember this!)
5. Complete installation

#### Linux (Ubuntu):
```bash
# Update package list
sudo apt update

# Install MySQL Server
sudo apt install mysql-server -y

# Secure installation
sudo mysql_secure_installation
```

### Step 2: Create Database

```bash
# Login to MySQL
mysql -u root -p

# In MySQL console:
CREATE DATABASE qbox_27adff CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'qbox_user'@'localhost' IDENTIFIED BY 'YOUR_STRONG_PASSWORD';
GRANT ALL PRIVILEGES ON qbox_27adff.* TO 'qbox_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### Step 3: Import Database Schema

```bash
# Navigate to project directory
cd E:\FiveM_Server\NSU_CSE499

# Import SQL file
mysql -u qbox_user -p qbox_27adff < sql.sql

# Enter password when prompted
```

**Verify Import:**
```bash
mysql -u qbox_user -p qbox_27adff
SHOW TABLES;
# Should show: bank_accounts, bans, dealers, lapraces, etc.
EXIT;
```

### Step 4: Download FiveM Server

#### Windows:
1. Go to https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/
2. Download latest `server.zip`
3. Extract to `C:\FXServer\`

#### Linux:
```bash
# Create directory
mkdir -p /home/fivem/server
cd /home/fivem/server

# Download latest artifact
wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/[BUILD_NUMBER]/fx.tar.xz

# Extract
tar xf fx.tar.xz

# Make executable
chmod +x run.sh
```

### Step 5: Get FiveM License Key

1. Visit https://keymaster.fivem.net/
2. Login with your FiveM account
3. Click "Generate License Key"
4. Fill in server details:
   - **Server Name:** NSU CSE499 Development
   - **Server IP:** Leave blank (optional)
   - **Type:** Server
5. Copy the generated key (starts with `cfxk_`)

### Step 6: Configure Server Files

#### server.cfg
Open `server.cfg` and update:

```cfg
# License Key (REQUIRED)
sv_licenseKey "YOUR_LICENSE_KEY_HERE"

# MySQL Connection (REQUIRED)
set mysql_connection_string "mysql://qbox_user:YOUR_PASSWORD@localhost/qbox_27adff?connectionLimit=10"

# Server Settings
sv_hostname "NSU CSE499 Server"
sv_maxclients 10
set sv_projectName "NSU CSE499"
set sv_projectDesc "FiveM Roleplay Server"

# Server Admins (Add your identifiers)
add_ace group.admin command allow
add_ace group.admin command.quit deny
add_principal identifier.license:YOUR_LICENSE_HERE group.admin
```

#### Find Your License Identifier:
1. Connect to your server
2. Check server console
3. Look for line: `[system] Player connecting: [Name] (license:XXXXXXXXX)`
4. Copy the license identifier

### Step 7: Verify Resource Structure

Ensure folder structure looks like:
```
E:\FiveM_Server\NSU_CSE499\
├── resources/
│   ├── [qbx]/
│   ├── [ox]/
│   ├── [standalone]/
│   ├── [voice]/
│   ├── [MEV]/
│   └── [cfx-default]/
├── server.cfg
├── ox.cfg
├── voice.cfg
├── misc.cfg
├── permissions.cfg
└── sql.sql
```

### Step 8: Install Dependencies

All dependencies should already be in the `resources` folder. Verify these exist:
- `resources/[ox]/ox_lib/`
- `resources/[ox]/oxmysql/`
- `resources/[ox]/ox_inventory/`
- `resources/[qbx]/qbx_core/`

---

## 4. Configuration

### Discord Webhooks (Optional but Recommended)

1. **Create Discord Server** (if you don't have one)
2. **Create Webhook:**
   - Go to Server Settings → Integrations → Webhooks
   - Click "New Webhook"
   - Name it (e.g., "Server Logs")
   - Copy webhook URL

3. **Add to Configuration:**

Edit relevant config files (e.g., `resources/[qbx]/qbx_core/config/server.lua`):
```lua
Config.DiscordWebhook = "YOUR_WEBHOOK_URL_HERE"
```

### Admin Permissions

Edit `permissions.cfg`:
```cfg
# Add yourself as admin
add_principal identifier.license:YOUR_LICENSE_HERE group.admin

# Add team members
add_principal identifier.license:TEAMMATE_LICENSE_1 group.admin
add_principal identifier.license:TEAMMATE_LICENSE_2 group.mod
```

### Starting Money

Edit `resources/[qbx]/qbx_core/config/shared.lua`:
```lua
Config.Money = Config.Money or {}
Config.Money.MoneyTypes = {
    cash = 5000,    -- Starting cash
    bank = 5000,    -- Starting bank balance
    crypto = 0      -- Starting crypto
}
```

### Job Salaries

Edit `resources/[qbx]/qbx_core/shared/jobs.lua`:
```lua
['police'] = {
    grades = {
        [0] = { name = 'Cadet', payment = 50 },
        [1] = { name = 'Officer', payment = 75 },
        [2] = { name = 'Sergeant', payment = 100 },
        -- etc.
    }
}
```

---

## 5. First Launch

### Windows

1. **Navigate to FiveM Server folder:**
```cmd
cd C:\FXServer
```

2. **Copy your server.cfg to server folder:**
```cmd
copy "E:\FiveM_Server\NSU_CSE499\server.cfg" "C:\FXServer\server.cfg"
```

3. **Start Server:**
```cmd
FXServer.exe +exec server.cfg
```

### Linux

```bash
cd /home/fivem/server

# Start server
./run.sh +exec server.cfg
```

### What to Look For

**Successful Startup:**
```
   ____ _ _   _____ __  __
  / __ \ (_) / ____|  \/  |
 | |  | |_| | |  __| \  / |
 | |  | | | | | |_ | |\/| |
 | |__| | | | |__| | |  | |
  \___\_\_|  \_____|_|  |_|
       citizenfx.net


Server started on port 30120
Resources loaded
MySQL connection successful
qbx_core started
All resources ready
```

**Common Errors:**
- `Invalid license key` → Check sv_licenseKey
- `MySQL connection failed` → Check mysql_connection_string
- `Failed to load resource` → Check resource dependencies

---

## 6. Testing

### Connect as Player

1. **Open FiveM Client**
2. **Press F8** (console)
3. **Type:**
```
connect localhost
```
Or if remote:
```
connect YOUR_SERVER_IP:30120
```

### Test Checklist

- [ ] Server loads without errors
- [ ] Can connect to server
- [ ] Character creation works
- [ ] Can spawn in game
- [ ] Inventory opens (Tab/I)
- [ ] Phone opens (P/M)
- [ ] Voice chat works (test with second player)
- [ ] Job system works (/job)
- [ ] Vehicle spawn works (if admin: /car adder)
- [ ] Database saves (logout and login again)

### Admin Commands Test

```
/admin          - Open admin menu
/noclip         - Toggle noclip
/god            - Toggle god mode
/car adder      - Spawn vehicle
/setjob [id] police 2  - Set job
```

### Multi-Player Test

1. Connect with 2+ clients
2. Test voice proximity
3. Test phone calls
4. Test vehicle interactions
5. Test job features (police arrest, etc.)

---

## 7. Troubleshooting

### Server Won't Start

**Issue:** Server crashes immediately
**Solution:**
```
1. Check server console for errors
2. Verify license key is correct
3. Ensure all config files have proper syntax
4. Check port 30120 isn't already in use
```

### Database Connection Failed

**Issue:** `MySQL connection error`
**Solution:**
```
1. Verify MySQL is running:
   Windows: Check Services
   Linux: sudo systemctl status mysql

2. Test connection manually:
   mysql -u qbox_user -p qbox_27adff

3. Check connection string format:
   mysql://user:password@host/database
```

### Can't Connect to Server

**Issue:** "Server not found"
**Solution:**
```
1. Verify server is running
2. Check firewall allows port 30120
3. Try connecting with IP:PORT explicitly
4. Check logs for "Server started on port 30120"
```

### Resources Not Loading

**Issue:** Resources show errors
**Solution:**
```
1. Check resource dependencies in fxmanifest.lua
2. Ensure dependencies load first (check server.cfg order)
3. Try: refresh, ensure [resource]
4. Check resource folder structure
```

### Voice Not Working

**Issue:** Can't hear other players
**Solution:**
```
1. Verify pma-voice is started
2. Check voice.cfg is executed
3. Test voice key (default: N)
4. Check Discord settings if using Discord integration
5. Ensure voice resource starts before others
```

### Character Not Saving

**Issue:** Progress lost on disconnect
**Solution:**
```
1. Check database connection
2. Verify qbx_core is running
3. Check for errors in server console
4. Test direct SQL query to verify connection
```

---

## 8. Maintenance

### Regular Backups

#### Database Backup (Daily Recommended)

**Windows:**
```cmd
@echo off
set TIMESTAMP=%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%
set TIMESTAMP=%TIMESTAMP: =0%
mysqldump -u qbox_user -p qbox_27adff > backup_%TIMESTAMP%.sql
```

**Linux (Cron Job):**
```bash
# Create backup script
nano /home/fivem/backup.sh

# Add:
#!/bin/bash
mysqldump -u qbox_user -pYOUR_PASSWORD qbox_27adff > /home/fivem/backups/backup_$(date +%Y%m%d_%H%M%S).sql

# Make executable
chmod +x /home/fivem/backup.sh

# Add to crontab (daily at 3 AM)
crontab -e
0 3 * * * /home/fivem/backup.sh
```

#### Resource Backup
```bash
# Compress resources folder
tar -czf resources_backup_$(date +%Y%m%d).tar.gz resources/
```

### Updates

#### Update Server Artifacts
```bash
# Download latest build
# Extract to server folder
# Restart server
```

#### Update Resources
```bash
# Backup current version
# Replace resource folder
# Check for config changes
# Test on development server first
# Deploy to production
```

### Monitoring

#### Check Server Status
```bash
# Windows (PowerShell)
Get-Process FXServer

# Linux
ps aux | grep FXServer
```

#### Monitor Logs
```bash
# Server console shows real-time logs
# Check for errors regularly
# Set up Discord webhooks for critical errors
```

### Performance Optimization

#### Database Optimization (Monthly)
```sql
# Optimize tables
OPTIMIZE TABLE characters;
OPTIMIZE TABLE player_vehicles;
OPTIMIZE TABLE bank_accounts;

# Analyze tables
ANALYZE TABLE characters;
```

#### Clear Old Data (Optional)
```sql
# Delete bans older than 6 months
DELETE FROM bans WHERE expire < UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL 6 MONTH)) AND expire > 0;

# Clear old logs (if logging table exists)
```

---

## 9. Production Deployment Checklist

### Before Going Live

- [ ] **Security**
  - [ ] Strong MySQL password
  - [ ] Firewall configured
  - [ ] Admin permissions set
  - [ ] Discord webhooks configured
  - [ ] Rate limiting enabled

- [ ] **Performance**
  - [ ] Database optimized and indexed
  - [ ] Connection pooling configured
  - [ ] Resource limits set
  - [ ] Backup system active

- [ ] **Configuration**
  - [ ] Server name set
  - [ ] Max players configured
  - [ ] Starting money set
  - [ ] Job salaries balanced
  - [ ] Spawn points tested

- [ ] **Testing**
  - [ ] All jobs tested
  - [ ] Economy tested
  - [ ] Voice chat tested
  - [ ] Phone system tested
  - [ ] Admin tools tested
  - [ ] Multi-player tested

- [ ] **Documentation**
  - [ ] Admin guide written
  - [ ] Player rules created
  - [ ] Command list available
  - [ ] Support system ready

- [ ] **Monitoring**
  - [ ] Logging enabled
  - [ ] Performance monitoring
  - [ ] Error tracking
  - [ ] Player feedback system

---

## 10. Quick Reference

### Essential Commands

**Server Console:**
```
status              # Show players
restart [resource]  # Restart resource
refresh            # Refresh resource list
quit               # Stop server
```

**In-Game (Admin):**
```
/admin             # Admin menu
/noclip            # Noclip mode
/car [model]       # Spawn vehicle
/dv                # Delete vehicle
/setjob [id] [job] [grade]  # Set job
/givemoney [id] [type] [amount]  # Give money
/revive            # Revive self
/revive [id]       # Revive player
```

### File Locations

```
Server Config:    server.cfg
Database Schema:  sql.sql
Core Config:      resources/[qbx]/qbx_core/config/
Inventory Config: resources/[ox]/ox_inventory/data/
Admin Perms:      permissions.cfg
```

### Support Resources

- **FiveM Docs:** https://docs.fivem.net/
- **Qbox GitHub:** https://github.com/Qbox-project
- **Overextended:** https://overextended.dev/
- **FiveM Forums:** https://forum.cfx.re/

---

## Congratulations!

Your NSU CSE499 GTA V Roleplay Server should now be running!

For questions or issues:
- Check troubleshooting section
- Review logs in server console
- Consult official documentation

---

**Document Version:** 1.0
**Last Updated:** [Date]
**For:** NSU CSE499 Final Presentation
