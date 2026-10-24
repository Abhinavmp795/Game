# Heroes Underground Shift --- Balance Specification

## 1. Purpose

This file defines the initial balance model.

These numbers are starting points, not immutable values. All balance
should be tested through gameplay.

## 2. Design Goals

Balance must produce: - fast early progression - meaningful upgrades -
readable enemy danger - bosses that require attention - useful loot -
sustainable economy - viable different builds - no mandatory single
build

## 3. Player Baseline

Initial hero:

``` text
Level: 1
HP: 100
Attack: 10
Defense: 5
Attack Speed: 1.0
Move Speed: 100%
Crit Chance: 5%
Crit Damage: 150%
Skill Power: 100%
Cooldown Reduction: 0%
Life Steal: 0%
Dodge: 0%
Luck: 0%
```

## 4. Hero Level Curve

Initial target:

``` text
XP_to_next = round(100 × level^1.35)
```

The formula may be adjusted after playtesting.

Recommended checkpoints:

    Level   Approximate XP Requirement
  ------- ----------------------------
      1→2                          100
      2→3                          255
      3→4                          443
      4→5                          606
      5→6                          854
    10→11                      \~2,238
    20→21                      \~5,727
    30→31                      \~9,800

Use actual code/configuration as the authority if values are later
tuned.

## 5. Stat Growth

Default per-level model:

``` text
HP:
BaseHP × (1 + 0.08 × (Level - 1))

Attack:
BaseAttack × (1 + 0.06 × (Level - 1))

Defense:
BaseDefense × (1 + 0.05 × (Level - 1))
```

Hero-specific growth modifiers may alter these.

## 6. Critical

Default: - Crit Chance: 5% - Crit multiplier: 1.5x

Cap: - Crit Chance: 100%

Avoid allowing uncontrolled multiplicative stacking.

## 7. Defense

Use diminishing returns.

Conceptual model:

``` text
DamageMultiplier = 100 / (100 + Defense)
```

Example: Defense 0 → 100% damage Defense 100 → 50% damage Defense 300 →
25% damage

This prevents defense from reaching absolute immunity.

## 8. Elemental Resistance

Use a similar bounded model.

Suggested range: - -100% to +90%

Negative resistance increases damage.

Positive resistance reduces damage.

Never allow resistance to produce accidental infinite/negative damage.

## 9. Skill Levels

Maximum: 30

Suggested damage scaling:

``` text
SkillDamage = BaseDamage × (1 + 0.10 × (SkillLevel - 1))
```

This can be modified per skill family.

## 10. Skill Upgrade Cost

Base cost:

``` text
GoldCost = round(100 × SkillLevel^1.45)
```

Skill Book cost should increase more slowly than gold.

Example:

    Skill Level       Gold   Books
  ------------- ---------- -------
            1→2        100       1
            2→3        274       1
            3→4        472       1
            4→5        676       2
            5→6        910       2
          10→11    \~2,818       5
          20→21    \~8,000      10
          29→30   \~18,000      15

These are starting targets and should be tuned.

## 11. Auto Skill Priority

Suggested baseline weights:

  Factor                  Weight
  --------------------- --------
  Hero role                   20
  Damage contribution         20
  Build synergy               20
  Current skill level         10
  Enemy context               10
  Boss context                10
  Survival                    10

The scorer must be deterministic.

## 12. Auto Skill Rules

Auto Skill must: - never spend unavailable resources - never exceed max
skill level - never upgrade disabled skills - use valid skill data -
save the result - update combat immediately

## 13. Enemy Baseline

### Cave Rat

``` text
HP: 30
Attack: 5
Defense: 1
Speed: High
XP: 10
Gold: 3–6
```

### Miner Zombie

``` text
HP: 60
Attack: 10
Defense: 5
Speed: Low
XP: 20
Gold: 6–12
```

### Shadow Walker

``` text
HP: 40
Attack: 8
Defense: 3
Speed: Medium
XP: 25
Gold: 8–15
```

## 14. Enemy Scaling

Default floor scaling:

``` text
HPMultiplier = 1.10^(Floor-1)
DamageMultiplier = 1.075^(Floor-1)
DefenseMultiplier = 1.05^(Floor-1)
```

Do not allow exponential scaling to become unplayable. Add soft caps or
rebalance after testing.

## 15. Elite Enemies

Suggested: - 2.5x HP - 1.5x damage - 1.25x defense - improved rewards

Elites should have at least one meaningful mechanic.

## 16. Boss Baseline

First boss target:

``` text
HP: 1,000
Attack: 20
Defense: 10
```

Boss health should be tuned against: - expected hero level - expected
equipment - intended fight duration

Target first boss duration: approximately 60--120 seconds for a
competent first-run player.

## 17. Boss Rewards

Boss should provide: - large XP - gold - guaranteed progression
material - chance at rare equipment - quest progression

## 18. Loot Rarity

Starting target:

``` text
Common: 60%
Uncommon: 25%
Rare: 10%
Epic: 4%
Legendary: 1%
```

Higher-tier content can improve these rates.

## 19. Equipment Stat Budget

Equipment should have a stat budget based on: - item level - rarity -
slot - number of modifiers

Avoid allowing a single item to dominate every other slot.

## 20. Equipment Enhancement

Suggested stat growth:

``` text
Each enhancement:
+4–8% relevant stat
```

Use deterministic costs.

## 21. Currency

Initial economy:

``` text
Gold:
common enemy 3–15
elite 50–100
boss 250–500
```

Gold must come from multiple activities.

## 22. Mining

Starting yields:

``` text
Iron: common
Copper: common
Gold Ore: uncommon
Crystal: rare
Shadow Ore: epic/rare deep-floor resource
Ancient Ore: very rare/endgame
```

## 23. Crafting

Crafting should be cheaper than directly buying equivalent finished
equipment, but time/resource-gated enough to preserve progression.

## 24. Pets

Pet progression should provide meaningful utility without making heroes
irrelevant.

Suggested total pet contribution: - early: 5--10% - mid: 10--20% -
endgame: 20--30%

## 25. Offline Rewards

Default maximum: 8 hours.

Offline reward rate should be lower than active play.

Target: approximately 30--60% of equivalent active efficiency.

This rewards active play without making offline progress useless.

## 26. Defense Mode

Wave scaling: - +8--12% enemy power per wave - periodic elite wave -
boss every configured number of waves

Rewards should scale with difficulty.

## 27. Difficulty Philosophy

Do not balance by HP inflation alone.

Increase: - enemy variety - mechanics - positioning pressure - room
hazards - elite composition - boss mechanics

## 28. Build Viability

At minimum, support viable: - single-target - area damage - critical -
elemental - defensive - sustain - summon - mobility

No one build should be mandatory.

## 29. Economy Safety

Currency must never become negative.

All purchases must validate: 1. item exists 2. player can afford it 3.
transaction is valid 4. transaction is atomic 5. inventory capacity is
sufficient when necessary

## 30. Balance Tuning Procedure

When a value is changed: 1. record old value 2. record new value 3.
explain reason 4. playtest affected scenario 5. update this file if the
value is canonical

## 31. Balance Red Flags

Investigate if: - players cannot defeat first boss with reasonable
gear - one hero dominates every mode - one skill is always selected -
loot becomes meaningless - gold is always scarce or always overflowing -
offline rewards outperform active play - late-game scaling becomes
impossible - defense reaches near-immunity - cooldown reduction removes
meaningful decision-making

## 32. Balance Definition of Done

Balance is acceptable when: - early game is approachable - mid-game
offers meaningful choices - late-game requires optimization - multiple
builds are viable - rewards feel proportional - no progression dead-end
exists - Auto Skill produces sensible upgrades - bosses are challenging
but readable
