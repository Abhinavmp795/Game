# Heroes Underground Shift --- Changelog

All notable project changes are recorded here.

The format follows a practical Keep-a-Changelog style.

------------------------------------------------------------------------

## \[Unreleased\]

### Added

-   Master project documentation structure.
-   README project overview.
-   Technical architecture specification.
-   Game design specification.
-   Initial balance model.
-   Test plan.
-   Development status tracker.
-   Changelog.
-   [Foundation] Godot project configuration for Heroes Underground
    Shift (Godot 4.7.x, verified on 4.7.2 stable): portrait-first
    mobile display (720x1280 base viewport, canvas_items stretch,
    keep_width aspect, fractional scaling), desktop test window
    override (405x720), 2D Mobile renderer, nearest-neighbor texture
    filtering, 2D transform snapping, and 13 InputMap actions with
    desktop keyboard bindings (WASD/arrows movement, Space attack,
    Shift dash, 1/2/3 skills, R ultimate, F interact, Tab inventory,
    Escape pause).
-   [Foundation] Repository structure preserved and made git-trackable:
    assets/ (with art/, audio/, generated/, source/ per asset rules),
    scenes/, scripts/, data/, tests/, docs/.
-   [Foundation] Verification: Godot 4.7.2 headless `--import` and
    `--editor --quit` pass with no project configuration errors.
-   [Bootstrap] Main shell scene (`scenes/main.tscn`, set as
    `run/main_scene`): persistent SceneRoot swap container plus
    reserved global UI layer; launches from the engine main-scene path
    (F5 equivalent verified headless).
-   [Bootstrap] SceneManager autoload (`scripts/core/scene_manager.gd`):
    validated, deferred, single-flight scene swaps inside the main
    shell; scene_change_started/scene_changed/scene_change_failed
    signals; asset-free black transition overlay.
-   [Bootstrap] GameManager autoload (`scripts/core/game_manager.gd`):
    game-flow authority with a data-driven state-to-screen registry
    (UNKNOWN, MAIN_MENU, HUB, DUNGEON), flow API (boot, show_main_menu,
    enter_hub, start_dungeon_run, end_current_run),
    state_changed/run_started/run_ended signals, and a test injection
    seam.
-   [Bootstrap] Flow-shell screens (no gameplay content):
    scenes/main_menu.tscn, scenes/hub.tscn, scenes/dungeon.tscn with
    minimal screen scripts wiring navigation into GameManager.
-   [Bootstrap] Addon-free automated test suite
    (`tests/test_bootstrap.gd`; 53 checks, all passing): flow registry
    integrity, SceneManager validation/lifecycle/single-flight guard,
    GameManager flow seams via stubbed scene manager, and live
    autoload integration.
-   [Bootstrap] Verification: Godot 4.7.2 headless import, editor
    load, test run, and game run via run/main_scene all exit 0 with no
    errors.

### Planned

-   Player prototype (bootstrap architecture exists; player not started).
-   Designed main menu and scene flow (bootstrap shells exist only).
-   Player controller.
-   Core combat.
-   Enemy AI.
-   XP progression.
-   Skill system.
-   Automatic Skill Level-Up.
-   First dungeon vertical slice.

### Changed

-   None.

### Fixed

-   None.

### Known Issues

-   Configuration and bootstrap milestones verified on 2026-10-24 (see
    DEVELOPMENT_STATUS.md, Last Validation). No gameplay systems exist
    yet. Automated tests cover bootstrap and scene management only.
    Android export and device testing are not configured yet.

------------------------------------------------------------------------

## Changelog Rules

Every meaningful implementation change should add an entry under
`[Unreleased]`.

Use:

### Added

For new features.

### Changed

For modifications to existing behavior.

### Fixed

For bugs.

### Removed

For removed functionality.

### Security

For security/data-integrity changes.

### Performance

For optimization changes.

### Tests

For meaningful test coverage changes.

### Documentation

For documentation-only changes.

------------------------------------------------------------------------

## Entry Format

Use:

``` markdown
### Added
- [System] Description of implementation.

### Changed
- [System] Description of behavior change.

### Fixed
- [System] Description of bug and correction.

### Tests
- Added/updated tests for [system].
```

Include references to milestones where useful.

------------------------------------------------------------------------

## Versioning

Use semantic-style project versions:

``` text
0.x.y
```

During development:

-   `0.1.0` --- first playable foundation
-   `0.2.0` --- combat vertical slice
-   `0.3.0` --- dungeon/boss vertical slice
-   `0.4.0` --- progression systems
-   `0.5.0` --- hub/equipment
-   `0.6.0` --- expanded content
-   `0.7.0` --- mobile alpha
-   `0.8.0` --- content-complete beta
-   `0.9.0` --- release candidate
-   `1.0.0` --- first stable release

Do not change versions simply because code was edited. Version changes
represent meaningful project milestones.

------------------------------------------------------------------------

## Release Checklist

Before `1.0.0`, confirm: - no P0 bugs - no known core P1 bugs -
save/load validated - Android build validated - core gameplay complete -
Auto Skill validated - dungeon/boss loop validated - performance
acceptable - settings work - localization fallback works -
licensing/assets reviewed - final documentation updated
