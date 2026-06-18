# Stage 000: Opportunity Triage

## Purpose

Use this stage to decide whether a loose product idea deserves deeper research.

## Use When

- The user only has a category idea, product direction, or rough competitor impression.
- There is no complete BSR, keyword, ASIN, review, cost, or supplier dataset yet.
- The goal is to decide the next minimum research action, not final product definition.

## Required Input

```text
Marketplace:
Product/category idea:
Known observations:
Business constraints:
Goal:
```

## Copy-Ready Prompt

```text
Act as Amazon PM Integrated Agent and run Stage 000 Opportunity Triage.

Marketplace:
Product/category idea:
Known observations:
Business constraints:
Goal:

Please decide whether this input should remain in lightweight PM triage or move into the 000-007 stage-gate workflow.

Return:
1. Summary
2. Current stage
3. Known facts
4. Signal reading
5. Risks and irreversible commitments
6. P0/P1/P2 data gaps
7. Next minimum validation actions
8. Decisions for meeting

Rules:
- Do not invent sales, search volume, profit, compliance, patent, or review conclusions.
- Do not produce final product definition, ROI, supplier decision, or Go/Kill language.
- If evidence is weak, say exactly what is missing.
```

## Allowed Output

- Opportunity screen.
- Minimum data checklist.
- Initial risk map.
- Next research path.

## Forbidden Output

- Final product definition.
- ROI or margin conclusion.
- Supplier decision.
- Compliance or patent clearance.
- Final Go/Kill decision.
