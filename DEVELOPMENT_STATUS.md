# Heroes Underground Shift --- Development Status

> **This is the authoritative source for current implementation
> status.**
>
> Update this file after every meaningful development milestone.

## 1. Current Project State

**Overall Status:** NOT YET VERIFIED\
**Current Phase:** Foundation / Bootstrap & Scene Management\
**Release:** Pre-Alpha\
**Target:** Android + Desktop\
**Engine:** Godot 4.x\
**Language:** GDScript

Do not interpret planned features as implemented features.

## 2. Status Legend

-   `[x]` Complete and validated
-   `[~]` Partially implemented
-   `[ ]` Not implemented
-   `[!]` Blocked
-   `[?]` Needs verification

## 3. Foundation

-   [x] Godot project exists (Godot 4.7.2 stable, Mobile renderer; verified 2026-10-24)
-   [x] Project opens without parser errors (headless `--import` and `--editor --quit`, exit code 0)
-   [x] Main scene exists (res://scenes/main.tscn set as run/main_scene; launches headless)
-   [x] InputMap configured (13 actions with desktop keyboard bindings)
-   [x] Pixel rendering configured (nearest-neighbor filtering, 2D transform snap)
-   [x] Mobile orientation configured (portrait-first)
-   [x] Git repository initialized (branch main; relocation committed as 0b390c6)
-   [x] Base documentation created

## 4. Core Systems

-   [x] GameManager (flow states MAIN_MENU/HUB/DUNGEON, data-driven SCENE_PATHS registry, flow signals; validated)
-   [x] SceneManager (validated deferred swaps in the main shell, failure signals, transition overlay; validated)
-   [ ] SaveManager
-   [ ] SettingsManager
-   [ ] AudioManager
-   [ ] InputManager
-   [ ] LocalizationManager

## 5. Player

-   [ ] Movement
-   [ ] Camera
-   [ ] Attack
-   [ ] Health
-   [ ] Damage
-   [ ] Death
-   [ ] Dash/Dodge
-   [ ] Interaction
-   [ ] Mobile controls

## 6. Combat

-   [ ] Damage calculation
-   [ ] Critical hits
-   [ ] Defense
-   [ ] Resistance
-   [ ] Knockback
-   [ ] Status effects
-   [ ] Cooldowns
-   [ ] Projectiles
-   [ ] Area damage
-   [ ] Hit feedback

## 7. Skills

-   [ ] Skill data
-   [ ] Active skills
-   [ ] Passive skills
-   [ ] Ultimate
-   [ ] Skill progression
-   [ ] Skill evolution
-   [ ] Skill synergy

## 8. Auto Skill

-   [ ] Eligible skill resolver
-   [ ] Priority scorer
-   [ ] Resource validation
-   [ ] Automatic upgrade
-   [ ] Combat integration
-   [ ] Save/load integration
-   [ ] Max-level handling
-   [ ] Automated tests

## 9. Enemies

-   [ ] Enemy base system
-   [ ] Melee AI
-   [ ] Ranged AI
-   [ ] Tank AI
-   [ ] Assassin AI
-   [ ] Summoner AI
-   [ ] Enemy drops
-   [ ] Enemy XP

## 10. Bosses

-   [ ] Boss framework
-   [ ] Boss health bar
-   [ ] Phase system
-   [ ] Telegraph system
-   [ ] Enrage
-   [ ] Boss rewards
-   [ ] Boss 1
-   [ ] Boss 2
-   [ ] Boss 3
-   [ ] Boss 4
-   [ ] Boss 5

## 11. Dungeon

-   [ ] Room system
-   [ ] Room graph
-   [ ] Procedural generation
-   [ ] Seed support
-   [ ] Combat rooms
-   [ ] Elite rooms
-   [ ] Treasure rooms
-   [ ] Event rooms
-   [ ] Shop rooms
-   [ ] Rest rooms
-   [ ] Secret rooms
-   [ ] Boss rooms
-   [ ] Floor progression

## 12. Loot/Inventory

-   [ ] Loot tables
-   [ ] Rarity
-   [ ] Inventory
-   [ ] Item stacking
-   [ ] Equipment
-   [ ] Auto-equip
-   [ ] Selling
-   [ ] Sorting/filtering

## 13. Equipment

-   [ ] Weapons
-   [ ] Armor
-   [ ] Helmets
-   [ ] Gloves
-   [ ] Boots
-   [ ] Accessories
-   [ ] Enhancement
-   [ ] Evolution
-   [ ] Runes
-   [ ] Relics

## 14. Heroes

-   [ ] Hero framework
-   [ ] Hero 1: Miner
-   [ ] Hero 2: Shadow
-   [ ] Hero 3: Ember
-   [ ] Hero 4: Ranger
-   [ ] Hero 5: Mechanic
-   [ ] Hero 6: Guardian
-   [ ] Hero 7: Alchemist
-   [ ] Hero 8: Voidwalker
-   [ ] Party formation
-   [ ] Hero unlocking

## 15. Hub

-   [ ] Hub scene
-   [ ] Dungeon entrance
-   [ ] Mine
-   [ ] Blacksmith
-   [ ] Shop
-   [ ] Hero Hall
-   [ ] Pet House
-   [ ] Training Hall
-   [ ] Skill Shrine
-   [ ] Storage
-   [ ] Quest Board
-   [ ] Achievement Hall
-   [ ] Research Laboratory
-   [ ] Forge
-   [ ] Relic Altar

## 16. Mining/Crafting

-   [ ] Resource nodes
-   [ ] Mining tools
-   [ ] Mining upgrades
-   [ ] Mining assignments
-   [ ] Crafting system
-   [ ] Recipe data

## 17. Pets

-   [ ] Pet framework
-   [ ] Pet unlock
-   [ ] Pet progression
-   [ ] Pet abilities
-   [ ] Pet evolution
-   [ ] Pet persistence

## 18. Defense

-   [ ] Defense map
-   [ ] Wave manager
-   [ ] Enemy spawning
-   [ ] Defense structures
-   [ ] Boss wave
-   [ ] Rewards

## 19. Quests/Story

-   [ ] Quest framework
-   [ ] Main quests
-   [ ] Daily quests
-   [ ] Weekly quests
-   [ ] Dialogue framework
-   [ ] NPC framework
-   [ ] Chapter 1
-   [ ] Chapter 2
-   [ ] Chapter 3
-   [ ] Chapter 4
-   [ ] Chapter 5

## 20. Progression

-   [ ] XP
-   [ ] Hero levels
-   [ ] Skill levels
-   [ ] Permanent upgrades
-   [ ] Achievements
-   [ ] Titles
-   [ ] Codex
-   [ ] Statistics

## 21. Offline/Idle

-   [ ] Timestamp recording
-   [ ] Offline calculation
-   [ ] 8-hour cap
-   [ ] Reward screen
-   [ ] Clock rollback handling
-   [ ] Save integration

## 22. Mobile

-   [ ] Touch input
-   [ ] Virtual joystick
-   [ ] Touch buttons
-   [ ] Portrait UI
-   [ ] Scalable UI
-   [ ] Haptics
-   [ ] Android export
-   [ ] Device test

## 23. Audio/Visual

-   [ ] Pixel-art style guide
-   [ ] Player sprites
-   [ ] Enemy sprites
-   [ ] Boss sprites
-   [ ] Tilesets
-   [ ] UI
-   [ ] VFX
-   [ ] Music
-   [ ] SFX

## 24. Testing

-   [x] Unit tests (tests/test_bootstrap.gd: 53 checks all passing; bootstrap + scene management only)
-   [ ] Combat tests
-   [ ] Auto Skill tests
-   [ ] Dungeon tests
-   [ ] Save tests
-   [ ] Economy tests
-   [ ] Integration tests
-   [ ] Gameplay smoke test
-   [ ] Android smoke test
-   [ ] Performance test

## 25. Current Milestone

### Milestone 0 --- Repository Inspection

**Status:** COMPLETE (2026-10-24)

Inspected: repository layout, Godot version (4.7.2 stable), Git state,
existing scenes/scripts/data/tests (none), existing assets (placeholder
icon only). Baseline: pre-foundation project; documentation set
present. Project file relocation into the repository root was detected
during this milestone.

### Milestone 1 --- Foundation Configuration

**Status:** COMPLETE (2026-10-24)

Configured in `project.godot`: project name; portrait-first mobile
display (720x1280 base viewport, canvas_items stretch, keep_width
aspect, fractional scaling); desktop test window override 405x720; 2D
Mobile renderer; nearest-neighbor texture filtering; 2D transform
snapping; 13 InputMap actions (move_up, move_down, move_left,
move_right, attack, dash, skill_1, skill_2, skill_3, ultimate,
interact, inventory, pause) with desktop keyboard bindings. Preserved
assets/scenes/scripts/data/tests/docs structure; added asset
subfolders assets/art, assets/audio, assets/generated, assets/source
per asset rules. No gameplay systems, scenes, or scripts created yet.
Validation: Godot 4.7.2 headless import + editor load, no errors.

### Milestone 2 --- Bootstrap & Scene Management

**Status:** COMPLETE (2026-10-24)

Implemented (no gameplay content): persistent main shell
(scenes/main.tscn = run/main_scene with SceneRoot swap container and a
reserved global UILayer); SceneManager autoload — validated, deferred,
single-flight scene swaps, scene_change_started/changed/failed
signals, asset-free black transition overlay; GameManager autoload —
flow authority with data-driven state->scene registry (UNKNOWN,
MAIN_MENU, HUB, DUNGEON), flow API (boot, show_main_menu, enter_hub,
start_dungeon_run, end_current_run), state_changed/run_started/
run_ended signals, and a test injection seam; bootstrap flow shells
main_menu/hub/dungeon wiring the menu flow (menu -> hub -> dungeon ->
run end -> hub). No player, movement, combat, enemies, skills, XP,
inventory, loot, dungeon generation, or assets. Automated suite
tests/test_bootstrap.gd: 53 checks, all passing (unit + live autoload
integration).

## 26. Active Issues

-   A1 | Priority: P2 | Affected system: Version control | Status:
    RESOLVED (2026-10-24) | Reproduction: project files had been
    relocated from `new-game-project/` into the repository root as
    uncommitted delete/add pairs. Resolution: committed as 0b390c6
    (foundation checkpoint).

Every issue must include: - priority - reproduction - affected system -
status

## 27. Blockers

No verified blockers recorded yet.

## 28. Last Validation

**Date:** 2026-10-24

**Validation:** Godot 4.7.2 stable headless (2026-10-24): `--import`
(exit 0), `--editor --quit` (exit 0), automated suite
`tests/test_bootstrap.gd` (53/53 PASS, exit 0), and a real headless
game run through `run/main_scene` with `--quit-after 120` (exit 0, no
errors; verbose log confirms main.tscn plus main_menu.tscn loading
through the boot chain). Scope: bootstrap and scene management only.
No gameplay session verified yet; no Android device test yet.

## 29. Last Updated By

OpenCode / GLM-5.3 agent

## 30. Update Rules

Never mark `[x]` without validation.

When a feature becomes complete: 1. change checkbox 2. record validation
3. record tests 4. add changelog entry 5. identify next milestone

When a feature becomes blocked: 1. mark `[!]` 2. explain exact blocker
3. document workaround if available
