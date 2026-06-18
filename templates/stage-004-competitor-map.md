# Stage 004: Competitor Map

## Purpose

Use this stage to map direct competitors, feature clusters, price positions, listing claims, and likely differentiation paths.

## Use When

- The user has competitor ASINs, search results, listing summaries, pricing, ratings, reviews, or feature notes.
- The goal is to define the direct competitor set before VOC/product definition.

## Required Input

```text
Marketplace:
Product/category direction:
Competitor ASIN list:
Price/rating/review data:
Listing/title/bullet observations:
Feature/material/pack-count notes:
Known irrelevant ASINs:
```

## Copy-Ready Prompt

```text
Act as Amazon PM Integrated Agent and run Stage 004 Competitor Map.

Marketplace:
Product/category direction:
Competitor ASIN list:
Price/rating/review data:
Listing/title/bullet observations:
Feature/material/pack-count notes:
Known irrelevant ASINs:

Clean the competitor set and map direct competitors.

Return:
1. Summary
2. Current stage
3. Known facts
4. Direct competitor groups
5. Feature and positioning matrix
6. Price/rating/review barrier reading
7. Differentiation hypotheses
8. Risks and false competitors
9. P0/P1/P2 data gaps
10. Next actions for VOC extraction
11. Decisions for meeting

Rules:
- Do not treat every ASIN as a direct competitor.
- Do not invent listing details.
- Do not finalize product definition without Stage 005 VOC evidence.
```

## Allowed Output

- Clean competitor map.
- Feature and price matrix.
- Candidate direct competitor set.

## Forbidden Output

- Final product definition.
- Final differentiation claim.
- Patent, compliance, or ROI conclusion.
