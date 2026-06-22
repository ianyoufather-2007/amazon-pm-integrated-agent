# Example: anonymized end-to-end stage-gate review

This example uses synthetic, anonymized inputs. It shows how the agent should move from a loose product direction into a meeting-ready stage-gate memo without inventing sales, profit, compliance, patent, or supplier conclusions.

## User Prompt

```text
Marketplace: Amazon US
Product direction: under-sink organizer
Available evidence:
- 8 seed keywords from Amazon search suggestions
- 18 competitor ASINs from search results
- Rough price range observed: $22-$45
- 40 review snippets copied from public listings
- Initial supplier comment: steel frame and plastic tray are possible, no formal quote yet

Business constraints:
- Small brand
- Limited first-order budget
- Need simple packaging
- Prefer products that can be validated before tooling

Goal: prepare a meeting memo that tells us what can be decided now, what cannot be decided yet, and what data must be collected next.
```

## Expected Agent Behavior

1. Route the request into an integrated stage-gate review, not a final launch decision.
2. Use Stage 001-005 for current evidence and only prepare Stage 006 as a gap list.
3. Separate known facts from signal reading and risk interpretation.
4. Mark missing evidence as P0 / P1 / P2.
5. Avoid final Go/Kill language unless the user says the meeting already made that decision.

## Meeting-Ready Output

```text
## Summary

The current evidence is enough for a structured opportunity review, but not enough for final product definition, ROI, supplier selection, compliance clearance, or launch approval. The strongest current use of the data is to decide whether the team should spend the next 7-10 days collecting a clean competitor pool, keyword demand proxy, review/VOC sample, and first supplier quote.

## Current Stage

Integrated stage-gate review:
- Stage 001: Company Fit - partially runnable
- Stage 002: Demand Trend - not yet data-backed
- Stage 003: Market Structure - partially runnable
- Stage 004: Competitor Map - partially runnable
- Stage 005: VOC Definition - early sample only
- Stage 006: ROI/Risk - gap planning only
- Stage 007: Validation - not ready

## Known Facts

| Area | Known evidence | Confidence |
| --- | --- | --- |
| Marketplace | Amazon US | High |
| Product direction | Under-sink organizer | High |
| Keywords | 8 seed keywords from search suggestions | Medium |
| Competitors | 18 ASINs from search results | Medium |
| Price observation | $22-$45 observed range | Medium |
| Review evidence | 40 copied snippets | Low-to-medium |
| Supplier evidence | Informal material feasibility comment only | Low |

## Signal Reading

Stage 001 company fit:
- The product direction may fit a small brand because the concept can be validated through simple form-factor differences, packaging, and listing positioning.
- The first-order budget constraint is important because bulky household storage products can create FBA, storage, and cash-cycle pressure.

Stage 002 demand trend:
- Search suggestions show that users have multiple ways to describe the need, but search volume, seasonality, CPC, and trend direction are still missing.
- Demand cannot be called strong or weak yet.

Stage 003 market structure:
- The observed $22-$45 price range suggests multiple price bands may exist.
- The 18-ASIN pool is useful for initial clustering, but not enough to judge concentration, review barrier, or small-brand entry space.

Stage 004 competitor map:
- Current ASINs should be grouped by material, shelf count, adjustability, tray depth, installation method, and pack count.
- The team should avoid comparing unrelated cabinet organizers, pantry bins, and bathroom caddies as if they were one market.

Stage 005 VOC definition:
- The 40 review snippets can start a pain-point map, but the sample is too small for final product definition.
- Possible VOC themes to validate: wobbling, assembly difficulty, wrong size expectation, weak sliding rail, water resistance, and cleaning difficulty.

Stage 006 ROI/risk:
- ROI cannot be calculated without quote, package dimensions, weight, FBA fee estimate, return assumptions, and launch CPC.
- Compliance/patent review should be treated as a blocker checklist, not as cleared.

## Risks And Irreversible Commitments

- Cash-cycle risk: bulky inventory may lock cash before the team has proof of demand.
- Review-barrier risk: top competitors may have review depth that a small brand cannot catch quickly.
- Differentiation risk: simple material or color changes may be too weak if competitor listings already cover them.
- Operational risk: size mismatch can create returns if the listing does not explain cabinet dimensions clearly.
- Compliance/IP risk: no clearance has been performed; do not make supplier or tooling commitments yet.

## Data Gaps

| Priority | Gap | Why it matters | Next action |
| --- | --- | --- | --- |
| P0 | Clean 50-100 ASIN competitor pool | Needed to judge price bands, review barrier, seller type, and attackable clusters | Pull search-result and BSR candidates, then remove irrelevant forms |
| P0 | Keyword demand and CPC proxy | Needed to separate real demand from weak search-suggestion noise | Collect keyword volume proxy, ABA/rank proxy, CPC, and trend snapshots |
| P0 | Basic FBA model | Needed before any launch budget discussion | Estimate package size, weight, referral fee, FBA fee, storage, and returns |
| P1 | Review/VOC sample of 200+ snippets | Needed to validate whether pain points repeat across competitors | Sample low-star and high-frequency review themes |
| P1 | Supplier quote and MOQ | Needed to test cash fit and margin pressure | Ask for material, dimensions, MOQ, packaging, lead time, and sample fee |
| P1 | Patent/design/trademark screen | Needed before locking structure or visual design | Search obvious structure terms and competitor design claims |
| P2 | Packaging test plan | Needed later for Stage 007 | Define drop-test, size-label, and instruction-sheet checks |

## Next Actions

1. Build a clean competitor table with ASIN, title, price, rating, review count, material, size, pack count, and seller type.
2. Split the market into likely segments before comparing winners and losers.
3. Pull keyword demand/CPC proxy for the seed terms and 10-20 related phrases.
4. Expand the review sample and tag each complaint by issue type and product component.
5. Request a first quote with package dimensions and MOQ, but do not commit to tooling or purchase order.
6. Prepare a one-page meeting memo with facts, risks, P0 gaps, and decision questions.

## Decisions For Meeting

- Does the team want to spend 7-10 days collecting P0 data for this direction?
- Which segment should be studied first: two-tier sliding organizer, expandable shelf, or drawer-style bin?
- What is the maximum first-order cash exposure the team is willing to consider?
- What review barrier would make this opportunity unattractive for a small brand?
- Which risk must block the project immediately: ROI, compliance/IP, supplier complexity, or review moat?
```

## Quality Checks

- The output gives a stage decision, not a launch decision.
- Facts and interpretations are separated.
- P0 / P1 / P2 gaps are explicit.
- ROI, compliance, patent, and supplier conclusions are not invented.
- The meeting receives decision questions instead of unsupported final approval language.
