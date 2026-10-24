# Heroes Underground Shift

> **Status:** Active Development\
> **Engine:** Godot 4.x\
> **Language:** GDScript\
> **Primary Platform:** Android\
> **Secondary Platform:** Desktop\
> **Genre:** Pixel-Art 2D Action RPG + Roguelite + Idle/AFK Progression\
> **Development Model:** Offline-first, data-driven, modular

## 1. Project Overview

**Heroes Underground Shift** is an original pixel-art 2D action RPG set
in a dangerous underground world. The player takes control of a team of
heroes whose work shifts involve exploration, combat, mining, defense,
resource collection, equipment progression, and boss encounters.

The central gameplay loop is:

**Hub → Prepare → Enter Underground → Explore → Fight → Gain XP →
Automatically Improve Skills → Collect Loot → Defeat Boss → Return →
Upgrade → Start the Next Shift**

The game is designed to support long-term expansion without requiring
the core architecture to be rewritten.

## 2. Design Pillars

1.  **Responsive combat** --- attacks must feel immediate and readable.
2.  **Meaningful progression** --- every run should contribute toward a
    stronger future run.
3.  **Automatic skill progression** --- the signature Auto Skill system
    must affect real gameplay, not just UI.
4.  **Short-to-medium sessions** --- a dungeon run should be enjoyable
    on mobile.
5.  **Deep replayability** --- procedural rooms, builds, equipment,
    heroes, pets, and challenges.
6.  **Original identity** --- no copied proprietary assets, characters,
    maps, story, UI, or code.
7.  **Offline-first reliability** --- core gameplay must not depend on a
    server.
8.  **Expandable architecture** --- new content should primarily require
    new data/assets rather than rewrites.

## 3. Core Features

### Gameplay

-   Top-down pixel-art combat
-   Player movement
-   Melee, ranged, projectile, and area attacks
-   Skills and ultimates
-   Dodge/dash
-   Status effects
-   Critical hits
-   Knockback
-   Boss phases
-   Procedural dungeon rooms
-   Multiple dungeon floors

### Progression

-   Hero levels
-   Skill levels
-   Automatic skill level-up
-   Skill evolution
-   Skill synergy
-   Equipment
-   Equipment enhancement
-   Runes
-   Relics
-   Pets
-   Crafting
-   Mining
-   Permanent upgrades
-   Offline/AFK rewards

### World

-   Underground hub
-   Dungeon
-   Mine
-   Defense mode
-   NPCs
-   Quests
-   Dialogue
-   Codex
-   Achievements
-   Story chapters
-   Secret rooms and encounters

### Mobile

-   Virtual joystick
-   Touch attack/skill controls
-   Auto combat
-   Haptic feedback
-   Scalable UI
-   Portrait-first layout
-   Android export

## 4. Initial Hero Roster

The planned roster contains at least:

1.  Miner --- Tank/Melee
2.  Shadow --- Assassin
3.  Ember --- Mage
4.  Ranger --- Ranged DPS
5.  Mechanic --- Engineer/Summoner
6.  Guardian --- Defensive Warrior
7.  Alchemist --- Support/Damage
8.  Voidwalker --- High-risk Void specialist

The roster is data-driven. Additional heroes can be added without
changing the core hero system.

## 5. Core Systems

The project is divided into reusable systems:

-   Game State
-   Scene Management
-   Input
-   Combat
-   Health/Damage
-   Status Effects
-   Heroes
-   Enemies
-   Skills
-   Auto Skill
-   Progression
-   Inventory
-   Equipment
-   Loot
-   Dungeon Generation
-   Bosses
-   Mining
-   Crafting
-   Pets
-   Quests
-   Dialogue
-   Defense
-   Idle/Offline
-   Save/Load
-   Audio
-   Localization
-   Settings
-   UI

## 6. Repository Structure

``` text
heroes_underground_shift/
├── project.godot
├── README.md
├── ARCHITECTURE.md
├── GAME_DESIGN.md
├── BALANCE.md
├── TEST_PLAN.md
├── DEVELOPMENT_STATUS.md
├── CHANGELOG.md
├── AI_GAME_BUILD_SPEC.md
│
├── assets/
├── audio/
├── scenes/
├── scripts/
├── data/
├── tests/
└── docs/
```

See `ARCHITECTURE.md` for the detailed technical structure.

## 7. Development Rules

-   Inspect before editing.
-   Preserve working code.
-   Do not duplicate systems.
-   Do not create fake implementations.
-   Do not mark features complete without validation.
-   Keep balance values centralized.
-   Keep gameplay data-driven.
-   Use Git checkpoints.
-   Test every major system.
-   Update `DEVELOPMENT_STATUS.md` after every milestone.

## 8. Vertical Slice

Before large-scale content production, the project must contain a
complete playable loop:

``` text
Main Menu
  ↓
Hub
  ↓
Dungeon
  ↓
Combat
  ↓
Level Up
  ↓
Auto Skill Upgrade
  ↓
Loot
  ↓
Boss
  ↓
Victory/Defeat
  ↓
Hub
  ↓
Save/Load
```

The vertical slice should contain: - 1 hero - 3 normal enemies - 1
elite - 1 boss - 3 skills - Auto Skill - XP/levels - loot - inventory -
basic equipment - one dungeon theme - mobile controls - save/load -
basic VFX/audio

## 9. Build Philosophy

The project is developed in milestones rather than attempting to
generate the entire game at once.

Recommended order:

1.  Foundation
2.  Scene flow
3.  Player
4.  Combat
5.  Enemies
6.  Progression
7.  Skills
8.  Auto Skill
9.  Dungeon
10. Boss
11. Loot
12. Inventory
13. Equipment
14. Heroes
15. Hub
16. Mining
17. Crafting
18. Pets
19. Defense
20. Quests/NPCs
21. Offline progression
22. Story/Secrets
23. Polish
24. Optimization
25. Testing
26. Android release

## 10. Quality Standard

A feature is considered complete only when: - It is implemented. - It
integrates with existing systems. - It survives normal gameplay. -
Relevant automated/manual tests pass. - Save/load behavior is correct
where applicable. - No known blocking error remains. - Documentation is
updated.

## 11. Open-Source/Asset Policy

Use assets and tools whose licenses permit the intended use. Record
licenses for third-party assets.

Never include: - ripped game assets - proprietary sprites - copyrighted
music without permission - copied code without compatible licensing -
extracted assets from commercial games

## 12. Current Status

The authoritative development state is maintained in
`DEVELOPMENT_STATUS.md`.

Do not infer project completion from this README. Always read
`DEVELOPMENT_STATUS.md` before continuing development.

## 13. Documentation Index

  File                      Purpose
  ------------------------- ------------------------------------
  `README.md`               Project overview and onboarding
  `ARCHITECTURE.md`         Technical architecture
  `GAME_DESIGN.md`          Gameplay and content specification
  `BALANCE.md`              Central balance rules and values
  `TEST_PLAN.md`            Verification strategy
  `DEVELOPMENT_STATUS.md`   Current implementation state
  `CHANGELOG.md`            Historical project changes
  `AI_GAME_BUILD_SPEC.md`   Autonomous build requirements

## 14. Definition of Done

The release candidate must: - launch successfully, - allow a new game, -
allow meaningful combat, - allow progression, - allow saving/loading, -
provide a complete first dungeon, - support Auto Skill, - provide a boss
encounter, - return to the hub, - support Android controls, - maintain
stable performance, - contain no known critical gameplay blockers.
