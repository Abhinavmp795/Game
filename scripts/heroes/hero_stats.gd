class_name HeroStats
extends Resource

## Base, per-hero balance/configuration data (BALANCE.md section 3
## baseline: HP 100, Attack 10, Defense 5, Attack Speed 1.0,
## Move Speed 100%).
##
## This resource is the single gameplay source of truth for hero
## baseline values. Systems that consume hero stats must load their
## instances from res://data/heroes/*.tres and must not re-declare the
## same values as script constants elsewhere.

## Human-readable hero identifier (used by UI later).
@export var display_name: String = "Hero"

## Movement speed of the character body in pixels per second at
## Move Speed 100%.
@export var base_move_speed: float = 220.0

## Balance multiplier applied on top of base_move_speed
## (BALANCE.md baseline: 100% at level 1).
@export var move_speed_multiplier: float = 1.0

## Per-level baseline health. Reserved for the upcoming health system:
## not read by the movement prototype.
@export var max_health: float = 100.0

## Baseline attack value. Reserved for future combat/skill systems.
@export var attack: float = 10.0

## Baseline defense value. Reserved for future combat systems.
@export var defense: float = 5.0

## Attacks per second at baseline. Reserved for future combat systems.
@export var attack_speed: float = 1.0
