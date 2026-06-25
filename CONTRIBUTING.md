# Contributing

Thanks for considering a contribution.

This project is a clean public agent layer for Amazon product-management workflows. Please keep contributions practical, anonymized, and safe to publish.

## Good Contributions

- Better prompt templates for PM triage or research stage routing.
- Anonymized examples with no real business data.
- Clearer stage-gate definitions.
- Portable handoff schemas, validation rules, and QA checks.
- Documentation improvements in Chinese or English.
- Generic schemas or checklists that do not expose private data.

## Do Not Contribute

- Raw ASIN exports, seller data, advertising reports, supplier quotes, customer data, screenshots, cookies, sessions, or private documents.
- Claims that require legal, compliance, patent, financial, or sourcing review unless clearly framed as research-support notes.
- Fabricated sales, search volume, profit, review, or compliance conclusions.

## Pull Request Checklist

- The change is useful without private local folders.
- All examples are anonymized.
- No `.xlsx`, `.pptx`, `.pdf`, raw JSON, screenshots, cache, or credential files are included.
- New workflow logic preserves the distinction between facts, interpretation, risks, gaps, and decisions.
- Missing data is labeled as P0 / P1 / P2.
- `scripts/privacy-check.ps1`, `scripts/content-check.ps1`, and `scripts/handoff-check.tests.ps1` pass.
