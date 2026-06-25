# Three-Round Workflow

The integrated agent groups Stages 001-007 into three evidence rounds. The rounds prevent the workflow from producing a detailed answer before the evidence can support it.

## Round 1: Market And Candidate Screening

Typical stages: 001-004.

Use when the evidence mainly contains company constraints, trend signals, BSR or category exports, keyword clusters, price bands, and candidate listings.

Allowed output:

- company-fit and market-structure reading
- candidate product forms and competitor set
- keyword and price-band hypotheses
- Stage 004 research list
- P0 / P1 / P2 evidence gaps

Forbidden output:

- final product definition
- confirmed ROI
- final compliance, patent, sourcing, or launch decision

Exit gate:

- the candidate form is explicit
- competitor selection rules are recorded
- the evidence inventory is traceable
- the Stage 004-005 inputs are listed

## Round 2: Competitor, VOC, And Product Hypothesis

Typical stages: 004-005.

Use when the evidence includes competitor pages, reverse keywords, reviews, Q&A, historical price or rank signals, and feature observations.

Allowed output:

- keyword-to-function mapping
- competitor function matrix
- VOC, scenario, Kano, FACT, or JTBD synthesis
- measurable product-definition hypotheses
- Stage 006 validation request

Forbidden output:

- confirmed ROI without cost inputs
- final legal, compliance, or patent conclusions
- production or launch approval

Exit gate:

- product hypotheses use values, ranges, enums, yes/no, or explicit pending fields
- claimed capabilities have a verification method
- unresolved cost and risk inputs are registered as gaps

## Round 3: Economics, Supply, Risk, And Physical Validation

Typical stages: 006-007.

Use when the evidence includes supplier quotes, part-level BOM, package dimensions, FBA and freight assumptions, samples, QC results, certificates, and IP review inputs.

Allowed output:

- rough, initial, and confirmed ROI ranges kept separate
- supplier and sample comparison
- compliance and patent risk register
- physical test results
- decision-support package for a meeting

Forbidden output:

- treating an estimate as a confirmed value
- hiding unresolved P0 risks
- presenting professional legal, compliance, finance, or sourcing advice as settled fact

Exit gate:

- every important number has an evidence ID or estimate label
- pass/fail criteria exist for physical tests
- red-line risks state the remaining evidence and owner
- the meeting receives questions and tradeoffs, not an invented decision

## Cross-round invariants

These rules apply in every round:

1. Keep facts, signal reading, risks, gaps, and meeting decisions separate.
2. Do not silently replace a value fixed in an earlier stage. Record the changed assumption and its downstream impact.
3. Keep market demand, unit economics, and launch timing in the same marketplace and time window.
4. Do not use Round 1 rough economics as Round 3 confirmation.
5. Every handoff must state allowed and forbidden output.
6. A blocked status must include at least one P0 gap and a concrete next action.
7. Real business data stays outside this public repository.
