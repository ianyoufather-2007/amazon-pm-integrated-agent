# Stage 003: Market Structure

## Purpose

Use this stage to understand market concentration, price bands, review barriers, seller types, and attackable segments.

## Use When

- The user has BSR Top100/200/300, search-result data, price bands, rating/review counts, brand names, or seller observations.
- The goal is to understand whether the market has room for a small brand.

## Required Input

```text
Marketplace:
Category/search term:
BSR or search-result dataset:
Price bands:
Rating/review distribution:
Brand/seller observations:
Known outliers:
```

## Copy-Ready Prompt

```text
Act as Amazon PM Integrated Agent and run Stage 003 Market Structure.

Marketplace:
Category/search term:
BSR or search-result dataset:
Price bands:
Rating/review distribution:
Brand/seller observations:
Known outliers:

Analyze market structure and identify whether there are attackable segments.

Return:
1. Summary
2. Current stage
3. Known facts
4. Market concentration reading
5. Price-band reading
6. Rating/review barrier reading
7. Potential attackable segments
8. Risks and structural disadvantages
9. P0/P1/P2 data gaps
10. Next actions
11. Decisions for meeting

Rules:
- Do not assume exact sales from BSR unless provided.
- Do not call a segment attractive without evidence.
- Do not produce final product definition.
```

## Allowed Output

- Market-structure memo.
- Segment hypotheses.
- Competitor pool criteria for Stage 004.

## Forbidden Output

- Final segment choice.
- Final launch decision.
- ROI or sourcing conclusion.
