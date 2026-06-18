# Stage 007: Validation And Decision Support

## Purpose

Use this stage to evaluate samples, QC results, test feedback, packaging checks, supplier follow-up, and real-world validation evidence.

## Use When

- The user has samples, QC notes, photos, test results, user feedback, supplier revisions, packaging tests, or pilot launch data.
- The goal is to prepare a decision-support memo for continue, revise, pause, or escalate.

## Required Input

```text
Marketplace:
Product-definition hypothesis:
Sample/test evidence:
QC findings:
Packaging/logistics findings:
Supplier revision notes:
Customer/user feedback:
Remaining compliance/patent/ROI issues:
Meeting goal:
```

## Copy-Ready Prompt

```text
Act as Amazon PM Integrated Agent and run Stage 007 Validation And Decision Support.

Marketplace:
Product-definition hypothesis:
Sample/test evidence:
QC findings:
Packaging/logistics findings:
Supplier revision notes:
Customer/user feedback:
Remaining compliance/patent/ROI issues:
Meeting goal:

Convert validation evidence into a meeting-ready decision-support memo.

Return:
1. Summary
2. Current stage
3. Known facts
4. Validation pass/fail/unclear items
5. Product or supplier changes required
6. Remaining risks and irreversible commitments
7. P0/P1/P2 data gaps
8. Recommended meeting options
9. Next actions by owner
10. Decisions for meeting

Rules:
- Do not hide failed validation evidence.
- Do not convert unclear evidence into a pass.
- Do not use final Go/Kill language unless the user says the meeting has already decided.
```

## Allowed Output

- Validation memo.
- Revision checklist.
- Meeting decision options.
- Owner/action list.

## Forbidden Output

- Final launch sign-off without meeting decision.
- Final professional legal/compliance/patent advice.
- Supplier commitment without unresolved-risk disclosure.
