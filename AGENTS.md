# Heroes Underground Shift - Agent Instructions

## Project

Heroes Underground Shift is a pixel-art 2D Action RPG + Roguelite + Idle/AFK progression game.

Engine:
Godot 4.x

Language:
GDScript

Primary Platform:
Android

Secondary Platform:
Desktop

## Agent Role

OpenCode is the lead development agent.

The agent is responsible for:

- Godot code
- Godot scenes
- gameplay systems
- data resources
- asset integration
- automated tests
- documentation
- validation
- bug fixing

## Asset Workflow

The development workflow is:

YOU → approve assets
AI tools → generate assets
OpenCode → integrate assets
Godot → assemble and test

Never assume an asset exists.

Never invent missing assets.

Never overwrite approved assets without permission.

## Development Rules

1. Inspect before editing.
2. Read relevant documentation before implementing systems.
3. Preserve working code.
4. Do not create duplicate systems.
5. Use data-driven architecture.
6. Do not hard-code balance values unnecessarily.
7. Do not mark systems complete without testing.
8. Update DEVELOPMENT_STATUS.md only with verified information.
9. Run relevant tests after significant changes.
10. Never delete working files without explicit permission.

## Asset Rules

All game assets belong under:

assets/

Use:

assets/art/
assets/audio/
assets/generated/
assets/source/

Generated assets must be reviewed before being considered production assets.

## Priority

Always prioritize the playable vertical slice:

Main Menu
→ Hub
→ Dungeon
→ Combat
→ XP
→ Level Up
→ Auto Skill
→ Loot
→ Boss
→ Victory
→ Hub
→ Save/Load

## Quality Rule

CONSISTENCY BEATS QUANTITY.

Do not generate unnecessary assets when an existing asset can be reused.