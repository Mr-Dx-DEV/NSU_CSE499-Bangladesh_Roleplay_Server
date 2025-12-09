# NSU CSE499 Final Project Presentation
## GTA V Roleplay Server - Qbox Framework

---

## Table of Contents
1. Introduction
2. Project Overview
3. Technologies & Frameworks
4. System Architecture
5. Key Features
6. Database Design
7. Implementation Highlights
8. Challenges & Solutions
9. Demo & Screenshots
10. Future Enhancements
11. Conclusion

---

## 1. Introduction

### Project Title
**NSU CSE499 - GTA V Roleplay Server**

### Team Members
[Add your team member names here]

### Supervisor
[Add supervisor name here]

### Project Duration
[Add project timeline here]

---

## 2. Project Overview

### What is FiveM?
- Multiplayer modification framework for Grand Theft Auto V
- Allows custom servers with unique gameplay modes
- Supports custom scripts, resources, and modifications

### Project Objectives
- Develop a fully functional roleplay server for GTA V
- Implement realistic job systems and economy
- Create immersive player interactions
- Build a scalable, modular server architecture

### Target Audience
- Roleplay gaming community
- GTA V multiplayer enthusiasts
- Players seeking realistic life simulation gameplay

---

## 3. Technologies & Frameworks

### Core Technologies
| Technology | Purpose |
|------------|---------|
| **Lua 5.4** | Primary scripting language |
| **FiveM** | Game server framework |
| **Qbox (QBX)** | Roleplay framework core |
| **MySQL/MariaDB** | Database management |
| **JavaScript** | UI and web components |

### Key Libraries & Dependencies
- **ox_lib** - Comprehensive utility library
- **oxmysql** - Async database connector
- **ox_inventory** - Advanced inventory system
- **ox_target** - Interaction system
- **pma-voice** - Voice chat implementation
- **NPWD** - In-game phone system

---

## 4. System Architecture

### High-Level Architecture
```
┌─────────────────────────────────────────────────┐
│           FiveM Server (NSU_CSE499)             │
├─────────────────────────────────────────────────┤
│                                                 │
│  ┌──────────────┐      ┌──────────────┐        │
│  │  QBX Core    │◄────►│  MySQL DB    │        │
│  │  Framework   │      │   (Qbox)     │        │
│  └──────┬───────┘      └──────────────┘        │
│         │                                       │
│  ┌──────▼──────────────────────────────┐       │
│  │     Resource Layer (50+ modules)    │       │
│  ├─────────────────────────────────────┤       │
│  │ Jobs | Phone | Inventory | Voice    │       │
│  │ Police | EMS | Mechanic | Banking   │       │
│  │ Criminal | Properties | Vehicles    │       │
│  └─────────────────────────────────────┘       │
│                                                 │
└──────────────────┬──────────────────────────────┘
                   │
        ┌──────────▼──────────┐
        │  Game Clients (1-10)│
        │   GTA V + FiveM     │
        └─────────────────────┘
```

### Modular Design
- **[qbx]** - Core framework modules (50+ resources)
- **[ox]** - Ox framework libraries
- **[standalone]** - Independent features
- **[voice]** - Communication systems
- **[MEV]** - Vehicles and map additions

---

## 5. Key Features

### 5.1 Job Systems (10+ Jobs)
#### Legal Jobs
- **Police Department** - Law enforcement, arrests, investigations
- **EMS/Ambulance** - Medical response and treatment
- **Mechanic** - Vehicle repair and customization
- **Taxi Driver** - Passenger transportation
- **Truck Driver** - Cargo delivery
- **Bus Driver** - Public transportation
- **Garbage Collector** - Waste management
- **Tow Truck Driver** - Vehicle towing
- **News Reporter** - Journalism and reporting

#### Criminal Activities
- Bank Robbery
- Store Robbery
- House Robbery
- Drug Dealing
- Vehicle Theft
- Gang Operations

### 5.2 Player Systems
- **Multi-Character System** - Multiple characters per account
- **Multi-Job System** - Hold multiple jobs simultaneously
- **Inventory Management** - 50 slots, 85kg capacity
- **Vehicle Ownership** - Purchase, customize, and store vehicles
- **Property System** - Buy, rent, and manage properties
- **Banking System** - Account management, transactions

### 5.3 Communication Features
- **NPWD Phone System**
  - Contacts and messaging
  - Camera with photo sharing
  - Garage app integration
  - Mail system
  - App marketplace

- **Voice Chat (pma-voice)**
  - Proximity voice
  - Radio communication
  - Phone calls
  - Discord integration

### 5.4 Interaction Systems
- **Target System (ox_target)** - Point and interact with objects/players
- **Radial Menu** - Quick access to actions
- **Emote System** - 100+ character animations
- **HUD Display** - Health, armor, hunger, thirst indicators

### 5.5 Vehicle Systems
- **Vehicle Shop** - Purchase new vehicles
- **Vehicle Keys** - Security and ownership
- **Fuel System** - Realistic fuel consumption
- **Customs/Tuning** - Visual and performance upgrades
- **Racing System** - Street races and lap racing

### 5.6 Administrative Tools
- **Admin Menu** - Player management, teleportation, permissions
- **Queue System** - Manage server capacity
- **Ban System** - Multiple identifier tracking
- **Logging System** - Discord integration for events

---

## 6. Database Design

### Key Tables
```sql
- bank_accounts (25+ organization accounts)
- bans (player ban management)
- dealers (drug dealer locations)
- lapraces (racing records)
- characters (player characters)
- player_vehicles (vehicle ownership)
- properties (property ownership)
- inventories (item storage)
```

### Database Features
- Async query execution (non-blocking)
- Transaction support
- Prepared statements (SQL injection prevention)
- Connection pooling
- Named parameters for security

---

## 7. Implementation Highlights

### 7.1 Core Framework (qbx_core)
```lua
-- Multi-character support
-- Player data persistence
-- Job/gang management
-- Vehicle spawning system
-- Inventory integration
-- Event-driven architecture
```

### 7.2 Police System (qbx_police)
**Features Implemented:**
- Evidence collection (DNA, fingerprints, bullet casings)
- Jail system with automatic release
- Vehicle radar (speed detection)
- Handcuffs and restraints
- Police garage with emergency vehicles
- Evidence lockers
- Spike strips
- Prisoner transport

### 7.3 Phone System (NPWD)
**Integration Points:**
- Garage management via phone app
- Mail system integration
- Camera with image upload (Fivemanage/Imgur)
- Contact management
- Real-time notifications

### 7.4 Inventory System (ox_inventory)
**Advanced Features:**
- Item metadata support
- Weapon attachments
- Consumable items
- Item drops with 3D props
- Stash systems
- Shop integration

---

## 8. Challenges & Solutions

### Challenge 1: Performance Optimization
**Problem:** Server lag with multiple players and resources
**Solution:**
- Implemented async database queries
- Optimized spawn rates and AI density
- Used streaming for large assets
- Resource load balancing

### Challenge 2: Database Synchronization
**Problem:** Data conflicts and race conditions
**Solution:**
- Implemented oxmysql with transaction support
- Used mutex locks for critical operations
- Added data validation layers

### Challenge 3: Player Interaction Reliability
**Problem:** Desync issues with player interactions
**Solution:**
- Implemented server-authoritative model
- Added network event validation
- Used ox_lib callbacks for reliability

### Challenge 4: Resource Compatibility
**Problem:** Integration between different framework resources
**Solution:**
- Created bridge layers (qbx_bridge)
- Standardized export APIs
- Comprehensive dependency management

### Challenge 5: Security
**Problem:** Exploits and cheating attempts
**Solution:**
- Server-side validation for all actions
- Anti-cheat configurations
- Rate limiting on critical functions
- Prepared SQL statements

---

## 9. Demo & Screenshots

### Demo Scenarios
1. **Player Login Flow**
   - Character selection
   - Spawn location choice
   - Initial HUD display

2. **Job System Demo**
   - Police: Traffic stop, arrest, evidence collection
   - EMS: Medical response, player treatment
   - Mechanic: Vehicle repair demonstration

3. **Phone System Demo**
   - Make calls
   - Send messages
   - Check garage via app
   - Take photos

4. **Criminal Activity Demo**
   - Store robbery attempt
   - Police response
   - Chase and arrest

5. **Economy Demo**
   - Banking transactions
   - Vehicle purchase
   - Property rental

### Performance Metrics
- Max Players: 10 (configurable)
- Average Latency: [Add your measurement]
- Resource Usage: [Add your measurement]
- Database Query Time: [Add your measurement]

---

## 10. Future Enhancements

### Planned Features
1. **Extended Job Systems**
   - Firefighter role
   - Lawyer court system
   - Judge and legal framework
   - Restaurant/food service

2. **Advanced Economy**
   - Stock market simulation
   - Business ownership
   - Player-run shops
   - Cryptocurrency

3. **Enhanced Criminal System**
   - Heist planning system
   - Jail break mechanics
   - Underground markets
   - Territory control

4. **Social Features**
   - Dating/relationship system
   - Marriage and family
   - Housing customization
   - Party/event system

5. **Technical Improvements**
   - Cloud-based saves
   - Cross-server character transfer
   - Advanced anti-cheat
   - Performance monitoring dashboard

### Scalability Plans
- Increase max players to 32+
- Load balancing across multiple servers
- CDN integration for assets
- Microservices architecture

---

## 11. Conclusion

### Project Achievements
- Developed a fully functional roleplay server
- Implemented 50+ integrated resources
- Created realistic job and economy systems
- Built scalable, modular architecture
- Achieved stable multi-player experience

### Learning Outcomes
- Lua programming and game scripting
- Client-server architecture
- Database design and optimization
- Real-time multiplayer systems
- Project management and collaboration

### Technical Skills Gained
- FiveM framework development
- MySQL database management
- Async programming patterns
- API design and integration
- Version control with Git

### Impact & Applications
- Enhanced understanding of game server development
- Practical experience with large-scale systems
- Community building and management skills
- Problem-solving in complex environments

---

## Q&A

### Common Questions

**Q: Why choose Qbox over QB-Core?**
A: Qbox is a modern rewrite with better performance, cleaner code structure, and active development.

**Q: How is security handled?**
A: Server-side validation, prepared SQL statements, anti-cheat measures, and admin monitoring tools.

**Q: What's the maximum player capacity?**
A: Currently configured for 10 players, but can scale to 32+ with proper optimization.

**Q: How are updates managed?**
A: Git version control with separate development/production branches, tested before deployment.

**Q: What makes this different from other roleplay servers?**
A: Integrated phone system, extensive job variety, modular architecture, and modern framework.

---

## Thank You!

### Contact Information
[Add your contact details]

### Project Repository
GitHub: [Add repository link if applicable]

### Demo Server
[Add server connection details if applicable]

### Acknowledgments
- Qbox Framework developers
- Overextended (ox_lib) team
- FiveM community
- Project supervisor and team members

---

## References

1. FiveM Documentation - https://docs.fivem.net/
2. Qbox Framework - https://github.com/Qbox-project
3. Overextended - https://overextended.dev/
4. NPWD Documentation - https://npwd-community.github.io/
5. pma-voice - https://github.com/AvarianKnight/pma-voice

---

## Appendix

### A. Installation Guide
```bash
# 1. Install MySQL Server
# 2. Clone repository
# 3. Import sql.sql to database
# 4. Configure server.cfg with license key
# 5. Run server: ./FXServer.exe +exec server.cfg
```

### B. Configuration Files
- server.cfg - Main server configuration
- ox.cfg - Ox framework settings
- voice.cfg - Voice chat configuration
- permissions.cfg - Admin permissions

### C. Resource List (50+ modules)
See project directory structure for complete resource listing

### D. Command Reference
- /admin - Open admin menu
- /car [model] - Spawn vehicle (admin)
- /givemoney [id] [amount] - Give money (admin)
- /job - View current job
- /garage - Access vehicle garage
- /inventory - Open inventory

---

# END OF PRESENTATION
