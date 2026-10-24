# Heroes Underground Shift --- Test Plan

## 1. Purpose

This document defines how Heroes Underground Shift is verified.

Testing is required at: - unit level - integration level - gameplay
level - UI level - save/load level - performance level - Android/device
level

## 2. Test Priorities

### P0 --- Critical

Game cannot launch, save, load, fight, progress, or complete a run.

### P1 --- Major

Core system malfunction with workaround unavailable.

### P2 --- Normal

Non-blocking feature or presentation issue.

### P3 --- Minor

Polish, visual, wording, or low-impact issue.

## 3. Unit Testing

Test pure logic independently.

Required areas: - damage - defense - critical - status effects - XP -
level curves - skill costs - skill scaling - Auto Skill scoring - loot
probabilities - inventory stacking - currency transactions - equipment
modifiers - crafting - offline reward calculation - dungeon graph
validation

## 4. Combat Tests

### CT-001 Basic Damage

Given attacker and target stats, verify expected damage.

### CT-002 Critical

Verify critical multiplier.

### CT-003 Defense

Verify mitigation.

### CT-004 Negative Resistance

Verify increased elemental damage.

### CT-005 Positive Resistance

Verify reduced damage.

### CT-006 Death

Verify target death at zero health.

### CT-007 Overkill

Verify health does not become invalid.

### CT-008 Knockback

Verify direction and distance.

### CT-009 Invulnerability

Verify damage is blocked during invulnerability.

### CT-010 Status

Verify status application, duration, stacking, and expiration.

## 5. Skill Tests

For every skill: - correct data loads - cooldown works - range works -
target rules work - damage works - VFX triggers - SFX triggers - status
effects work - scaling works

## 6. Auto Skill Tests

Mandatory:

### AS-001 Detection

Find all eligible skills.

### AS-002 Cost Validation

Reject upgrades without resources.

### AS-003 Max Level

Never exceed configured max.

### AS-004 Selection

Select highest-priority eligible skill.

### AS-005 Determinism

Same input state produces same selection.

### AS-006 Persistence

Upgrade survives save/load.

### AS-007 Combat Integration

Upgraded skill changes actual combat.

### AS-008 Resource Transaction

Gold/books are deducted exactly once.

### AS-009 Disabled Skill

Disabled skills cannot be selected.

### AS-010 Evolution

Correct evolution triggers at threshold.

## 7. Hero Tests

Verify: - creation - loading - leveling - stat growth - skill
assignment - equipment compatibility - hero switching - party
formation - save/load

## 8. Enemy Tests

Verify: - spawn - AI - targeting - attack - damage - status effects -
death - loot - XP

## 9. Boss Tests

For each boss: - arena loads - health bar works - phase transition
works - attack telegraphs work - summons work - enrage works - death
works - rewards work - victory state triggers

## 10. Dungeon Tests

### DG-001 Connectivity

Every generated room is reachable.

### DG-002 Boss Reachability

Boss is always reachable.

### DG-003 Seed

Same seed produces same generation.

### DG-004 Invalid Graph

Invalid layouts are rejected/regenerated.

### DG-005 Room Count

Generated dungeon respects configured limits.

### DG-006 Transition

Doors and room transitions work.

### DG-007 Rewards

Floor completion grants correct rewards.

## 11. Inventory Tests

Verify: - add - remove - stack - split - equip - unequip - sell - lock -
favorite - sort - filter - capacity

## 12. Equipment Tests

Verify: - valid slots - modifiers - rarity - enhancement - evolution -
persistence

## 13. Economy Tests

Every transaction must test: - sufficient funds - insufficient funds -
exact deduction - no negative values - valid reward - duplicate
transaction prevention

## 14. Mining Tests

Verify: - node interaction - resource yield - tool bonus - rare drops -
inventory - offline assignment

## 15. Crafting Tests

Verify: - recipe exists - materials checked - materials deducted - item
created - invalid recipe rejected - insufficient materials rejected

## 16. Pet Tests

Verify: - unlock - level - stats - ability - evolution - persistence

## 17. Quest Tests

Verify: - objective tracking - completion - reward - claim state -
duplicate claim prevention - persistence

## 18. Save Tests

Mandatory scenarios:

1.  New game
2.  Save
3.  Load
4.  Quit during dungeon
5.  Load after quit
6.  Multiple save slots
7.  Corrupt save
8.  Missing field
9.  Unknown field
10. Old-version migration
11. Backup recovery

Never destroy a valid save during testing.

## 19. Offline Tests

Test: - zero elapsed time - short elapsed time - maximum elapsed time -
beyond maximum - invalid timestamp - clock moving backward - reward
calculation - assigned activity - persistence

## 20. UI Tests

Verify: - buttons respond - disabled buttons remain disabled - text
fits - touch targets are large enough - UI scales - portrait layout
works - pause works - overlays do not block unintended input

## 21. Input Tests

Desktop: - keyboard - mouse - controller if supported

Mobile: - joystick - attack - skills - ultimate - dodge - target lock -
pause

## 22. Audio Tests

Verify: - music changes correctly - SFX trigger - volume settings
persist - mute works - no duplicate looping audio - boss music
transition works

## 23. Localization Tests

For every supported language: - no missing keys - no broken
placeholders - no clipped text - no overflow - correct fallback to
English

## 24. Performance Tests

Measure: - startup time - memory usage - frame rate - frame time - scene
transition time - large enemy waves - projectile-heavy combat -
particle-heavy combat - long sessions

Target: stable 60 FPS on capable target hardware and acceptable
performance on minimum supported hardware.

## 25. Regression Testing

After every major system change: - run relevant unit tests - run
integration tests - launch the game - test the primary gameplay loop

## 26. Release Smoke Test

A release candidate must pass:

1.  Launch
2.  New Game
3.  Hub
4.  Enter Dungeon
5.  Move
6.  Attack
7.  Kill Enemy
8.  Gain XP
9.  Level Up
10. Auto Skill
11. Collect Loot
12. Equip Item
13. Reach Boss
14. Defeat Boss
15. Return Hub
16. Save
17. Restart
18. Load
19. Repeat

## 27. Bug Report Format

``` text
ID:
Priority:
Title:
Environment:
Steps:
Expected:
Actual:
Reproduction Rate:
Logs:
Screenshots:
Status:
Fix:
Regression Test:
```

## 28. Test Completion Rules

A feature is not complete if: - only the happy path works - save/load is
untested - errors are ignored - mobile behavior is unknown - UI exists
but underlying logic is absent

## 29. Definition of Test Readiness

A milestone is test-ready when: - code compiles/parses - scenes load -
test data exists - critical paths can be executed - relevant automated
tests exist

## 30. Definition of Release Ready

No unresolved P0 issues.

No unresolved P1 issues affecting core gameplay.

All release smoke tests pass.

Save/load passes.

Android build launches.

Core progression works.
