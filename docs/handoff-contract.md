# Handoff Contract

The handoff contract transfers evidence and stage boundaries between PM triage, Stages 000-007, and final delivery. It is designed to make an agent run reviewable without publishing private source files.

Machine-readable files:

- `schemas/stage-handoff.schema.json`
- `examples/anonymized-stage-handoff.json`
- `scripts/handoff-check.ps1`

## Evidence inventory

Each evidence item records:

- a stable evidence ID
- evidence type
- source kind: public, synthetic, user-provided, or estimated
- collection date
- optional record count
- confidence: confirmed, estimated, or unverified
- a short note about scope or limitations

Public examples must not contain local absolute paths, credentials, account details, paid-tool exports, raw customer text, supplier quotes, or private business records.

## Allowed and forbidden output

Each stage handoff must name what the current evidence permits and what remains out of bounds.

Examples:

| Stage | Allowed | Forbidden |
| --- | --- | --- |
| 003 | market structure and candidate form | final product definition |
| 005 | parameterized product hypothesis | confirmed ROI |
| 006 | economics range and risk register | final legal or compliance opinion |
| 007 | measured test results | hiding failed red-line tests |

## P0 / P1 / P2 gaps

- `P0`: blocks the next decision or makes the current conclusion unsafe.
- `P1`: materially improves confidence but does not always block the next stage.
- `P2`: useful enrichment that can wait until the main uncertainty is reduced.

Every gap includes why it matters and the next action. A handoff marked `blocked` must contain at least one P0 gap.

## Status meanings

- `ready`: the exit gate is satisfied and the next stage can start.
- `conditional`: work may continue, but named assumptions or P1 gaps must remain visible.
- `blocked`: one or more P0 gaps prevent responsible progression.

## Validation

Validate the public example:

```powershell
./scripts/handoff-check.ps1
```

Validate another file:

```powershell
./scripts/handoff-check.ps1 -InputPath ./path/to/handoff.json
```

Run regression cases:

```powershell
./scripts/handoff-check.tests.ps1
```

The validator checks the portable contract, round-to-stage boundaries, evidence metadata, gap priorities, blocked-status discipline, and common privacy markers.
