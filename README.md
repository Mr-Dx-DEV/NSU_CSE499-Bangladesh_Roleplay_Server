# Bangladesh Roleplay Server — NSU CSE499

**A production-ready GTA V multiplayer roleplay server, built from the ground up on FiveM and re-themed end-to-end for Bangladesh.**
Capstone project (**CSE499A/B**) — Department of Electrical and Computer Engineering, North South University.

![Platform](https://img.shields.io/badge/platform-FiveM%20(CFX)-F40552?style=flat-square)
![Framework](https://img.shields.io/badge/framework-QBCore%2FQbox--style-2E86AB?style=flat-square)
![Lua](https://img.shields.io/badge/Lua-5.4-000080?style=flat-square)
![Database](https://img.shields.io/badge/database-MySQL%2FMariaDB-4479A1?style=flat-square)
![Resources](https://img.shields.io/badge/resources-50%2B-orange?style=flat-square)
![Status](https://img.shields.io/badge/status-capstone--complete-2ea44f?style=flat-square)

> 🎮 Server tag: `Bangladesh Roleplay Server || Police | EMS | Gang | Mafia`

This isn't a re-skinned template server — every department, rank ladder, vehicle livery, ID card, storefront, and street job was rebuilt so that a player logs in and recognizes *Bangladesh*, not Los Santos. The project was designed, built, tested, and hardened by a 4-person team over two capstone terms, and evaluated the way a production service would be: load-tested, security-tested, and scored by real users.

---

## Table of Contents

- [Results at a Glance](#results-at-a-glance)
- [Overview](#overview)
- [Bangladeshi Localization](#bangladeshi-localization--the-core-of-the-project)
- [Feature Highlights](#feature-highlights)
- [Screenshots](#screenshots)
- [Demo Video](#demo-video)
- [System Architecture](#system-architecture)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Team & Credits](#team--credits)
- [Disclaimer](#disclaimer)

---

## Results at a Glance

The server was benchmarked and functionally tested as if preparing for a real public launch, not just a class demo:

| Metric | Result |
|---|---|
| Server performance | **50–60 FPS** sustained under a stable player load |
| Stability | **Zero crashes** across a 24-hour continuous stress test |
| Security | **Zero successful exploits** across a 2-week penetration test |
| Database latency | Async query design keeps average latency **under 50 ms** |
| Uptime | **99%** during the evaluation window |
| Scalability | Validated with 10 concurrent players, architected for **32+** |
| User feedback | **NPS 8.2 / 10** from playtesters |
| Job systems | **13 core job systems** formally functional-tested, **20+ job roles** implemented |
| Codebase | **50+ integrated resources**, **100+ discrete features**, **20+ relational DB tables** |

These numbers come from the project's formal capstone evaluation (functional testing, a 24-hour stability soak test, and a two-week security penetration test conducted as part of CSE499B), not informal claims.

---

## Overview

- **Framework:** A QBCore/Qbox-style, event-driven framework — custom-built and rebranded end-to-end as `SJFW` / `GG` core (see [`resources/[Base]/[Framework]/sjfw`](resources/%5BBase%5D/%5BFramework%5D/sjfw))
- **Architecture:** Three-tier client → application (server + 50 resources) → data (MySQL) design, with every gameplay-affecting action validated **server-side**
- **Database:** MySQL/MariaDB via `oxmysql`, async connection pooling, 20+ relational tables
- **Access control:** Custom whitelist & role system (`GG_whitelist`, `GG_roles`) plus ACE-based permissions
- **Anti-cheat:** Dedicated anti-cheat resource — rate limiting, server-authoritative validation, Discord logging
- **Voice:** 3D zone-based proximity voice with radio channels (`pma-voice`)
- **Theme:** Every player-facing surface — police, EMS, transport, currency, ID cards, clothing, food stalls — is localized to Bangladesh

### The problem this solves

Bangladesh has an active FiveM roleplay community but no advanced, locally-hosted, culturally-relevant servers — players either play on generic American-themed servers or on unstable, insecure hobby servers. This project builds a secure, integrated, and *actually Bangladeshi* alternative: real police rank structures, a Bangladeshi hospital and banking system, taka-based economy, and city landmarks that feel local — while matching the performance and security bar of production roleplay platforms like NoPixel or Eclipse RP.

---

## Bangladeshi Localization — the core of the project

Every system below was verified directly against the resource code, not just design docs.

**🚓 Bangladesh Police** (`resources/[SJRP]/[SJRP-Job]/sjrp-policejob`)
An 11-rank career ladder pulled straight from the real Bangladesh Police hierarchy:
`Constable → ASI → Sergeant → SI → Inspector → ASP → Sr. ASP → SP → DIG → AIGP → IGP`
(the top two ranks, AIGP and IGP, are boss ranks with hiring/payroll authority). Custom stations include the main **Bangladesh Police HQ**, **Kasimpur Karagar** (prison), and a **Narayanganj** precinct, backed by an MDT (criminal records, warrants, vehicle lookups), evidence/fingerprint collection, an armory, impound, and Bangla-liveried police vehicles and helicopters.

**🚑 Bangladesh Medical (EMS)**
A parallel 11-rank medical career ladder:
`Medical Intern → Doctor → Senior Doctor → Medicine Specialist → Assistant Surgeon → Surgeon → Medical Professor → Advisor → Civil Surgeon → Deputy Chief → Chief`
with custom ambulance liveries, hospital check-in/revive flow, and medical billing.

**🏦 Economy, Jobs & World**
A Bangladeshi banking system and dedicated bank building, a full car dealership (PDM) with real-brand vehicles (BMW, Mercedes, Porsche, Tesla, Ferrari) alongside localized street vehicles (Hero Honda Splendor, Royal Enfield), a BRTC-branded public bus, hand-painted traditional Bangladeshi truck art, a **তেল/চা দোকান (tea stall)** street vendor job, pizza delivery, and Bangladeshi national ID cards, billboards, and flags placed throughout the city.

**💼 20+ Job Roles** implemented in code (`shared/jobs.lua`), spanning law enforcement, medicine, real estate, car sales (standard + luxury), mechanics, law, journalism, trucking, sanitation, mining, and hospitality — each with its own rank ladder, boss permissions, and pay grade.

---

## Feature Highlights

<details>
<summary><b>Core Framework</b> — multi-character accounts, persistent player data, dynamic job/grade system, gang system with territory & stashes, cash + bank + shared/job/gang accounts</summary>

- Multi-character system with full character creation & selection
- Dynamic, multi-job support with grades, promotions, and boss menus
- Gang creation, hierarchy, territory control, and gang stashes
- Full economy: cash, bank accounts, ATMs, transaction history, job/gang/shared accounts
</details>

<details>
<summary><b>Inventory & Items</b> (ox_inventory) — 50 slots, 85kg capacity, metadata, durability, drag & drop</summary>

- Weapons, attachments, ammo, medical items, tools, crafting materials, job-specific items
- Personal stashes, vehicle trunks/gloveboxes, property storage, evidence lockers
</details>

<details>
<summary><b>Vehicles</b> — ownership, garages, impound, fuel, mod shop, dealership, and street racing</summary>

- Vehicle keys, lockpicking, damage persistence, sharing/lending, GPS/waypoints
- Full mod shop: performance upgrades, paint, wheels, neons, tint, plates
- Dealership with test drives, financing, and player-to-player sales
- Street racing with lap tracks, leaderboards, and betting
</details>

<details>
<summary><b>Property System</b> — apartments, houses, garages, warehouses, and businesses</summary>

- Ownership & rentals, multiple property types, shared keys, interior customization
</details>

<details>
<summary><b>Communication</b> — NPWD smartphone, 3D proximity voice, handheld radio</summary>

- NPWD apps: contacts, calls, messages, camera/gallery, garage, mail, settings, marketplace
- `pma-voice` proximity voice with whisper/shout ranges, radio channels, and Discord integration
- Handheld radio with 999 channels and encryption
</details>

<details>
<summary><b>13 Job Systems (functionally tested)</b> — police, EMS, mechanic, taxi, bus, trucker, garbage collector, tow truck, news reporter, lawyer, real estate, pawn shop, car wash</summary>

Each job ships with its own duty toggle, boss menu, job-specific garage/storage, and salary logic.
</details>

<details>
<summary><b>Criminal Activities</b> — bank/store/house/truck robberies, drug production & dealing, hacking & lockpick minigames</summary>

- Bank robbery with thermite hacking, vault access, and police alerts
- Weed & cocaine production/dealing with police seizure mechanics
- Vehicle theft, safecracking, and hacking minigames
</details>

<details>
<summary><b>Admin & Security Tooling</b> — 20+ admin tools, ACE permissions, Discord-logged bans, full audit trail</summary>

- Player management (kick/ban/warn/freeze/spectate/revive), teleportation, vehicle spawning
- Server-side validation on every money/item/weapon event, rate limiting, SQL prepared statements
- Discord webhook logging for joins, deaths, transactions, admin actions, and resource events
</details>

**Full feature breakdown:** 50+ resources, 100+ discrete features, 20+ database tables — see [Project Structure](#project-structure) for where each system lives.

---

## Screenshots

<table>
<tr>
<td><img src="docs/screenshots/police-fleet-lineup.png" width="380"/><br/><sub>Bangladesh Police fleet</sub></td>
<td><img src="docs/screenshots/ems-fleet.png" width="380"/><br/><sub>Bangladesh Medical (EMS) fleet</sub></td>
</tr>
<tr>
<td><img src="docs/screenshots/radial-menu-ems.png" width="380"/><br/><sub>EMS radial interaction menu</sub></td>
<td><img src="docs/screenshots/police-prison-system.jpg" width="380"/><br/><sub>Kasimpur Karagar — police prison system</sub></td>
</tr>
<tr>
<td><img src="docs/screenshots/public-bus-brtc.png" width="380"/><br/><sub>BRTC public bus</sub></td>
<td><img src="docs/screenshots/traditional-truck-art.png" width="380"/><br/><sub>Traditional Bangladeshi truck art</sub></td>
</tr>
<tr>
<td><img src="docs/screenshots/banking-system.jpg" width="380"/><br/><sub>Bangladeshi banking system</sub></td>
<td><img src="docs/screenshots/vehicle-dealership-pdm.jpg" width="380"/><br/><sub>Vehicle dealership (PDM)</sub></td>
</tr>
<tr>
<td><img src="docs/screenshots/garage-system.jpg" width="380"/><br/><sub>Garage system</sub></td>
<td><img src="docs/screenshots/wardrobe-system.jpg" width="380"/><br/><sub>Wardrobe / clothing system</sub></td>
</tr>
<tr>
<td><img src="docs/screenshots/hospital-main.jpg" width="380"/><br/><sub>Bangladesh Medical Hospital</sub></td>
<td><img src="docs/screenshots/phone-npwd.jpg" width="380"/><br/><sub>In-game smartphone (NPWD)</sub></td>
</tr>
<tr>
<td><img src="docs/screenshots/bd-id-card.jpg" width="380"/><br/><sub>Bangladeshi national ID card</sub></td>
<td><img src="docs/screenshots/job-tea-stall-1.jpg" width="380"/><br/><sub>চা দোকান — localized tea stall job</sub></td>
</tr>
</table>

<details>
<summary><b>More screenshots</b> — police & F1 control panels, hospital interiors, jobs, vehicles, drugs, admin tools (click to expand)</summary>

<table>
<tr>
<td><img src="docs/screenshots/police-fleet-supercars.png" width="380"/><br/><sub>Police interceptor / supercar unit</sub></td>
<td><img src="docs/screenshots/police-1.jpg" width="380"/><br/><sub>Police patrol interaction</sub></td>
</tr>
<tr>
<td><img src="docs/screenshots/f1-control-panel-police-1.jpg" width="380"/><br/><sub>F1 radial control panel — police variant</sub></td>
<td><img src="docs/screenshots/f1-control-panel-1.jpg" width="380"/><br/><sub>F1 radial control panel — general</sub></td>
</tr>
<tr>
<td><img src="docs/screenshots/hospital-1.jpg" width="380"/><br/><sub>Hospital interior</sub></td>
<td><img src="docs/screenshots/hospital-storage.jpg" width="380"/><br/><sub>Hospital medical storage</sub></td>
</tr>
<tr>
<td><img src="docs/screenshots/car-dealership.jpg" width="380"/><br/><sub>Car dealership showroom</sub></td>
<td><img src="docs/screenshots/car-rental.jpg" width="380"/><br/><sub>Car rental</sub></td>
</tr>
<tr>
<td><img src="docs/screenshots/vehicle-hero-honda-splendor.jpg" width="380"/><br/><sub>Hero Honda Splendor</sub></td>
<td><img src="docs/screenshots/vehicle-royal-enfield.jpg" width="380"/><br/><sub>Royal Enfield</sub></td>
</tr>
<tr>
<td><img src="docs/screenshots/job-pizza.jpg" width="380"/><br/><sub>Pizza delivery job</sub></td>
<td><img src="docs/screenshots/billboard.jpg" width="380"/><br/><sub>Custom city billboard</sub></td>
</tr>
<tr>
<td><img src="docs/screenshots/clothing-bd-cricket-jersey.jpg" width="380"/><br/><sub>Localized clothing — cricket jersey</sub></td>
<td><img src="docs/screenshots/bd-flag.jpg" width="380"/><br/><sub>National flag prop</sub></td>
</tr>
<tr>
<td><img src="docs/screenshots/radio-system.png" width="380"/><br/><sub>Radio communication UI</sub></td>
<td><img src="docs/screenshots/resources-monitor.png" width="380"/><br/><sub>txAdmin resource / server monitor</sub></td>
</tr>
<tr>
<td><img src="docs/screenshots/character-select.png" width="380"/><br/><sub>Character selection screen</sub></td>
<td><img src="docs/screenshots/drugs-weed-1.png" width="380"/><br/><sub>Drug production — weed</sub></td>
</tr>
</table>

The full set of 50 screenshots is available in [`docs/screenshots`](docs/screenshots).
</details>

---

## Demo Video

Full gameplay walkthroughs are too large for a Git repository, so they're hosted on Google Drive:

- 🎬 [**Full gameplay walkthrough — latest build**](https://drive.google.com/file/d/1MSPEo4erT3mg8kz3roLe7VGD53ergiEL/view) *(~555 MB)*
- 🎬 [**Extended feature demo**](https://drive.google.com/file/d/1SvXijf55cc2rv26WChXde7CQvqKCRHY4/view) *(~1 GB)*
- 🎬 [**CSE499A milestone demo**](https://drive.google.com/file/d/1ms48t3xyaccZq-2gG4PLBdo3rQ16oUE5/view) *(~450 MB)*
- 📁 [**Full media & document archive**](https://drive.google.com/drive/folders/1fsD_AHh8p-6I6P5jREKCkVqtnWdy9rO-) — every screenshot, video, and project document

---

## System Architecture

```
┌──────────────────────────── Client Layer ────────────────────────────┐
│   Client 1 (GTA V + FiveM)   Client 2 (GTA V + FiveM)   Client N ...  │
└──────────────────────────┬─────────────────────────────────────────┘
                            │  Network events (client ⇄ server)
┌──────────────────────────▼─────────────────────────────────────────┐
│                          Application Layer                          │
│   FiveM Server Core  →  SJFW / GG Core Framework  →  50+ Resource   │
│   (event bus, resource manager)   (players, jobs,     Modules       │
│                                     characters,      (police, EMS,  │
│                                     vehicles)          phone, ...)  │
└──────────────────────────┬─────────────────────────────────────────┘
                            │  Async queries (oxmysql)
┌──────────────────────────▼─────────────────────────────────────────┐
│                              Data Layer                              │
│     MySQL / MariaDB — 20+ tables (characters, vehicles, bank        │
│     accounts, properties, inventories, bans, transactions...)       │
└───────────────────────────────────────────────────────────────────┘
```

Every gameplay-affecting client request (money, items, jobs, vehicles) is re-validated server-side before it touches the database — the client is never trusted to report its own state, which is what closes off the money/item duplication exploits common in hobby FiveM servers.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Game platform | FiveM (CFX.re), GTA V |
| Scripting | Lua 5.4 |
| Core framework | Custom QBCore/Qbox-style core (`SJFW` / `GG`) |
| Database | MySQL / MariaDB, `oxmysql` (async, connection-pooled) |
| Inventory | `ox_inventory` |
| Interaction | `ox_lib`, `ox_target` |
| Voice/Radio | `pma-voice` |
| Phone | NPWD |
| Server admin | `txAdmin` |
| Logging | Discord webhooks |
| Version control | Git |

---

## Project Structure

```
NSU_CSE499/
├── resources/
│   ├── [Base]/          # Core framework (sjfw/GG), database, permissions, target/interaction libs
│   ├── [Maps&Clothing]/ # Custom maps & clothing packs
│   ├── [SJRP]/          # Roleplay resources: jobs, vehicles, weapons, black market, boss menus
│   ├── [Vehicles]/      # Vehicle packs (police, EMS, civilian, localized street vehicles)
│   └── [Voice]/         # Voice chat, radio, phone
├── SQL/sjrp.sql          # Database schema (20+ tables)
├── docs/screenshots/     # 50 project screenshots
├── server.cfg            # Server configuration (secrets redacted — see below)
├── resources.cfg         # Resource load order
└── perms.cfg              # ACE permissions
```

## Getting Started

**Prerequisites**
- [FXServer (CFX.re)](https://runtime.fivem.net/) artifacts for Windows/Linux
- MySQL/MariaDB server
- A valid FiveM server license key from [Keymaster](https://keymaster.fivem.net/)

**Setup**
1. Clone the repository.
2. Import the schema in [`SQL/sjrp.sql`](SQL/sjrp.sql) into your MySQL database.
3. Copy `server.cfg` and fill in your own values for the placeholders:
   - `steam_webApiKey` — your [Steam Web API key](https://steamcommunity.com/dev/apikey)
   - `sv_licensekey` — your FiveM Keymaster license key
   - `mysql_connection_string` — your database connection string
4. Review each resource under `resources/[SJRP]/` that references a Discord webhook (anticheat, shiftlog, coderedeemer, drugs, phone) and set your own webhook URLs — these were redacted from the public repo.
5. Launch `FXServer.exe` (or `run.cmd` on Linux) pointed at this server directory.

> ⚠️ **Security note:** All Steam/FiveM license keys and Discord webhook URLs originally used in development were rotated and scrubbed from this repository's history before it was made public. Never commit real secrets — `server.cfg` (besides the tracked template) and `*.rar` archives are git-ignored for this reason.

---

## Team & Credits

Built by a 4-person capstone team in the Department of Electrical and Computer Engineering, North South University, under faculty supervision:

- **Tanvir Anjum Neon**
- **Md. Shahriar Nafij Rayhan**
- **Chisti Sababa Monir**
- **Asmaul Islam Tisha**

*Supervisor:* **Dr. K. M. A. Salam**

Built on top of community FiveM resources including `ox_lib`, `oxmysql`, `ox_inventory`, `PolyZone`, `menuv`, `pma-voice`, and an NPWD-based phone, with a custom-built framework, UI, vehicle liveries, and Bangladeshi localization created specifically for this project.

## Disclaimer

This is an academic capstone project (NSU CSE499). It is a fan-made modification for Grand Theft Auto V using FiveM and is not affiliated with or endorsed by Rockstar Games, Take-Two Interactive, or Cfx.re. All third-party resources remain the property of their original authors.
