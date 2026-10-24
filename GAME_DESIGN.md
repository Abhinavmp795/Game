# Heroes Underground Shift --- Game Design Document

## 1. High Concept

**Heroes Underground Shift** is a pixel-art underground action RPG where
heroes perform dangerous work shifts beneath the surface.

The player explores procedurally assembled underground areas, fights
monsters, mines resources, acquires equipment, automatically improves
skills, defeats bosses, and returns to a persistent hub to prepare for
deeper shifts.

## 2. Player Fantasy

The player should feel:

-   powerful
-   clever
-   progressively stronger
-   rewarded for experimentation
-   excited by rare discoveries
-   responsible for building a strong hero/team

## 3. Core Loop

``` text
Prepare
 ↓
Enter Shift
 ↓
Explore
 ↓
Fight
 ↓
Collect XP/Loot
 ↓
Level Up
 ↓
Auto Skill Upgrade
 ↓
Choose/Acquire Build
 ↓
Boss
 ↓
Reward
 ↓
Return to Hub
 ↓
Upgrade
 ↓
Next Shift
```

## 4. Game Modes

### Dungeon

Primary combat/progression mode.

### Mine

Resource gathering.

### Defense

Wave survival.

### Training

Passive hero development.

### Hub

Persistent preparation/progression space.

## 5. Dungeon Structure

A run consists of connected rooms.

Room types: - Combat - Elite - Treasure - Event - Shop - Rest - Secret -
Boss

The player should usually complete several rooms before the boss.

## 6. Dungeon Themes

Planned themes: 1. Cave 2. Crystal Cavern 3. Abandoned Mine 4.
Underground Forest 5. Lava Depths 6. Frozen Depths 7. Shadow Ruins 8.
Ancient City 9. Mechanical Depths 10. Void Depths

## 7. Hero Roster

### Miner

Role: Tank/Melee

Fantasy: A veteran underground worker who turns mining tools into
weapons.

### Shadow

Role: Assassin

Fantasy: A stealth specialist who uses mobility, critical attacks, and
darkness.

### Ember

Role: Mage

Fantasy: A fire mage who specializes in area damage and burn.

### Ranger

Role: Ranged DPS

Fantasy: A precision hunter who maintains distance.

### Mechanic

Role: Engineer/Summoner

Fantasy: A technician who deploys machines and turrets.

### Guardian

Role: Defensive Warrior

Fantasy: A shield specialist who protects the party.

### Alchemist

Role: Support/Damage

Fantasy: A potion and elemental specialist.

### Voidwalker

Role: High-risk Void DPS

Fantasy: A mysterious hero who manipulates dangerous underground energy.

## 8. Hero Progression

Each hero has: - level - base stats - skills - skill levels - passive -
ultimate - rarity - equipment - progression unlocks

## 9. Skill System

Each hero has: - basic attack - active skills - passive skills -
ultimate

Skills can: - deal damage - heal - buff - debuff - control - summon -
reposition - create hazards

## 10. Auto Skill System

Auto Skill is a core identity feature.

When enabled, the game automatically upgrades eligible skills according
to a deterministic priority model.

The system evaluates: - hero role - current build - skill level - damage
contribution - synergy - enemy composition - boss context - survival
needs - resources

The player may disable Auto Skill and manually upgrade skills where
supported.

## 11. Skill Evolution

Skills may evolve after reaching configured thresholds.

Example:

``` text
Slash
→ Power Slash
→ Void Slash
→ Dimension Cutter
```

Evolution changes behavior, not only numbers.

## 12. Skill Synergy

Build interactions: - Burn + Fire - Freeze + Lightning - Poison +
Bleed - Shadow + Critical - Holy + Shield - Void + Curse

Synergies should create recognizable build strategies.

## 13. Combat

Combat should emphasize: - movement - positioning - target priority -
timing - skill usage - enemy telegraphs - damage feedback

The player should understand why damage occurred.

## 14. Enemy Families

Enemy roles: - melee - ranged - tank - assassin - summoner - support -
patroller - ambusher

## 15. Boss Design

Bosses should: - telegraph attacks - change behavior between phases -
punish predictable positioning - have memorable silhouettes - provide
meaningful rewards

Planned bosses: 1. Cave King 2. Crystal Queen 3. Shadow Warden 4. Iron
Colossus 5. Ancient Underground Lord

## 16. Progression

Progression layers:

``` text
Run Progression
→ XP
→ Temporary build
→ Run loot

Persistent Progression
→ Hero levels
→ Equipment
→ Pets
→ Crafting
→ Permanent upgrades
```

This creates a satisfying roguelite loop.

## 17. Equipment

Slots: - weapon - armor - helmet - gloves - boots - accessory

Equipment can have: - rarity - base stats - random modifiers - upgrade
levels - evolution paths

## 18. Runes

Runes add build customization.

Examples: - Fire - Critical - Defense - Cooldown - Life Steal - Luck -
Mining

## 19. Relics

Relics affect the run or broader progression.

Examples: - Ancient Pickaxe - Monster Skull - Golden Clock - Blood
Crystal - Void Compass

## 20. Pets

Pets follow heroes and provide useful passive/active effects.

Examples: - Bat - Slime - Baby Golem - Crystal Fairy - Shadow Cat -
Underground Fox - Mini Dragon - Mechanical Spider - Void Wisp - Mushroom
Sprite - Cave Owl - Ancient Beetle

## 21. Mining

Mining provides resources used for: - crafting - equipment upgrades -
tool upgrades - progression

Mining should feel like a useful secondary activity, not a mandatory
chore.

## 22. Crafting

Craft: - weapons - armor - potions - runes - mining tools - upgrade
materials - pet materials

## 23. Hub

The hub is the player's persistent base.

Buildings: - Dungeon Entrance - Mine - Blacksmith - Shop - Hero Hall -
Pet House - Training Hall - Skill Shrine - Storage - Quest Board -
Achievement Hall - Research Laboratory - Forge - Relic Altar

## 24. Quests

### Main

Advance the story.

### Daily

Short repeatable objectives.

### Weekly

Longer progression objectives.

Quest rewards: - gold - materials - fragments - equipment - tokens -
cosmetics

## 25. Story

### Chapter 1 --- The First Shift

The player begins underground work.

### Chapter 2 --- Something Is Wrong

Monsters become unusually aggressive.

### Chapter 3 --- The Forgotten Mine

The heroes discover traces of an ancient civilization.

### Chapter 4 --- The Shadow Below

A deeper power is awakening.

### Chapter 5 --- The Final Shift

The Underground Lord reveals itself.

## 26. NPCs

-   Foreman
-   Blacksmith
-   Miner
-   Merchant
-   Researcher
-   Pet Keeper
-   Mysterious Stranger

NPCs should support gameplay rather than produce excessive dialogue.

## 27. Economy

Primary: - Gold

Secondary: - Crystals - Dungeon Tokens - Materials - Hero Fragments -
Pet Fragments - Skill Books

The game should remain playable without requiring real-money
transactions.

## 28. Difficulty

Difficulty scales through: - enemy stats - enemy count - elite
probability - boss mechanics - room hazards - floor modifiers

Do not rely only on inflated HP.

## 29. Challenge Modes

Planned: - Boss Rush - Time Attack - No Healing - One Skill - Glass
Cannon - Endless Dungeon

## 30. Offline Progression

Offline activities: - mining - training - resource collection

Offline rewards have a configurable maximum duration.

Default: 8 hours.

## 31. Accessibility

Support: - scalable UI - screen shake toggle - flash toggle - vibration
toggle - audio controls - reduced effects - left-handed controls -
localization

## 32. Localization

Initial: English

Prepared: Tamil Malayalam Hindi Kannada Telugu

## 33. Mobile UX

Portrait-first.

Controls: - virtual joystick - attack - skills - ultimate - dodge -
target lock - auto combat

## 34. Session Design

Target session types: - 3--5 minute quick activity - 10--15 minute
dungeon run - longer progression sessions

The player should have a meaningful stopping point after most runs.

## 35. Reward Philosophy

Rewards should be: - understandable - proportional to difficulty -
useful - varied - predictable enough to plan around - exciting when rare

## 36. Death

Death should cost the current run's temporary progress while preserving
permanent progression.

Player returns to hub with appropriate persistent rewards.

## 37. Victory

Boss victory: - rewards - floor completion - quest progress - unlocks
where appropriate - return-to-hub option

## 38. Cosmetics

Cosmetics should never be required for gameplay.

Possible: - costumes - weapon skins - capes - trails - emotes - portrait
frames

## 39. Codex

Track discoveries: - heroes - enemies - bosses - skills - equipment -
pets - materials - relics - runes - lore

## 40. Definition of Fun

A successful run should provide at least one of: - stronger hero - new
skill interaction - useful equipment - new discovery - story progress -
new resource - boss progress - achievement

The player should rarely feel that a run was completely wasted.
