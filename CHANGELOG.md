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

### Planned

-   Godot project foundation.
-   Main menu and scene flow.
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

-   Implementation status must be verified against the actual
    repository.

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
