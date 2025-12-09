# Frequently Asked Questions (FAQ)
## NSU CSE499 - GTA V Roleplay Server

---

## General Questions

### Q1: What is this project about?
**A:** This is a fully functional GTA V multiplayer roleplay server built on the FiveM platform using the Qbox framework. It simulates real-life scenarios with jobs, economy, communication systems, and player interactions.

### Q2: What is FiveM?
**A:** FiveM is a modification framework for Grand Theft Auto V that allows multiplayer on customized dedicated servers. It's completely legal and endorsed by Rockstar Games for non-commercial use.

### Q3: What is the Qbox framework?
**A:** Qbox (QBX) is a modern roleplay framework for FiveM servers. It's a complete rewrite of QB-Core with improved performance, cleaner code structure, and better documentation.

### Q4: How many players can join the server?
**A:** Currently configured for 10 simultaneous players, but the architecture supports scaling to 32+ players with proper optimization and hardware.

### Q5: Is this project complete?
**A:** The core systems are fully functional and production-ready. We have 50+ integrated resources working together. Additional features and jobs can always be added due to the modular design.

---

## Technical Questions

### Q6: What programming languages are used?
**A:**
- **Primary:** Lua 5.4 (server and client scripts)
- **Secondary:** JavaScript (UI/NUI components)
- **Database:** SQL (MySQL/MariaDB)
- **Configuration:** CFG files
- **Markup:** HTML/CSS (for phone and menus)

### Q7: What database system do you use?
**A:** MySQL (MariaDB compatible) with the oxmysql connector for async, non-blocking database operations.

### Q8: How is data persistence handled?
**A:** All character data, vehicles, properties, and inventories are stored in the MySQL database. Data is automatically saved and persists across server restarts and player sessions.

### Q9: What are the system requirements to run this server?
**A:**
- **Minimum:** 4-core CPU, 8GB RAM, 50GB SSD, 100Mbps network
- **Recommended:** 8-core CPU, 16GB RAM, 100GB NVMe SSD, 1Gbps network
- **OS:** Windows Server 2019+ or Ubuntu 20.04+

### Q10: How do you handle security?
**A:**
- Server-side validation for all critical actions
- Prepared SQL statements to prevent injection
- Anti-cheat configurations in misc.cfg
- Rate limiting on exploitable functions
- Admin logging and monitoring
- Discord webhook notifications for suspicious activity

---

## Feature Questions

### Q11: What job systems are implemented?
**A:** We have 10+ jobs including:
- **Legal:** Police, EMS, Mechanic, Taxi, Bus Driver, Truck Driver, Garbage Collector, Tow Truck, News Reporter
- **Criminal:** Robberies (bank, store, house), drug dealing, vehicle theft, gang operations

### Q12: Can players have multiple jobs?
**A:** Yes, the Qbox framework supports multi-job functionality, though the primary job system is most commonly used.

### Q13: How does the phone system work?
**A:** We use NPWD (New Phone Who Dis), a complete smartphone simulation with apps including:
- Contacts and calling
- Text messaging
- Camera with photo sharing
- Garage management
- Mail system
- Customizable app marketplace

### Q14: Is there voice chat?
**A:** Yes, we use pma-voice for proximity-based 3D voice chat with radio system integration and Discord connectivity.

### Q15: How does the economy work?
**A:**
- Cash and bank account system
- ATMs and banking UI (Renewed-Banking)
- Job payments
- Vehicle purchases and sales
- Property ownership and rentals
- Player-to-player transactions
- Shop systems

### Q16: Can players own vehicles and properties?
**A:** Yes, players can purchase and own vehicles (stored in garages) and properties (houses, apartments). Ownership is tied to their character and persists across sessions.

---

## Development Questions

### Q17: How long did this project take?
**A:** [Insert your timeline - e.g., "3 months of development including planning, implementation, testing, and optimization"]

### Q18: What was the most challenging part?
**A:** [Common challenges include:]
- Integrating 50+ resources with different dependencies
- Database optimization for multiple concurrent operations
- Preventing desync issues in multiplayer interactions
- Implementing secure, exploit-proof systems
- Performance optimization with many active resources

### Q19: Why did you choose Qbox over QB-Core?
**A:**
- Modern codebase with better performance
- Active development and community support
- Better documentation
- Cleaner code structure
- Built-in backwards compatibility with QB-Core resources
- Export-based API for easier integration

### Q20: What version control system did you use?
**A:** Git with local repository management. The project is tracked through commits and branches for feature development.

### Q21: How is the codebase organized?
**A:** Resources are organized into category folders:
- `[qbx]` - Core framework modules
- `[ox]` - Ox framework libraries
- `[standalone]` - Independent features
- `[voice]` - Communication systems
- `[MEV]` - Vehicles and map additions
- `[PHONE]` - Phone system components

---

## Gameplay Questions

### Q22: How do players create characters?
**A:** Multi-character system with full customization:
1. Connect to server
2. Choose character slot
3. Create new or load existing
4. Customize appearance (face, hair, clothing)
5. Select spawn location
6. Enter game

### Q23: What happens when a player is arrested?
**A:** Police can:
- Handcuff suspects
- Search inventory
- Collect evidence (DNA, fingerprints)
- Transport to jail
- Set jail time
- Automatic release when time expires

### Q24: Can players interact with each other?
**A:** Yes, through:
- Proximity voice chat
- Phone calls and messages
- Trading items
- Giving money
- Vehicle interactions
- Emotes and animations
- Job-specific interactions (medical treatment, repairs, etc.)

### Q25: Is there a tutorial for new players?
**A:** [If implemented, describe it. If not:] Currently, players learn through exploration and community guidance. A tutorial system could be added as a future enhancement.

---

## Administration Questions

### Q26: How do admins manage the server?
**A:** Through comprehensive admin tools:
- Admin menu (qbx_adminmenu)
- Console commands
- Player management (kick, ban, teleport)
- Resource management (restart, stop, start)
- Permission system (permissions.cfg)
- Logging system with Discord webhooks

### Q27: How are bans managed?
**A:** Ban system tracks multiple identifiers:
- License (Rockstar)
- Discord ID
- IP address
- Steam ID (if applicable)
Permanent and temporary bans supported with reason logging.

### Q28: Can you monitor server performance?
**A:** Yes, through:
- Built-in FiveM console (resource usage, player count)
- Database query performance logs
- Discord webhooks for events
- txAdmin (optional server management panel)
- Custom performance metrics

### Q29: How do you update the server?
**A:**
1. Test updates on development environment
2. Create database backup
3. Update resource files
4. Restart affected resources or server
5. Verify functionality
6. Monitor logs for errors

---

## Comparison Questions

### Q30: How is this different from other roleplay servers?
**A:**
- Modern Qbox framework (vs. older QB-Core)
- Integrated phone system with garage/mail apps
- 50+ resources working together seamlessly
- Comprehensive job variety
- Modular, well-documented architecture
- Educational project with full technical documentation

### Q31: Could this be used for a commercial server?
**A:** Technically yes, with considerations:
- Ensure all resources have appropriate licenses
- Obtain proper FiveM server license
- Follow Rockstar's policies
- Set up proper hosting infrastructure
- Implement additional security measures
- Add community management tools

---

## Future Development Questions

### Q32: What features are planned for the future?
**A:**
- Additional jobs (firefighter, judge, lawyer court system)
- Advanced economy (stock market, business ownership)
- Enhanced criminal systems (heist planning, territory control)
- Social features (relationships, families, housing customization)
- Technical improvements (cloud saves, cross-server transfers)
- Performance monitoring dashboard

### Q33: Can the server scale to more players?
**A:** Yes, with optimizations:
- Increase server resources (CPU, RAM)
- Database optimization and indexing
- Resource streaming optimization
- Load balancing (if multi-server)
- Network optimization
Target: 32-64 players with proper infrastructure

### Q34: Is the code open source?
**A:** [Specify based on your project - e.g., "This is an academic project. The code can be shared for educational purposes with proper attribution."]

### Q35: Can additional resources be added?
**A:** Yes, the modular architecture makes it easy to:
- Add new job scripts
- Integrate new features
- Replace existing systems
- Create custom resources
All resources follow standard fxmanifest.lua structure

---

## Troubleshooting Questions

### Q36: What do I do if the server crashes?
**A:**
1. Check server console for errors
2. Review resource logs
3. Verify database connection
4. Check for resource conflicts
5. Restart server with clean cache
6. Restore from backup if needed

### Q37: What if players can't connect?
**A:** Check:
- Server is running and accessible
- Firewall allows ports 30120 (game) and 30110 (HTTP)
- Server license is valid
- Server not at max capacity
- Client FiveM is up to date

### Q38: How do you fix database errors?
**A:**
- Verify MySQL service is running
- Check connection string in server.cfg
- Ensure user has proper permissions
- Verify tables exist (import sql.sql)
- Check for connection pool exhaustion
- Review oxmysql logs

### Q39: What if a resource won't load?
**A:**
- Check fxmanifest.lua for syntax errors
- Verify all dependencies are started
- Ensure resource is in correct folder
- Check for duplicate resource names
- Review server console for specific errors
- Try `refresh` and `ensure [resource]`

---

## Academic Questions

### Q40: What did you learn from this project?
**A:**
- Lua programming and game scripting
- Client-server architecture design
- Database design and optimization
- Real-time multiplayer system development
- API design and integration
- Version control with Git
- Project management and teamwork
- Problem-solving in complex environments

### Q41: How does this relate to your coursework?
**A:** This project applies concepts from:
- Database Systems (MySQL, schema design, optimization)
- Software Engineering (modular design, version control, testing)
- Computer Networks (client-server, protocols, latency)
- Web Development (HTML/CSS/JS for UI)
- Operating Systems (process management, resource allocation)
- Security (authentication, validation, encryption)

### Q42: What makes this a good capstone project?
**A:**
- Large-scale system integration (50+ modules)
- Real-world application
- Multiple technical domains
- Problem-solving requirements
- Scalability considerations
- Security implementation
- Performance optimization
- Documentation and presentation

### Q43: Could this be expanded for research?
**A:** Yes, potential research areas:
- Multiplayer synchronization algorithms
- Database optimization for gaming
- Anti-cheat detection methods
- Scalable server architectures
- Player behavior analytics
- Virtual economy modeling

---

## Miscellaneous Questions

### Q44: Do you need GTA V to play?
**A:** Yes, players need:
- Legal copy of GTA V (Steam/Rockstar version)
- FiveM client installed
- Server connection details

### Q45: Is FiveM legal?
**A:** Yes, FiveM is legal and operates with Rockstar's blessing for non-commercial use. Server owners must follow Rockstar's policies.

### Q46: Can console players join?
**A:** No, FiveM is PC-only. GTA Online is separate from FiveM.

### Q47: How much does it cost to run?
**A:**
- FiveM license: Free
- Server hosting: $10-50/month (depending on specs)
- Development time: [Your estimate]
- Domain/website: Optional, $10-20/year

### Q48: Where can I learn more?
**A:**
- FiveM Documentation: https://docs.fivem.net/
- Qbox Framework: https://github.com/Qbox-project
- Overextended: https://overextended.dev/
- FiveM Forums: https://forum.cfx.re/
- Discord communities for each framework

### Q49: Can I get the source code?
**A:** [Specify based on your policy - e.g., "For academic purposes and with proper attribution, yes. Contact [email/contact info]."]

### Q50: Who maintains this server?
**A:** [Your team information]
- Team Members: [Names]
- Project Supervisor: [Name]
- Institution: NSU (North South University)
- Course: CSE499
- Contact: [Email/Discord]

---

## Contact for More Questions

If your question isn't answered here, please contact:

**Email:** [your-email@example.com]
**Discord:** [Your Discord]
**GitHub:** [Repository link if applicable]

Or visit our presentation materials in the `Final_Presentation` folder.

---

**Document Version:** 1.0
**Last Updated:** [Date]
**For:** NSU CSE499 Final Presentation
