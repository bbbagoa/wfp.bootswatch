# SPEC.md — WFP Bootswatch Theme for R Shiny

## Overview
An R package `wfp.bootswatch` that provides a complete Bootswatch theme based on the WFP (World Food Programme) UI Kit design system for use in Shiny applications via `bslib`.

## Package Structure
```
wfp.bootswatch/
├── DESCRIPTION
├── NAMESPACE
├── R/
│   ├── theme.R              # Main theme function
│   ├── wfp_theme.R          # bs_theme() wrapper with WFP preset
│   ├── update_wfp_theme.R   # Runtime theme updating
│   └── wfpPage.R            # Convenience page function
├── inst/
│   ├── wfp-theme/
│   │   ├── _wfp-variables.scss    # WFP SCSS variables
│   │   ├── _wfp-colors.scss       # WFP color palette
│   │   ├── _wfp-typography.scss   # WFP typography overrides
│   │   ├── _wfp-components.scss   # WFP component styling
│   │   ├── _wfp-custom.scss       # Additional WFP custom styles
│   │   └── wfp.scss               # Main SCSS entry point
│   └── examples/
│       └── demo-app.R             # Demo Shiny application
├── man/
│   ├── wfp_theme.Rd
│   ├── wfpPage.Rd
│   └── wfp.bootswatch-package.Rd
└── README.md
```

## Design Tokens

### Colors
- **primary**: `#007dbc` — WFP Blue
- **secondary**: `#19486a` — Navy
- **success**: `#336d37` — Dark Green
- **info**: `#26bde2` — Aqua
- **warning**: `#f7b825` — Yellow
- **danger**: `#c5192d` — Red
- **light**: `#f5f7fa` — Light Gray
- **dark**: `#031c2d` — Dark Text

### Extended Palette
- lime: `#8ad220`
- ochre: `#d29536`
- orange: `#fd6925`
- dark-red: `#8d0b33`
- magenta: `#dd1367`
- gray-1: `#dfe3e6`
- gray-2: `#f0f3f6`

### Typography
- **Base font**: "Open Sans", "Noto Sans", system-ui, -apple-system, sans-serif
- **Headings**: Same as base (Open Sans)
- **Font sizes**: Bootstrap 5 defaults

### Spacing
- 8pt grid system (Bootstrap 5 defaults aligned)

## API

### `wfp_theme(...)`
Creates a bslib theme with WFP branding.
- Parameters: All passed to `bslib::bs_theme()` with WFP defaults
- Returns: A `bs_theme` object

### `wfpPage(...)`
Convenience wrapper for `shiny::fluidPage()` with WFP theme pre-applied.
- Parameters: Same as `fluidPage()` plus `theme` (auto-set to WFP)

### `update_wfp_theme(session)`
Updates the theme at runtime for theming support.

## SCSS Architecture
- `_wfp-variables.scss`: Bootstrap variable overrides
- `_wfp-colors.scss`: WFP color palette definitions
- `_wfp-typography.scss`: Font family and text styling
- `_wfp-components.scss`: Button, card, navbar, form styling
- `_wfp-custom.scss`: Additional utility classes and WFP-specific styles
- `wfp.scss`: Entry point that imports all partials

## Key Bootstrap 5 Variable Overrides
```scss
$primary: #007dbc;
$secondary: #19486a;
$success: #336d37;
$info: #26bde2;
$warning: #f7b825;
$danger: #c5192d;
$light: #f5f7fa;
$dark: #031c2d;

$font-family-base: "Open Sans", "Noto Sans", system-ui, -apple-system, sans-serif;
$headings-font-family: $font-family-base;

$border-radius: 0.25rem;
$border-radius-sm: 0.2rem;
$border-radius-lg: 0.3rem;

$enable-shadows: false;  // WFP uses flat Material Design approach
$enable-gradients: false;
```

## Dependencies
- R (>= 4.0)
- bslib (>= 0.5.0)
- shiny (>= 1.7.0)
- sass (>= 0.4.0)

## Demo App Features
- Color palette showcase
- Typography samples
- All Bootstrap components styled
- Form elements
- Cards and navigation
- Alert and badge variants
