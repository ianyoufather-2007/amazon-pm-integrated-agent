# Input Templates

Use these templates to structure your data before passing it to the agent. Well-structured input reduces P0 data gaps and produces more reliable stage-gate outputs.

Copy the relevant template, fill in what you have, and leave fields blank or mark them `[unknown]` if the data is not yet available. The agent will classify missing fields as P0, P1, or P2 gaps based on which stage you are running.

---

## BSR / Demand Signal Template

Use at Stage 002 (Demand Trend) or Stage 003 (Market Structure).

```json
{
  "input_type": "bsr_demand",
  "marketplace": "Amazon US",
  "product_direction": "",
  "keywords": [
    {
      "term": "",
      "monthly_searches": null,
      "trend": "stable | rising | falling | seasonal | unknown",
      "source": "Helium 10 | Jungle Scout | Amazon suggest | manual | unknown"
    }
  ],
  "bsr_proxies": [
    {
      "asin": "",
      "category": "",
      "bsr_rank": null,
      "estimated_monthly_units": null,
      "estimation_method": "formula | tool | manual | unknown"
    }
  ],
  "price_band_observed": {
    "low": null,
    "median": null,
    "high": null,
    "currency": "USD"
  },
  "notes": ""
}
```

---

## Keyword Cluster Template

Use at Stage 002 (Demand Trend) or to prepare keyword targeting for Stage 007.

```json
{
  "input_type": "keyword_cluster",
  "marketplace": "Amazon US",
  "seed_keywords": [],
  "long_tail_terms": [],
  "negative_terms": [],
  "keyword_groups": [
    {
      "group_name": "",
      "terms": [],
      "buyer_intent": "purchase | research | browse | unknown",
      "estimated_cpc_range": ""
    }
  ],
  "trend_direction": "stable | rising | falling | seasonal | unknown",
  "seasonality_notes": "",
  "source": "Helium 10 | Jungle Scout | Amazon suggest | manual | unknown"
}
```

---

## ASIN Comparison Template

Use at Stage 004 (Competitor Map).

```json
{
  "input_type": "asin_comparison",
  "marketplace": "Amazon US",
  "competitors": [
    {
      "asin": "",
      "title": "",
      "brand": "",
      "price": null,
      "rating": null,
      "review_count": null,
      "bsr_category": "",
      "bsr_rank": null,
      "listing_quality": "strong | average | weak | unknown",
      "main_gap": "",
      "notes": ""
    }
  ],
  "market_leader_asin": "",
  "entry_wedge_asin": "",
  "observed_at": "YYYY-MM-DD"
}
```

---

## VOC / Review Mining Template

Use at Stage 005 (VOC and Product Definition). Paste review snippets or summarise by theme.

```json
{
  "input_type": "voc_review_mining",
  "source_asins": [],
  "review_count_sampled": null,
  "star_rating_scope": "all | 1-3 | 4-5",
  "complaints": [
    {
      "theme": "",
      "frequency": "high | medium | low",
      "representative_quote": "",
      "actionable": true
    }
  ],
  "delights": [
    {
      "theme": "",
      "frequency": "high | medium | low",
      "representative_quote": ""
    }
  ],
  "unmet_needs": [
    {
      "wish": "",
      "evidence": "",
      "priority": "P0 | P1 | P2"
    }
  ],
  "exact_language": [],
  "notes": ""
}
```

---

## ROI / Profit Model Template

Use at Stage 006 (ROI and Risk).

```json
{
  "input_type": "roi_model",
  "marketplace": "Amazon US",
  "listing_price": null,
  "currency": "USD",
  "cost_components": {
    "cogs_fob": null,
    "inbound_freight_per_unit": null,
    "import_duty_pct": null,
    "fba_fulfillment_fee": null,
    "amazon_referral_fee_pct": null,
    "fba_storage_per_unit_monthly": null,
    "return_allowance_pct": null,
    "ad_spend_pct": null,
    "coupon_discount_pct": null,
    "other_per_unit": null
  },
  "confidence": {
    "cogs_fob": "confirmed | estimated | unknown",
    "freight": "confirmed | estimated | unknown",
    "fba_fees": "confirmed | estimated | unknown",
    "duty": "confirmed | estimated | unknown",
    "ad_spend": "confirmed | estimated | unknown"
  },
  "target_net_margin_pct": 20,
  "moq": null,
  "first_batch_units": null,
  "lead_time_days": null,
  "notes": ""
}
```

---

## Supplier Check Template

Use at Stage 006 (ROI and Risk) or Stage 007 (Validation Plan).

```json
{
  "input_type": "supplier_check",
  "marketplace": "Amazon US",
  "suppliers": [
    {
      "supplier_id": "A",
      "platform": "Alibaba | direct | referral | trade show | unknown",
      "fob_price": null,
      "moq": null,
      "lead_time_days": null,
      "payment_terms": "",
      "incoterms": "FOB | EXW | CIF | unknown",
      "sample_cost": null,
      "tooling_fee": null,
      "certifications": [],
      "key_risk": "",
      "notes": ""
    }
  ],
  "preferred_supplier": "",
  "preferred_reason": "",
  "compliance_checks_needed": [],
  "target_fob_ceiling": null,
  "currency": "USD"
}
```

---

## How To Use These Templates

1. Copy the JSON block for the relevant stage.
2. Fill in the values you have. Mark unknowns as `null` or `"unknown"`.
3. Paste the filled template into your agent prompt after the main request.
4. The agent will use the structured data directly and classify any `null` or `"unknown"` fields as P0, P1, or P2 data gaps.

### Example prompt with structured input

```text
Act as the Amazon PM Workflow Agent.

Run Stage 004 (Competitor Map) for under-sink organizers on Amazon US.

Competitor data:

{
  "input_type": "asin_comparison",
  "marketplace": "Amazon US",
  "competitors": [
    {
      "asin": "B0EXAMPLE1",
      "price": 34.99,
      "rating": 4.3,
      "review_count": 1842,
      "listing_quality": "strong",
      "main_gap": "requires drilling, no tool-free option"
    },
    {
      "asin": "B0EXAMPLE2",
      "price": 27.99,
      "rating": 3.9,
      "review_count": 312,
      "listing_quality": "weak",
      "main_gap": "flimsy shelves, poor images"
    }
  ],
  "observed_at": "2026-06-29"
}

Identify the strongest competitive gap and recommend a first-wedge positioning.
```
