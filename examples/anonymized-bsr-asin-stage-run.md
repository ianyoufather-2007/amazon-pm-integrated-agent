# Example: Anonymized BSR + ASIN Stage Run

This example shows how the agent should behave when the user already has BSR, keyword, and competitor ASIN evidence. The correct behavior is to route into Research Round 1 and prepare Stage 004, while still avoiding final product definition or ROI.

## User Prompt

```text
Marketplace: Amazon US
Product direction: pantry storage bins
Available evidence:
- BSR Top100 snapshot from a relevant category
- Main keywords: pantry organizer bins, clear storage bins, fridge organizer bins
- 25 competitor ASINs
- Rough price bands: low, mid, premium
- No full Review/VOC extraction yet
- No Keepa history, supplier quote, FBA model, compliance check, or patent check yet

Goal: decide which research stage can run now and what the output should be.
```

## Expected Routing

`Research Round 1: 001-003, preparing 004`

The user has enough evidence for company fit, demand trend, market structure, and initial competitor segmentation. The agent should not produce final VOC, ROI, supplier, compliance, patent, or Go/Kill conclusions.

## Expected Output

```text
## Summary

The available evidence is enough to run Research Round 1: 001 company fit, 002 trend/demand reading, and 003 market structure. Because 25 competitor ASINs are available, the workflow can also prepare Stage 004 competitor segmentation. It is not yet ready for final product definition, ROI, or sourcing decisions.

## Current Stage

Stages 001-003, with Stage 004 preparation.

## Allowed Output

- Demand and market-structure reading.
- Price-band and form-factor segmentation.
- Initial competitor pool cleaning.
- Candidate attack angles for further validation.
- P0/P1/P2 data gaps.

## Forbidden Output

- Final product definition.
- Final Go/Kill decision.
- ROI or margin conclusion.
- Supplier selection.
- Compliance or patent clearance.

## Known Facts

- Marketplace is Amazon US.
- BSR Top100 snapshot exists.
- Main keyword set exists.
- 25 competitor ASINs are available.
- Price bands are roughly known.
- Review/VOC, Keepa, supplier, FBA, compliance, and patent evidence are missing.

## Signal Reading

- If BSR Top100 is distributed across multiple sellers and price bands, the category may be less monopolized.
- If the 25 ASINs cluster into similar clear-bin designs, differentiation may need to come from sizing system, lid/handle design, bundling, labeling, material thickness, or storage scenario specialization.
- If premium products hold strong review counts, there may be room for a higher-quality positioning, but this requires Review/VOC proof.

## Risks

- Clear plastic storage bins can be heavily commoditized.
- Packaging volume and breakage risk may pressure FBA economics.
- Material claims, food-contact use, and durability messaging need compliance-aware review before listing.
- Similar shapes and functional features may require design/patent screening before tooling.

## Data Gaps

| Priority | Gap | Why It Matters | Next Step |
| --- | --- | --- | --- |
| P0 | Clean BSR Top100 table | Validate category demand and concentration | Normalize ASIN, brand, price, rating, review count |
| P0 | Keyword demand/CPC proxy | Validate traffic cost and demand depth | Pull keyword tool data or ABA proxy |
| P0 | Competitor segmentation | Identify attackable clusters | Group by form, size, pack count, feature, price |
| P1 | Review/VOC sample | Identify real dissatisfaction | Run Stage 005 after ASIN pool is cleaned |
| P1 | Keepa history | Check seasonality and price stability | Pull for top competitors |
| P2 | Supplier quote/FBA model | Needed for ROI later | Wait until market and VOC pass |

## Next Actions

1. Clean the 25-ASIN competitor pool and remove irrelevant listings.
2. Segment by form factor, price band, pack count, rating, and review count.
3. Select 8-12 direct competitors for Stage 004.
4. Move to Stage 005 only after Review/Q&A evidence is collected.

## Decisions For Meeting

- Which price band should be investigated first?
- Is the team targeting commodity efficiency or a premium differentiation angle?
- What evidence threshold is required before supplier outreach?
```
