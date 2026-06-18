# Example: Anonymized Low-Data PM Triage

This example shows how the agent should behave when the user only has a product idea and scattered observations. It should not jump into product definition, ROI, supplier validation, or final Go/Kill language.

## User Prompt

```text
Marketplace: Amazon US
Product direction: under-sink organizer
Available evidence:
- I saw several similar listings on Amazon.
- Some products look cheaply made.
- I do not have BSR, keyword volume, ASIN list, reviews, Keepa, or supplier quotes yet.

Goal: tell me if this is worth researching further.
```

## Expected Routing

`PM Triage / QYPM 000`

The evidence is too light for QYPM 001-007. The agent should only provide an initial research direction and a minimum data checklist.

## Expected Output

```text
## Summary

This can only be treated as an early opportunity screen. There may be a practical storage-use case, but the current evidence is not enough to judge demand, competition, differentiation, margin, compliance, or sourcing feasibility.

## Current Stage

PM Triage / QYPM 000.

## Known Facts

- Product direction: under-sink organizer.
- Marketplace: Amazon US.
- Current evidence is observational only.
- No BSR, keyword, ASIN, review, pricing, Keepa, supplier, or cost data has been provided.

## Signal Reading

- The category may have real use-case demand because under-sink storage is a recurring household pain point.
- Cheap-looking competitors may indicate either a quality-upgrade opportunity or a low-price commodity trap.
- Without keyword and BSR data, there is no evidence yet that demand is large enough or stable enough.

## Risks

- Highly commoditized category.
- Possible heavy/bulky shipping cost pressure.
- Differentiation may require structure, materials, packaging, or installation improvements.
- Final product definition and ROI are not allowed at this stage.

## Data Gaps

| Priority | Gap | Why It Matters | Next Step |
| --- | --- | --- | --- |
| P0 | BSR Top100 and price bands | Validate demand and competition structure | Collect category/search-result ASINs |
| P0 | Main keyword list and search volume proxy | Validate demand depth | Pull keywords and rank pages |
| P0 | 20-30 competitor ASINs | Build comparison baseline | Capture titles, prices, ratings, review counts |
| P1 | Review pain points | Check whether quality complaints are frequent | Sample negative reviews |
| P2 | Supplier quote and packaging size | Needed later for ROI | Do not collect until market signal is positive |

## Next Actions

1. Build a first competitor pool of 20-30 ASINs.
2. Split competitors by form factor, price, review count, and rating.
3. Pull a small review sample to see whether weak materials, installation, or size mismatch are repeated pain points.

## Decisions For Meeting

- Is the team willing to research a potentially commoditized storage category?
- What level of differentiation would be required before supplier outreach?
```
