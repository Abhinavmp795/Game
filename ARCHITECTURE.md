# Heroes Underground Shift --- Architecture

## 1. Purpose

This document defines the technical architecture of **Heroes Underground
Shift**.

The architecture is designed for: - Godot 4.x - GDScript - Android-first
2D gameplay - offline-first operation - data-driven content - modular
systems - testability - future expansion

## 2. Architectural Principles

### 2.1 Single Responsibility

Each manager/system owns one domain.

### 2.2 Data-Driven Content

Heroes, skills, enemies, items, bosses, quests, pets, rooms and balance
values should be represented by reusable resources/data.

### 2.3 Dependency Direction

Low-level reusable systems must not depend on high-level UI.

Preferred direction:

``` text
Data
 ↓
Core Services
 ↓
Gameplay Systems
 ↓
Scenes/Entities
 ↓
UI
```

UI should observe game state; it should not become the source of truth.

### 2.4 Signals Over Hard Coupling

Use Godot signals for: - health changes - damage events - level up -
skill upgrades - loot - quest completion - currency changes - scene
transitions

### 2.5 One Source of Truth

Currency, inventory, progression, save data, and combat calculations
must have authoritative services.

## 3. Directory Architecture

``` text
assets/
audio/
scenes/
scripts/
data/
tests/
docs/
```

### `scripts/core`

Global/shared services: - GameManager - SceneManager - SaveManager -
SettingsManager - AudioManager - InputManager - LocalizationManager

### `scripts/combat`

-   DamageCalculator
-   HealthComponent
-   StatusEffectController
-   Targeting
-   Hitbox/Hurtbox
-   CooldownController

### `scripts/heroes`

-   HeroController
-   HeroManager
-   HeroStats
-   HeroProgression

### `scripts/enemies`

-   EnemyController
-   EnemyManager
-   EnemyAI
-   EnemySpawner

### `scripts/skills`

-   SkillController
-   SkillManager
-   SkillEffect
-   AutoSkillManager
-   SkillEvolutionManager
-   SynergyManager

### `scripts/progression`

-   XP
-   Levels
-   Stats
-   Modifiers
-   Economy

### `scripts/inventory`

-   InventoryManager
-   InventorySlot
-   ItemStack

### `scripts/equipment`

-   EquipmentManager
-   EquipmentModifier
-   Enhancement
-   Runes
-   Relics

### `scripts/dungeon`

-   DungeonManager
-   DungeonGenerator
-   RoomGraph
-   RoomController
-   FloorConfig
-   EncounterSpawner

### `scripts/loot`

-   LootManager
-   LootTable
-   DropResolver

### `scripts/mining`

-   MiningManager
-   ResourceNode
-   MiningAssignment

### `scripts/crafting`

-   CraftingManager
-   RecipeResolver

### `scripts/pets`

-   PetManager
-   PetController
-   PetProgression

### `scripts/quests`

-   QuestManager
-   QuestObjective
-   QuestReward

### `scripts/dialogue`

-   DialogueManager
-   DialogueData
-   DialogueChoice

### `scripts/defense`

-   DefenseManager
-   WaveManager
-   DefenseStructure

### `scripts/idle`

-   OfflineProgressionManager

## 4. Global Managers

Use Godot autoloads only where global lifetime is justified.

Recommended autoloads:

``` text
GameManager
SaveManager
AudioManager
SettingsManager
InputManager
LocalizationManager
```

Avoid making every system an autoload.

## 5. Scene Architecture

### Main

``` text
Main
├── SceneRoot
├── UI
└── TransitionLayer
```

### Dungeon

``` text
Dungeon
├── World
│   ├── TileMap
│   ├── Props
│   └── Effects
├── Entities
│   ├── Player
│   ├── Enemies
│   └── NPCs
├── Loot
├── Camera
└── HUD
```

### Hub

``` text
Hub
├── World
├── Buildings
├── NPCs
├── Player
└── UI
```

## 6. Entity Composition

Prefer composition over deep inheritance.

A combat entity may contain:

``` text
Entity
├── MovementComponent
├── HealthComponent
├── CombatComponent
├── StatusEffectComponent
├── TargetingComponent
├── AnimationController
└── LootComponent
```

Not every entity needs every component.

## 7. Data Model

Use Godot `Resource` classes where practical.

Examples:

``` text
HeroData
EnemyData
BossData
SkillData
ItemData
EquipmentData
PetData
QuestData
RoomData
FloorData
RecipeData
LootTableData
BalanceData
```

A `SkillData` resource should be able to represent:

``` text
id
display_name
description
icon
skill_type
damage_type
element
base_damage
scaling
cooldown
duration
range
radius
projectile_speed
status_effects
vfx
sfx
max_level
evolution_id
tags
```

## 8. Modifier System

Create a unified stat modifier model.

Sources: - hero base stats - level - equipment - runes - relics - pets -
buffs - debuffs - temporary dungeon effects

Prefer:

``` text
FinalStat = Base + FlatModifiers
FinalStat = FinalStat × Multipliers
```

Keep ordering deterministic and documented.

## 9. Combat Pipeline

``` text
Input/AI
  ↓
Attack Request
  ↓
Target Validation
  ↓
Skill/Attack Resolution
  ↓
Damage Calculation
  ↓
Critical/Resistance/Defense
  ↓
Status Effects
  ↓
Health Change
  ↓
Hit Feedback
  ↓
Death Check
  ↓
XP/Loot
```

All damage must pass through the centralized combat pipeline.

## 10. Damage Calculation

Conceptual model:

``` text
RawDamage
= SkillBase
+ AttackScaling
+ SkillPowerScaling
+ FlatBonuses

MitigatedDamage
= RawDamage × DefenseMultiplier × ResistanceMultiplier

Critical:
MitigatedDamage × CriticalMultiplier
```

Exact formulas belong in `BALANCE.md` and implementation data.

## 11. Status Effects

Each status should contain: - unique ID - duration - stack limit -
refresh behavior - source - periodic effect - visual effect - removal
conditions

Status logic must not be embedded independently inside every skill.

## 12. Auto Skill Architecture

``` text
ProgressionManager
       ↓
AutoSkillManager
       ↓
EligibleSkillResolver
       ↓
PriorityScorer
       ↓
UpgradeCostValidator
       ↓
SkillUpgradeService
       ↓
SkillData/Progression State
       ↓
Combat System
```

The Auto Skill system must modify the same progression state used by
manual upgrades.

## 13. Auto Skill Scoring

Each eligible skill receives a score.

Conceptually:

``` text
score =
  role_weight
+ damage_weight
+ synergy_weight
+ current_build_weight
+ enemy_context_weight
+ boss_weight
+ survival_weight
- cooldown_penalty
- resource_penalty
```

The exact weights belong in configuration.

## 14. Dungeon Architecture

Dungeon generation should produce a graph:

``` text
Start
  |
Combat
 /   \
Event Treasure
 \   /
 Elite
  |
Boss
```

Generation must validate: - connectivity - reachable boss - room count -
no impossible loops - seed reproducibility

## 15. Save Architecture

Save data should be versioned.

Example:

``` json
{
  "version": 1,
  "profile": {},
  "heroes": {},
  "inventory": {},
  "equipment": {},
  "pets": {},
  "quests": {},
  "settings": {},
  "timestamps": {}
}
```

Use migration functions:

``` text
v1 → v2
v2 → v3
```

Never invalidate an old save simply because the schema changed.

## 16. Scene/Data Separation

Scenes define presentation and node relationships.

Data defines: - stats - identity - progression - balance - content

Do not store large balance tables directly inside scenes.

## 17. UI Architecture

UI should bind to data/state.

Example:

``` text
HeroData
 ↓
HeroState
 ↓
HeroScreen
```

Not:

``` text
Button → directly edits hero stats
```

UI requests an action from the appropriate service.

## 18. Input Architecture

Use Godot InputMap actions:

``` text
move_up
move_down
move_left
move_right
attack
dash
skill_1
skill_2
skill_3
ultimate
interact
inventory
pause
```

Mobile and desktop inputs should feed the same gameplay actions.

## 19. Object Pooling

Pool high-frequency objects: - projectiles - damage numbers - VFX - XP
pickups where useful - repeated enemies where profiling proves useful

Do not pool everything.

## 20. Performance

Prefer: - signals - timers - event-driven updates - object pooling where
justified - cached references - batched UI updates

Avoid: - unnecessary `_process` - repeated `get_node` in hot loops -
per-frame allocations - excessive particles - uncontrolled enemy
processing

## 21. Testing Architecture

Three levels:

### Unit

Pure logic: - damage - XP - loot - cost - modifiers - Auto Skill scoring

### Integration

Systems interacting: - combat → XP - combat → loot - skill → damage -
inventory → equipment - save → progression

### Gameplay

Complete flows: - start run - dungeon completion - boss victory -
death - save/load

## 22. Dependency Rules

Core services must not depend on UI.

Gameplay entities should not directly write save files.

UI should not directly mutate currencies.

Combat should not directly construct reward screens.

Use services/events to keep responsibilities separated.

## 23. Extension Strategy

Adding a new hero should ideally require: 1. new `HeroData` 2. new
sprites/animations 3. skill data 4. optional unique script only when
necessary

Adding a new enemy: 1. `EnemyData` 2. scene/presentation 3. optional
behavior component

Adding a new item: 1. `ItemData` 2. icon 3. optional effect/modifier

No core-system rewrite should be necessary.

## 24. Architecture Definition of Done

Architecture is healthy when: - systems have clear responsibilities, -
data is separated from presentation, - gameplay can be tested
independently, - save state is versioned, - UI does not own game
state, - new content can be added through data, - no giant monolithic
script controls the entire game.
