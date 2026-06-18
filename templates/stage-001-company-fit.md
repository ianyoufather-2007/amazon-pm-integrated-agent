# Stage 001: Company Fit

## Purpose

Use this stage to check whether a market opportunity fits the team's actual constraints before deeper research.

## Use When

- The user has a product/category direction and wants to know whether it fits their company.
- The team has constraints around budget, sourcing, brand position, operations, compliance, or launch speed.
- The goal is to prevent attractive markets from becoming bad-fit projects.

## Required Input

```text
Marketplace:
Product/category direction:
Team strengths:
Team constraints:
Budget range:
Sourcing capability:
Operational limits:
Target price/margin:
Known evidence:
```

## Copy-Ready Prompt

```text
Act as Amazon PM Integrated Agent and run Stage 001 Company Fit.

Marketplace:
Product/category direction:
Team strengths:
Team constraints:
Budget range:
Sourcing capability:
Operational limits:
Target price/margin:
Known evidence:

Evaluate whether this opportunity fits the company's current capabilities.

Return:
1. Summary
2. Fit / partial fit / weak fit assessment
3. Known facts
4. Fit signals
5. Misfit signals
6. Risks and irreversible commitments
7. P0/P1/P2 data gaps
8. Next actions
9. Decisions for meeting

Rules:
- Do not make a final launch decision.
- Do not assume capabilities that were not provided.
- Mark uncertain constraints as data gaps.
```

## Allowed Output

- Company-fit assessment.
- Capability and constraint map.
- Risk-based next actions.

## Forbidden Output

- Final market-entry decision.
- Final product definition.
- Final ROI or launch budget.
