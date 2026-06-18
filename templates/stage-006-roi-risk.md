# Stage 006: ROI And Risk Review

## Purpose

Use this stage to evaluate whether the product-definition hypothesis can survive cost, FBA, advertising, supplier, compliance, patent, and operational constraints.

## Use When

- The user has supplier quotes, BOM, packaging size, FBA estimates, target price, ad assumptions, compliance notes, patent notes, or sourcing constraints.
- The goal is to identify ROI range and major risk blockers before sample validation or tooling.

## Required Input

```text
Marketplace:
Product-definition hypothesis:
Target price:
Supplier quote/BOM:
Packaging size/weight:
FBA/fulfillment assumptions:
Advertising assumptions:
Compliance notes:
Patent/design-risk notes:
Operational constraints:
```

## Copy-Ready Prompt

```text
Act as Amazon PM Integrated Agent and run Stage 006 ROI And Risk Review.

Marketplace:
Product-definition hypothesis:
Target price:
Supplier quote/BOM:
Packaging size/weight:
FBA/fulfillment assumptions:
Advertising assumptions:
Compliance notes:
Patent/design-risk notes:
Operational constraints:

Assess whether the opportunity can survive economics and risk review.

Return:
1. Summary
2. Current stage
3. Known facts
4. ROI range and sensitivity factors
5. Cost and FBA pressure points
6. Advertising and conversion assumptions
7. Supplier and operations risks
8. Compliance and patent risk flags
9. Irreversible commitments
10. P0/P1/P2 data gaps
11. Next actions before sample validation
12. Decisions for meeting

Rules:
- Do not invent costs, fees, CPC, conversion rate, compliance status, or patent clearance.
- Present ROI as a range if inputs are incomplete.
- Do not say the product is legally/commercially cleared.
```

## Allowed Output

- ROI sensitivity memo.
- Risk register.
- Pre-sample decision support.

## Forbidden Output

- Final compliance clearance.
- Final patent clearance.
- Final supplier choice.
- Final Go/Kill decision unless meeting has already decided.
