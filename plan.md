# Plan: WFP Bootswatch Theme for R Shiny

## Overview
Build a complete R Bootswatch theme based on the WFP (World Food Programme) UI Kit for use in Shiny applications. The theme will be implemented as an R package using `bslib` to create a modern Bootstrap 5 theme with WFP branding.

## WFP Design System Research (Completed)
**Colors:**
- Primary: #007dbc (WFP Blue)
- Navy: #19486a
- Aqua: #26bde2
- Dark Green: #336d37
- Lime: #8ad220
- Yellow: #f7b825
- Ochre: #d29536
- Orange: #fd6925
- Red: #c5192d
- Dark Red: #8d0b33
- Magenta: #dd1367
- Grays: #dfe3e6, #f0f3f6, #f5f7fa
- Dark Text: #031c2d

**Typography:**
- Primary: Open Sans (Latin), Noto Sans (Non-Latin)

**Spacing:** 8pt grid system

## Stage 1 — Theme Development (vibecoding-general-swarm)
Create the R package structure with:
1. Package scaffolding (DESCRIPTION, NAMESPACE, etc.)
2. bslib theme definition with all WFP color mappings
3. Custom SCSS for WFP-specific component styling
4. Theme function for easy use in Shiny
5. Demo Shiny app showcasing all components

## Stage 2 — Documentation & Examples
1. README with installation and usage instructions
2. Component showcase app
3. Documentation of all theme variables

## Output
- Complete R package: `wfp.bootswatch`
- Demo Shiny app
- Documentation
