# WFP Bootswatch Theme for R Shiny

A complete [Bootswatch](https://bootswatch.com/) theme based on the [World Food Programme (WFP) UI Kit](https://designsystem.wfp.org/) design system for use in [R Shiny](https://shiny.posit.co/) applications via [bslib](https://rstudio.github.io/bslib/).

## Features

- **Complete WFP Color Palette** — All brand colors mapped to Bootstrap 5 semantic variables
- **WFP Typography** — Open Sans font family with Noto Sans fallback for global scripts
- **All Bootstrap 5 Components Styled** — Buttons, cards, forms, alerts, tables, navigation, and more
- **WFP Custom Components** — Callouts, stat cards, status indicators, hero sections, sidebar navigation
- **Full Dark Mode Support** — Toggle, auto (system preference), or forced dark mode
- **Accessibility Compliant** — WCAG AA conformant with enhanced focus styles and screen reader support
- **Flat Material Design** — Clean, modern aesthetic following WFP's design principles
- **Fully Customizable** — Override any color, font, or component via `bs_theme()` parameters

## Installation

### From GitHub (development)

```r
# install.packages("devtools")
devtools::install_github("wfp/wfp.bootswatch")
```

### From CRAN (when available)

```r
install.packages("wfp.bootswatch")
```

## Quick Start

### Basic Usage

```r
library(shiny)
library(wfp.bootswatch)

ui <- fluidPage(
  theme = wfp_theme(),
  titlePanel("My WFP Themed App"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "Observations:", min = 0, max = 1000, value = 500)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
}

shinyApp(ui, server)
```

### Using the Convenience Wrapper

```r
library(shiny)
library(wfp.bootswatch)

ui <- wfpPage(
  title = "My WFP App",
  h1("Welcome to WFP Theme"),
  p("This page automatically uses the WFP theme."),
  actionButton("go", "Get Started", class = "btn-primary")
)

server <- function(input, output) {}
shinyApp(ui, server)
```

## Color Palette

The theme maps WFP's organizational colors to Bootstrap's semantic color system:

| Bootstrap   | WFP Color    | Hex Code  | Preview                                    |
|-------------|-------------|-----------|--------------------------------------------|
| `primary`   | WFP Blue    | `#007dbc` | ![#007dbc](https://via.placeholder.com/20/007dbc/007dbc) |
| `secondary` | Navy        | `#19486a` | ![#19486a](https://via.placeholder.com/20/19486a/19486a) |
| `success`   | Dark Green  | `#336d37` | ![#336d37](https://via.placeholder.com/20/336d37/336d37) |
| `info`      | Aqua        | `#26bde2` | ![#26bde2](https://via.placeholder.com/20/26bde2/26bde2) |
| `warning`   | Yellow      | `#f7b825` | ![#f7b825](https://via.placeholder.com/20/f7b825/f7b825) |
| `danger`    | Red         | `#c5192d` | ![#c5192d](https://via.placeholder.com/20/c5192d/c5192d) |
| `light`     | Gray 3      | `#f5f7fa` | ![#f5f7fa](https://via.placeholder.com/20/f5f7fa/f5f7fa) |
| `dark`      | Dark Text   | `#031c2d` | ![#031c2d](https://via.placeholder.com/20/031c2d/031c2d) |

### Extended Palette

Additional WFP brand colors available via utility classes:

| Color       | Hex Code  | Background Class     | Text Class         |
|-------------|-----------|---------------------|-------------------|
| WFP Blue    | `#007dbc` | `.bg-wfp-blue`      | `.text-wfp-blue`   |
| Navy        | `#19486a` | `.bg-wfp-navy`      | `.text-wfp-navy`   |
| Aqua        | `#26bde2` | `.bg-wfp-aqua`      | `.text-wfp-aqua`   |
| Dark Green  | `#336d37` | `.bg-wfp-green`     | `.text-wfp-green`  |
| Lime        | `#8ad220` | `.bg-wfp-lime`      | `.text-wfp-lime`   |
| Yellow      | `#f7b825` | `.bg-wfp-yellow`    | `.text-wfp-yellow` |
| Ochre       | `#d29536` | `.bg-wfp-ochre`     | `.text-wfp-ochre`  |
| Orange      | `#fd6925` | `.bg-wfp-orange`    | `.text-wfp-orange` |
| Red         | `#c5192d` | `.bg-wfp-red`       | `.text-wfp-red`    |
| Magenta     | `#dd1367` | `.bg-wfp-magenta`   | `.text-wfp-magenta`|

## Customization

### Custom Colors

```r
theme <- wfp_theme(
  primary = "#0A6EB4",
  secondary = "#2a5f85",
  success = "#3f7e44"
)
```

### Custom Typography

```r
theme <- wfp_theme(
  base_font = "'Lato', sans-serif",
  font_scale = 1.1
)
```

### Enable Shadows

```r
theme <- wfp_theme(
  enable_shadows = TRUE
)
```

### Additional bs_theme() Options

All `bslib::bs_theme()` parameters are supported:

```r
theme <- wfp_theme(
  bootswatch = NULL,
  bg = "#ffffff",
  fg = "#031c2d",
  heading_font = "'Lato', sans-serif",
  `enable-rounded` = TRUE,
  `enable-transitions` = TRUE,
  prefix = "bs-"
)
```

## Dark Mode

The WFP theme includes comprehensive dark mode support with three activation modes:

### 1. Force Dark Mode

Always use dark mode regardless of system preference:

```r
ui <- fluidPage(
  theme = wfp_theme(dark_mode = TRUE),
  ...
)
```

### 2. Auto (System Preference)

Automatically detect and follow the user's system preference:

```r
ui <- fluidPage(
  theme = wfp_theme(dark_mode = "auto"),
  ...
)
```

### 3. No Dark Mode (Default)

Standard light mode only:

```r
ui <- fluidPage(
  theme = wfp_theme(dark_mode = FALSE),  # or omit the parameter
  ...
)
```

### Dark Mode Toggle Button

Add a toggle button to your UI so users can manually switch:

```r
ui <- fluidPage(
  theme = wfp_theme(dark_mode = "auto"),
  wfp_dark_mode_toggle(),           # Icon-only toggle
  # OR
  wfp_dark_mode_toggle(label = "Theme"),  # With label
  ...
)
```

The toggle button:
- Automatically updates its icon (sun/moon) to reflect the current mode
- Persists user preference in `localStorage`
- Sends the state to the Shiny server as `input$wfp_dark_mode`
- Works with both `dark_mode = TRUE` and `dark_mode = "auto"`

### Programmatic Control (Server-Side)

Toggle or set dark mode from the server:

```r
server <- function(input, output, session) {
  # Toggle when a button is clicked
  observeEvent(input$my_toggle, {
    wfp_toggle_dark_mode(session, "toggle")
  })

  # Force a specific mode
  observeEvent(input$force_dark, {
    wfp_toggle_dark_mode(session, "dark")
  })

  observeEvent(input$force_light, {
    wfp_toggle_dark_mode(session, "light")
  })
}
```

### Dark Mode Color Palette

Dark mode uses a deep navy-slate palette that complements WFP's brand colors:

| Element          | Light Mode    | Dark Mode     |
|------------------|---------------|---------------|
| Background       | `#ffffff`     | `#0d1b2a`     |
| Elevated Surface | `#f5f7fa`     | `#162536`     |
| Card Background  | `#ffffff`     | `#162536`     |
| Borders          | `#dfe3e6`     | `#2a3f54`     |
| Primary Text     | `#031c2d`     | `#e8ecf0`     |
| Secondary Text   | `#415058`     | `#9fb0c0`     |
| Tertiary Text    | `#6f787c`     | `#6b8399`     |
| Links            | `#007dbc`     | `#52ccea`     |

### JavaScript API

For advanced use cases, the dark mode state can be accessed via JavaScript:

```javascript
// Check current mode
window.wfpDarkMode.isDark();  // true or false

// Toggle
window.wfpDarkMode.toggle();

// Set specific mode
window.wfpDarkMode.set("dark");   // or "light" or "toggle"

// Get current theme
window.wfpDarkMode.get();  // "light" or "dark"

// Listen for changes
window.addEventListener("wfp-dark-mode-changed", function(e) {
  console.log("Theme changed to:", e.detail.theme);
});
```

## WFP Custom Components

### Callouts

```r
div(class = "wfp-callout callout-primary",
  div(class = "wfp-callout-title", "Important"),
  p("This is important information.")
)
```

Variants: `callout-primary`, `callout-success`, `callout-info`, `callout-warning`, `callout-danger`

### Stat Cards

```r
div(class = "wfp-stat wfp-stat-primary",
  div(class = "wfp-stat-value", "12,450"),
  div(class = "wfp-stat-label", "Beneficiaries"),
  div(class = "wfp-stat-change positive", "+8.5% vs last month")
)
```

### Status Dots

```r
span(class = "status-dot status-active")  # Green
span(class = "status-dot status-warning")  # Yellow
span(class = "status-dot status-danger")   # Red
span(class = "status-dot status-inactive") # Gray
span(class = "status-dot status-info")     # Aqua
```

### Hero Section

```r
div(class = "wfp-hero",
  h1("Welcome to WFP"),
  p("Description text here."),
  actionButton("btn", "Learn More", class = "btn-light")
)
```

### Content Box

```r
div(class = "wfp-content-box",
  h3("Content Title"),
  p("Your content here.")
)
```

With elevation: `wfp-content-box-elevated`

With accent border: `wfp-content-box-highlight`

## Typography

The theme uses **Open Sans** as the primary typeface with **Noto Sans** as a fallback for non-Latin scripts. Both are loaded automatically via Google Fonts.

| Element          | Font Weight | Size   |
|-----------------|-------------|--------|
| H1              | 600 (SemiBold) | 2.5rem |
| H2              | 600 (SemiBold) | 2.0rem |
| H3              | 600 (SemiBold) | 1.75rem |
| H4              | 600 (SemiBold) | 1.5rem |
| Body            | 400 (Regular)  | 1.0rem |
| Buttons         | 600 (SemiBold) | 1.0rem |
| Form Labels     | 500 (Medium)   | 0.875rem |

## Demo Application

Run the included demo app to see all components:

```r
shiny::runApp(system.file("examples", "demo-app.R", package = "wfp.bootswatch"))
```

The demo includes:
- Complete color palette showcase
- Typography samples
- All button variants
- Form components
- Cards, alerts, badges
- Tables and pagination
- Progress bars
- Tabs and accordions
- WFP custom components (callouts, stat cards, status dots)

## Accessibility

This theme is designed with accessibility in mind:

- **WCAG AA Compliant** — All color combinations meet minimum contrast ratios
- **Enhanced Focus Styles** — Visible focus indicators for keyboard navigation
- **Skip Links** — Support for skip-to-content navigation
- **Reduced Motion** — Respects `prefers-reduced-motion` settings
- **Semantic HTML** — Proper heading hierarchy and ARIA attributes via Bootstrap 5

## Dependencies

- R (>= 4.0)
- [bslib](https://rstudio.github.io/bslib/) (>= 0.5.0)
- [shiny](https://shiny.posit.co/) (>= 1.7.0)
- [sass](https://rstudio.github.io/sass/) (>= 0.4.0)
- [htmltools](https://rstudio.github.io/htmltools/) (>= 0.5.0)

## References

- [WFP Design System](https://designsystem.wfp.org/)
- [WFP UI Kit Documentation](https://uikit.wfp.org/)
- [WFP Bridge (Legacy)](https://bridge.designsystem.wfp.org/)
- [Bootstrap 5 Documentation](https://getbootstrap.com/docs/5.3/)
- [bslib Documentation](https://rstudio.github.io/bslib/)

## License

Apache License 2.0. See LICENSE file for details.

## Contributing

Contributions are welcome! Please see the [contributing guidelines](CONTRIBUTING.md) for details.

---

**World Food Programme** — Saving lives, changing lives.
