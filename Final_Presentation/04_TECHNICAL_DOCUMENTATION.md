# Technical Documentation
## NSU CSE499 - GTA V Roleplay Server

---

## Table of Contents
1. System Architecture
2. Database Schema
3. Core Components
4. API Documentation
5. Security Implementation
6. Performance Optimization
7. Deployment Guide
8. Troubleshooting

---

## 1. System Architecture

### 1.1 High-Level Overview

```
┌──────────────────────────────────────────────────────────┐
│                    Client Layer                          │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐         │
│  │  Client 1  │  │  Client 2  │  │  Client N  │         │
│  │  GTA V +   │  │  GTA V +   │  │  GTA V +   │         │
│  │  FiveM     │  │  FiveM     │  │  FiveM     │         │
│  └─────┬──────┘  └─────┬──────┘  └─────┬──────┘         │
└────────┼────────────────┼────────────────┼────────────────┘
         │                │                │
         └────────────────┼────────────────┘
                          │
                 Network Events (HTTP/WebSocket)
                          │
┌─────────────────────────▼──────────────────────────────┐
│                  Server Layer                          │
│  ┌──────────────────────────────────────────────────┐  │
│  │           FiveM Server Core                      │  │
│  │  - Event Handler                                 │  │
│  │  - Resource Manager                              │  │
│  │  - Network Manager                               │  │
│  └────────────────────┬─────────────────────────────┘  │
│                       │                                 │
│  ┌────────────────────▼─────────────────────────────┐  │
│  │         Qbox Core Framework (qbx_core)           │  │
│  │  - Player Manager                                │  │
│  │  - Job System                                    │  │
│  │  - Character System                              │  │
│  │  - Vehicle Manager                               │  │
│  │  - Event Bus                                     │  │
│  └────────────────────┬─────────────────────────────┘  │
│                       │                                 │
│  ┌────────────────────▼─────────────────────────────┐  │
│  │         Resource Modules Layer                   │  │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐         │  │
│  │  │  Police  │ │   EMS    │ │ Mechanic │         │  │
│  │  └──────────┘ └──────────┘ └──────────┘         │  │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐         │  │
│  │  │   Phone  │ │Inventory │ │  Voice   │         │  │
│  │  └──────────┘ └──────────┘ └──────────┘         │  │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐         │  │
│  │  │ Banking  │ │ Vehicles │ │Properties│         │  │
│  │  └──────────┘ └──────────┘ └──────────┘         │  │
│  │               ... (40+ more)                     │  │
│  └────────────────────┬─────────────────────────────┘  │
│                       │                                 │
│  ┌────────────────────▼─────────────────────────────┐  │
│  │      Database Abstraction Layer (oxmysql)        │  │
│  │  - Connection Pool                               │  │
│  │  - Query Builder                                 │  │
│  │  - Transaction Manager                           │  │
│  │  - Async Executor                                │  │
│  └────────────────────┬─────────────────────────────┘  │
└─────────────────────────┼──────────────────────────────┘
                          │
                   SQL Queries
                          │
┌─────────────────────────▼──────────────────────────────┐
│                  Data Layer                            │
│  ┌──────────────────────────────────────────────────┐  │
│  │              MySQL Database                      │  │
│  │  - Characters                                    │  │
│  │  - Inventories                                   │  │
│  │  - Vehicles                                      │  │
│  │  - Properties                                    │  │
│  │  - Bank Accounts                                 │  │
│  │  - Bans                                          │  │
│  │  - ... (additional tables)                       │  │
│  └──────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────┐
│              External Services                         │
│  - Discord (Webhooks, Rich Presence)                   │
│  - Fivemanage/Imgur (Image Upload)                     │
│  - FiveM License Server                                │
└────────────────────────────────────────────────────────┘
```

### 1.2 Component Communication

```
Client Script (Lua)
       │
       │ TriggerServerEvent('eventName', data)
       ▼
Server Script (Lua)
       │
       │ RegisterNetEvent('eventName')
       │
       │ Execute Logic
       │
       │ Database Query (async)
       ▼
oxmysql (Database Layer)
       │
       │ MySQL.Async.execute()
       ▼
MySQL Database
       │
       │ Return Results
       ▼
Server Script (Lua)
       │
       │ Process Results
       │
       │ TriggerClientEvent('response', data)
       ▼
Client Script (Lua)
       │
       │ Update UI / State
       ▼
Player sees changes
```

---

## 2. Database Schema

### 2.1 Core Tables

#### Characters Table
```sql
CREATE TABLE IF NOT EXISTS `characters` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `citizenid` VARCHAR(50) UNIQUE NOT NULL,
    `cid` INT,
    `license` VARCHAR(100),
    `name` VARCHAR(255),
    `charinfo` TEXT,
    `money` TEXT,
    `job` TEXT,
    `gang` TEXT,
    `position` TEXT,
    `metadata` TEXT,
    `inventory` LONGTEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `last_updated` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_citizenid (citizenid),
    INDEX idx_license (license)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### Player Vehicles Table
```sql
CREATE TABLE IF NOT EXISTS `player_vehicles` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `license` VARCHAR(100),
    `citizenid` VARCHAR(50),
    `vehicle` VARCHAR(50),
    `hash` VARCHAR(50),
    `mods` LONGTEXT,
    `plate` VARCHAR(15) UNIQUE,
    `garage` VARCHAR(50),
    `state` INT DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_plate (plate),
    INDEX idx_citizenid (citizenid),
    INDEX idx_license (license)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### Bank Accounts Table
```sql
CREATE TABLE IF NOT EXISTS `bank_accounts` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `account_name` VARCHAR(100) UNIQUE,
    `account_balance` BIGINT DEFAULT 0,
    `account_type` ENUM('personal', 'job', 'gang', 'shared'),
    `users` TEXT,
    INDEX idx_account_name (account_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### Bans Table
```sql
CREATE TABLE IF NOT EXISTS `bans` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100),
    `license` VARCHAR(100),
    `discord` VARCHAR(100),
    `ip` VARCHAR(50),
    `reason` TEXT,
    `expire` BIGINT,
    `bannedby` VARCHAR(255),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### 2.2 Relationships

```
characters (1) ──────── (*) player_vehicles
    │                          (via citizenid)
    │
    ├─────── (*) inventories
    │            (via owner)
    │
    └─────── (*) properties
                 (via owner)

bank_accounts (1) ─── (*) transactions
                          (via account_id)
```

---

## 3. Core Components

### 3.1 QBX Core

**Location:** `resources/[qbx]/qbx_core/`

**Key Modules:**
- `server/player.lua` - Player management
- `server/functions.lua` - Core utilities
- `shared/jobs.lua` - Job configurations
- `shared/vehicles.lua` - Vehicle data

**Player Object Structure:**
```lua
Player = {
    PlayerData = {
        source = int,           -- Server ID
        citizenid = string,     -- Unique citizen ID
        license = string,       -- Rockstar license
        name = string,          -- Character name
        money = {
            cash = int,
            bank = int,
            crypto = int
        },
        job = {
            name = string,
            label = string,
            payment = int,
            onduty = boolean,
            isboss = boolean,
            grade = {
                name = string,
                level = int
            }
        },
        gang = {},
        position = vector3,
        metadata = {
            hunger = int,
            thirst = int,
            stress = int,
            armor = int,
            health = int
        },
        charinfo = {
            firstname = string,
            lastname = string,
            birthdate = string,
            gender = int,
            nationality = string,
            phone = string,
            account = string
        }
    },
    -- Methods
    Functions = {}
}
```

### 3.2 ox_lib

**Location:** `resources/[ox]/ox_lib/`

**Key Features:**
```lua
-- Notifications
lib.notify({
    title = 'Title',
    description = 'Description',
    type = 'success' -- success, error, warning, info
})

-- Progress Bar
lib.progressBar({
    duration = 5000,
    label = 'Action in progress',
    useWhileDead = false,
    canCancel = true,
    disable = {
        move = true,
        combat = true
    }
})

-- Input Dialog
local input = lib.inputDialog('Title', {
    {type = 'input', label = 'Name', required = true},
    {type = 'number', label = 'Amount', min = 1, max = 100}
})

-- Context Menu
lib.registerContext({
    id = 'menu_id',
    title = 'Menu Title',
    options = {
        {
            title = 'Option 1',
            description = 'Description',
            icon = 'icon-name',
            onSelect = function()
                -- action
            end
        }
    }
})
```

### 3.3 oxmysql

**Database Operations:**

```lua
-- Single query
MySQL.Async.fetchAll('SELECT * FROM characters WHERE citizenid = ?', {citizenid}, function(result)
    -- Handle result
end)

-- Insert with callback
MySQL.Async.insert('INSERT INTO characters (citizenid, name) VALUES (?, ?)',
    {citizenid, name},
    function(insertId)
        print('Inserted ID: ' .. insertId)
    end
)

-- Transaction
MySQL.Async.transaction({
    {query = 'UPDATE bank_accounts SET balance = balance - ? WHERE id = ?', values = {amount, fromId}},
    {query = 'UPDATE bank_accounts SET balance = balance + ? WHERE id = ?', values = {amount, toId}}
}, function(success)
    if success then
        print('Transaction successful')
    end
end)

-- Prepared statements (modern syntax)
local result = MySQL.query.await('SELECT * FROM characters WHERE citizenid = ?', {citizenid})
```

---

## 4. API Documentation

### 4.1 Core Exports

#### Get Player Data
```lua
-- Server-side
local Player = exports.qbx_core:GetPlayer(source)
local citizenid = Player.PlayerData.citizenid
local job = Player.PlayerData.job.name

-- Get offline player
local Player = exports.qbx_core:GetOfflinePlayer(citizenid)
```

#### Player Functions
```lua
-- Add money
Player.Functions.AddMoney('cash', 500, 'Salary payment')

-- Remove money
Player.Functions.RemoveMoney('bank', 1000, 'Vehicle purchase')

-- Set job
Player.Functions.SetJob('police', 2)

-- Add item
exports.ox_inventory:AddItem(source, 'water', 1)

-- Remove item
exports.ox_inventory:RemoveItem(source, 'water', 1)
```

### 4.2 Custom Events

#### Server Events
```lua
-- Register server event
RegisterNetEvent('qbx_police:server:JailPlayer', function(targetId, time)
    local src = source
    local Player = exports.qbx_core:GetPlayer(src)
    local TargetPlayer = exports.qbx_core:GetPlayer(targetId)

    if Player.PlayerData.job.name == 'police' then
        -- Jail logic
        TriggerClientEvent('qbx_police:client:SendToJail', targetId, time)
    end
end)
```

#### Client Events
```lua
-- Register client event
RegisterNetEvent('qbx_police:client:SendToJail', function(time)
    -- Teleport to jail
    -- Start timer
    -- Restrict actions
end)
```

### 4.3 Inventory API

```lua
-- Server-side
exports.ox_inventory:AddItem(source, item, count, metadata)
exports.ox_inventory:RemoveItem(source, item, count, metadata, slot)
exports.ox_inventory:GetItem(source, item, metadata, returnsCount)
exports.ox_inventory:GetItemCount(source, item, metadata)
exports.ox_inventory:CanCarryItem(source, item, count, metadata)
```

---

## 5. Security Implementation

### 5.1 Server-Side Validation

**All critical operations must be validated server-side:**

```lua
-- BAD: Client tells server what to do
RegisterNetEvent('giveMoney', function(amount)
    -- Never trust client input directly!
    Player.Functions.AddMoney('cash', amount)
end)

-- GOOD: Server validates and controls
RegisterNetEvent('completeJob', function(jobId)
    local src = source
    local Player = exports.qbx_core:GetPlayer(src)

    -- Validate job ID exists
    if not ValidJobs[jobId] then return end

    -- Validate player has correct job
    if Player.PlayerData.job.name ~= ValidJobs[jobId].requiredJob then
        return
    end

    -- Server determines payment
    local payment = ValidJobs[jobId].payment
    Player.Functions.AddMoney('cash', payment, 'Job completion')
end)
```

### 5.2 SQL Injection Prevention

```lua
-- BAD: String concatenation
MySQL.Async.execute('SELECT * FROM players WHERE name = "' .. name .. '"')

-- GOOD: Prepared statements
MySQL.Async.execute('SELECT * FROM players WHERE name = ?', {name})
```

### 5.3 Anti-Cheat Measures

**Implemented in:** `misc.cfg` and various resources

```lua
-- Rate limiting example
local rateLimits = {}

RegisterNetEvent('someAction', function()
    local src = source
    local currentTime = os.time()

    if rateLimits[src] and (currentTime - rateLimits[src]) < 5 then
        -- Too fast, potential exploit
        return
    end

    rateLimits[src] = currentTime
    -- Process action
end)
```

### 5.4 Permission System

```cfg
# permissions.cfg
add_ace group.admin command allow
add_ace group.mod command.kick allow
add_ace group.mod command.ban allow

add_principal identifier.license:ABC123 group.admin
```

---

## 6. Performance Optimization

### 6.1 Database Optimization

**Connection Pooling:**
```lua
-- oxmysql config
set mysql_connection_string "mysql://user:password@localhost/database?connectionLimit=10"
```

**Async Queries:**
```lua
-- Non-blocking database calls
MySQL.Async.fetchAll('SELECT * FROM characters', {}, function(result)
    -- Runs asynchronously
end)
```

**Indexes:**
```sql
-- Add indexes to frequently queried columns
CREATE INDEX idx_citizenid ON characters(citizenid);
CREATE INDEX idx_plate ON player_vehicles(plate);
```

### 6.2 Resource Optimization

**server.cfg settings:**
```cfg
# AI/Pedestrian density
set{
 sv_aiNoise 0.2
  sv_vehicleDensity 0.3
  sv_parkedVehicleDensity 0.5
}

# Network optimization
set sv_maxClients 10
set sv_enforceGameBuild 3258
```

### 6.3 Code Optimization

**Event Management:**
```lua
-- BAD: Creating timer every tick
CreateThread(function()
    while true do
        Wait(1000)
        -- Check something every second
    end
end)

-- GOOD: Event-driven
RegisterNetEvent('onPlayerJoin', function()
    -- Only runs when needed
end)
```

---

## 7. Deployment Guide

### 7.1 Server Requirements

**Minimum:**
- CPU: 4 cores @ 3.0 GHz
- RAM: 8 GB
- Storage: 50 GB SSD
- Network: 100 Mbps
- OS: Windows Server 2019 or Ubuntu 20.04

**Recommended:**
- CPU: 8 cores @ 3.5 GHz
- RAM: 16 GB
- Storage: 100 GB NVMe SSD
- Network: 1 Gbps
- OS: Windows Server 2022 or Ubuntu 22.04

### 7.2 Installation Steps

1. **Install MySQL Server**
```bash
# Ubuntu
sudo apt update
sudo apt install mysql-server

# Configure
sudo mysql_secure_installation
```

2. **Create Database**
```sql
CREATE DATABASE qbox_27adff CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'qbox_user'@'localhost' IDENTIFIED BY 'strong_password';
GRANT ALL PRIVILEGES ON qbox_27adff.* TO 'qbox_user'@'localhost';
FLUSH PRIVILEGES;
```

3. **Import Schema**
```bash
mysql -u qbox_user -p qbox_27adff < sql.sql
```

4. **Configure server.cfg**
```cfg
set mysql_connection_string "mysql://qbox_user:password@localhost/qbox_27adff"
sv_licenseKey "YOUR_LICENSE_KEY_HERE"
sv_hostname "NSU CSE499 Server"
```

5. **Start Server**
```bash
./FXServer.exe +exec server.cfg
```

### 7.3 Production Checklist

- [ ] Database secured with strong password
- [ ] Firewall configured (ports 30120, 30110)
- [ ] Admin permissions set
- [ ] Discord webhooks configured
- [ ] Backup system in place
- [ ] Monitoring tools active
- [ ] License key validated
- [ ] All resources tested

---

## 8. Troubleshooting

### 8.1 Common Issues

#### Server Won't Start
```
Error: Invalid license key
Solution: Check sv_licenseKey in server.cfg
```

#### Database Connection Failed
```
Error: Access denied for user
Solution: Verify mysql_connection_string and user permissions
```

#### Resources Not Loading
```
Error: Failed to load resource
Solution: Check fxmanifest.lua for syntax errors
```

### 8.2 Debug Commands

```lua
-- Server console
status              -- Show connected players
restart [resource]  -- Restart resource
ensure [resource]   -- Start resource
stop [resource]     -- Stop resource
refresh             -- Refresh resource list
```

### 8.3 Logging

```lua
-- Server-side logging
print(string.format('[%s] Message: %s', GetCurrentResourceName(), message))

-- Discord webhook logging
function SendToDiscord(webhook, message, color)
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
        embeds = {{
            description = message,
            color = color
        }}
    }), {['Content-Type'] = 'application/json'})
end
```

---

## Appendix

### A. Resource Dependencies

```
qbx_core depends on:
  - ox_lib
  - oxmysql
  - ox_inventory

qbx_police depends on:
  - qbx_core
  - ox_lib
  - ox_target

[Continue for all resources]
```

### B. Event Reference

See individual resource documentation for complete event lists.

### C. Database Backup Script

```bash
#!/bin/bash
mysqldump -u qbox_user -p qbox_27adff > backup_$(date +%Y%m%d_%H%M%S).sql
```

---

**Document Version:** 1.0
**Last Updated:** [Date]
**Maintained by:** [Team Name]
