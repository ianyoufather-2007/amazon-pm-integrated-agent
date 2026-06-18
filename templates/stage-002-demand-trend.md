# Stage 002: Demand And Trend Reading

## Purpose

Use this stage to judge whether demand appears real, stable, growing, seasonal, or too weak to continue.

## Use When

- The user has keywords, BSR snapshots, search-volume proxies, ABA/CPC data, Google Trends, Keepa, or seasonal signals.
- The goal is to understand demand quality before competitor deep-dive or product definition.

## Required Input

```text
Marketplace:
Product/category direction:
Main keywords:
Keyword demand signals:
BSR/category signals:
Trend/seasonality signals:
CPC/advertising signals:
Known caveats:
```

## Copy-Ready Prompt

```text
Act as Amazon PM Integrated Agent and run Stage 002 Demand And Trend Reading.

Marketplace:
Product/category direction:
Main keywords:
Keyword demand signals:
BSR/category signals:
Trend/seasonality signals:
CPC/advertising signals:
Known caveats:

Assess whether demand is real, stable, growing, seasonal, or weak.

Return:
1. Summary
2. Current stage
3. Known facts
4. Demand signals
5. Trend and seasonality reading
6. Advertising pressure reading
7. Risks and false-positive signals
8. P0/P1/P2 data gaps
9. Next actions
10. Decisions for meeting

Rules:
- Do not invent search volume or sales.
- Separate observed data from interpretation.
- Do not move to final product definition without competitor and VOC evidence.
```

## Allowed Output

- Demand quality reading.
- Seasonality risk.
- Keyword and traffic-pressure interpretation.

## Forbidden Output

- Final sales forecast.
- Final ROI conclusion.
- Final product definition.
