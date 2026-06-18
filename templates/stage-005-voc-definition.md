# Stage 005: VOC And Product Definition Hypotheses

## Purpose

Use this stage to turn reviews, Q&A, listing evidence, and competitor complaints into product-definition hypotheses.

## Use When

- The user has review samples, Q&A, rating patterns, listing claims, images, or customer complaint notes.
- The goal is to identify customer jobs, pain points, proof gaps, and product-definition hypotheses.

## Required Input

```text
Marketplace:
Product/category direction:
Direct competitor ASINs:
Review/Q&A samples:
Listing claims:
Known positive feedback:
Known negative feedback:
Known evidence gaps:
```

## Copy-Ready Prompt

```text
Act as Amazon PM Integrated Agent and run Stage 005 VOC And Product Definition Hypotheses.

Marketplace:
Product/category direction:
Direct competitor ASINs:
Review/Q&A samples:
Listing claims:
Known positive feedback:
Known negative feedback:
Known evidence gaps:

Extract customer needs and create product-definition hypotheses.

Return:
1. Summary
2. Current stage
3. Known facts
4. Customer jobs and use scenarios
5. Repeated pain points
6. Positive purchase drivers
7. Product-definition hypotheses
8. Proof needed before design freeze
9. Risks and irreversible commitments
10. P0/P1/P2 data gaps
11. Next actions for ROI/sourcing/risk review
12. Decisions for meeting

Rules:
- Do not overstate a pain point unless frequency or examples support it.
- Do not claim a feature will win without proof.
- Do not move to tooling or supplier commitment without Stage 006 risk review.
```

## Allowed Output

- VOC themes.
- Customer jobs.
- Product-definition hypotheses.
- Testable improvement ideas.

## Forbidden Output

- Final product spec freeze.
- Final launch decision.
- Final compliance/patent/ROI conclusion.
