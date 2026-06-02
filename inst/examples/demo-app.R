#!/usr/bin/env Rscript
# ============================================================================
# WFP Bootswatch Theme - Demo Application
# ============================================================================
# This Shiny app demonstrates all components and features of the
# WFP Bootswatch theme. Run with:
#   shiny::runApp("inst/examples/demo-app.R")
# ============================================================================

library(shiny)
library(bslib)
library(wfp.bootswatch)

# --- UI ---
ui <- page_navbar(
  title = tags$span(
    tags$strong("WFP"),
    " Bootswatch Theme"
  ),
  theme = wfp_theme(dark_mode = "auto"),
  bg = "#007dbc",
  inverse = TRUE,
  position = "fixed-top",
  padding = 0,
  header = tags$script(HTML(
    "
    // Dark mode toggle icon update
    $(document).on('click', '[data-wfp-toggle=\"dark-mode\"]', function() {
      var btn = $(this);
      var isDark = document.documentElement.getAttribute('data-bs-theme') === 'dark';
      btn.html(isDark ? '&#9789; Dark' : '&#9788; Light');
    });
    // Set initial label
    $(document).ready(function() {
      var isDark = document.documentElement.getAttribute('data-bs-theme') === 'dark';
      $('[data-wfp-toggle=\"dark-mode\"]').html(isDark ? '&#9789; Dark' : '&#9788; Light');
    });
  "
  )),

  # --- Colors Tab ---
  nav_panel(
    title = "Colors",
    value = "colors",
    padding = 24,

    h2("WFP Color Palette", class = "mb-4"),
    p(
      "The WFP color palette follows the organizational brand guidelines.",
      class = "text-muted mb-4"
    ),

    h4("Brand Colors", class = "mt-4 mb-3"),
    layout_column_wrap(
      width = 1 / 5,
      min_width = "150px",
      lapply(
        list(
          list(
            name = "WFP Blue",
            hex = "#007dbc",
            class = "bg-wfp-blue",
            text = "white"
          ),
          list(
            name = "Navy",
            hex = "#19486a",
            class = "bg-wfp-navy",
            text = "white"
          ),
          list(
            name = "Aqua",
            hex = "#26bde2",
            class = "bg-wfp-aqua",
            text = "dark"
          ),
          list(
            name = "Dark Green",
            hex = "#336d37",
            class = "bg-wfp-green",
            text = "white"
          ),
          list(
            name = "Lime",
            hex = "#8ad220",
            class = "bg-wfp-lime",
            text = "dark"
          )
        ),
        function(col) {
          card(
            style = sprintf(
              "background-color: %s; color: %s; min-height: 100px;",
              col$hex,
              if (col$text == "white") "#fff" else "#031c2d"
            ),
            card_body(
              h5(
                col$name,
                style = sprintf(
                  "color: %s;",
                  if (col$text == "white") "#fff" else "#031c2d"
                )
              ),
              code(
                col$hex,
                style = sprintf(
                  "color: %s; background: rgba(255,255,255,0.2); border: none;",
                  if (col$text == "white") "#fff" else "#031c2d"
                )
              )
            )
          )
        }
      )
    ),

    h4("Accent Colors", class = "mt-4 mb-3"),
    layout_column_wrap(
      width = 1 / 5,
      min_width = "150px",
      lapply(
        list(
          list(name = "Yellow", hex = "#f7b825", bg = "#f7b825"),
          list(name = "Ochre", hex = "#d29536", bg = "#d29536"),
          list(name = "Orange", hex = "#fd6925", bg = "#fd6925"),
          list(name = "Red", hex = "#c5192d", bg = "#c5192d"),
          list(name = "Magenta", hex = "#dd1367", bg = "#dd1367")
        ),
        function(col) {
          card(
            style = sprintf("background-color: %s; min-height: 100px;", col$bg),
            card_body(
              h5(col$name, style = "color: #fff;"),
              code(
                col$hex,
                style = "color: #fff; background: rgba(0,0,0,0.2); border: none;"
              )
            )
          )
        }
      )
    ),

    h4("Semantic Colors", class = "mt-4 mb-3"),
    layout_column_wrap(
      width = 1 / 5,
      min_width = "150px",
      card(
        class = "bg-primary text-white",
        card_body(h5("Primary"), code("#007dbc"))
      ),
      card(
        class = "bg-secondary text-white",
        card_body(h5("Secondary"), code("#19486a"))
      ),
      card(
        class = "bg-success text-white",
        card_body(h5("Success"), code("#336d37"))
      ),
      card(
        class = "bg-info text-dark",
        card_body(h5("Info"), code("#26bde2"))
      ),
      card(
        class = "bg-warning text-dark",
        card_body(h5("Warning"), code("#f7b825"))
      )
    ),
    div(
      class = "mt-3",
      card(
        class = "bg-danger text-white",
        style = "max-width: 250px;",
        card_body(h5("Danger"), code("#c5192d"))
      )
    ),

    h4("Neutral Colors", class = "mt-4 mb-3"),
    layout_column_wrap(
      width = 1 / 4,
      min_width = "150px",
      card(
        style = "background-color: #f5f7fa;",
        card_body(h5("Gray 3 (Light)"), code("#f5f7fa"))
      ),
      card(
        style = "background-color: #f0f3f6;",
        card_body(h5("Gray 2"), code("#f0f3f6"))
      ),
      card(
        style = "background-color: #dfe3e6;",
        card_body(h5("Gray 1 (Border)"), code("#dfe3e6"))
      ),
      card(
        class = "bg-dark text-white",
        card_body(h5("Dark Text"), code("#031c2d"))
      )
    )
  ),

  # --- Typography Tab ---
  nav_panel(
    title = "Typography",
    value = "typography",
    padding = 24,

    h2("Typography", class = "mb-4"),
    p(
      "WFP uses Open Sans as the primary typeface for Latin characters, with Noto Sans as the global fallback.",
      class = "text-muted mb-4"
    ),

    h1("Heading 1 (h1)"),
    h2("Heading 2 (h2)"),
    h3("Heading 3 (h3)"),
    h4("Heading 4 (h4)"),
    h5("Heading 5 (h5)"),
    h6("Heading 6 (h6)"),

    hr(),

    p(
      class = "lead",
      "This is a lead paragraph. It stands out from regular paragraphs with slightly larger text."
    ),
    p(
      "This is a regular paragraph. WFP's typography system emphasizes readability and clean hierarchy with a focus on humanitarian clarity. The body text uses a comfortable line height and neutral color for optimal reading experience."
    ),
    p(
      "Another paragraph with ",
      a(href = "#", "a link"),
      ", ",
      strong("bold text"),
      ", and ",
      em("italic text"),
      "."
    ),

    hr(),

    blockquote(
      class = "blockquote",
      p(
        "This is a blockquote. It features a left border accent in WFP Blue for visual distinction."
      ),
      footer(class = "blockquote-footer", "Source attribution")
    ),

    hr(),

    h5("Inline Text Elements"),
    p("You can use ", mark("mark"), " to highlight text."),
    p(
      "Use ",
      del("del"),
      " for deleted text and ",
      ins("ins"),
      " for inserted text."
    ),
    p("For variables, use ", var("x"), " = ", var("y"), " + ", var("z")),
    p("Keyboard input: ", kbd("Ctrl"), " + ", kbd("S")),

    hr(),

    h5("Code"),
    p("Inline code: ", code("wfp_theme()")),
    pre(
      "# This is a code block
          library(shiny)
          library(wfp.bootswatch)

          ui <- fluidPage(
            theme = wfp_theme(),
            titlePanel('Hello WFP!')
          )"
    ),

    hr(),

    h5("Font Weights"),
    p(style = "font-weight: 300;", "Light (300) - Open Sans Light"),
    p(style = "font-weight: 400;", "Regular (400) - Open Sans Regular"),
    p(style = "font-weight: 500;", "Medium (500) - Open Sans Medium"),
    p(style = "font-weight: 600;", "Semi-bold (600) - Open Sans SemiBold"),
    p(style = "font-weight: 700;", "Bold (700) - Open Sans Bold"),
    p(style = "font-weight: 800;", "Extra Bold (800) - Open Sans ExtraBold")
  ),

  # --- Buttons Tab ---
  nav_panel(
    title = "Buttons",
    value = "buttons",
    padding = 24,

    h2("Buttons", class = "mb-4"),

    h4("Solid Buttons", class = "mt-3 mb-3"),
    div(
      class = "d-flex gap-2 flex-wrap",
      actionButton("btn_primary", "Primary", class = "btn-primary"),
      actionButton("btn_secondary", "Secondary", class = "btn-secondary"),
      actionButton("btn_success", "Success", class = "btn-success"),
      actionButton("btn_info", "Info", class = "btn-info"),
      actionButton("btn_warning", "Warning", class = "btn-warning"),
      actionButton("btn_danger", "Danger", class = "btn-danger"),
      actionButton("btn_light", "Light", class = "btn-light"),
      actionButton("btn_dark", "Dark", class = "btn-dark")
    ),

    h4("Outline Buttons", class = "mt-4 mb-3"),
    div(
      class = "d-flex gap-2 flex-wrap",
      actionButton("btn_oprimary", "Primary", class = "btn-outline-primary"),
      actionButton(
        "btn_osecondary",
        "Secondary",
        class = "btn-outline-secondary"
      ),
      actionButton("btn_osuccess", "Success", class = "btn-outline-success"),
      actionButton("btn_odanger", "Danger", class = "btn-outline-danger"),
      actionButton("btn_owarning", "Warning", class = "btn-outline-warning")
    ),

    h4("Button Sizes", class = "mt-4 mb-3"),
    div(
      class = "d-flex gap-2 align-items-center flex-wrap",
      actionButton("btn_lg", "Large Button", class = "btn-primary btn-lg"),
      actionButton("btn_nm", "Normal Button", class = "btn-primary"),
      actionButton("btn_sm", "Small Button", class = "btn-primary btn-sm")
    ),

    h4("Button States", class = "mt-4 mb-3"),
    div(
      class = "d-flex gap-2 flex-wrap",
      actionButton("btn_norm", "Normal", class = "btn-primary"),
      tags$button("Disabled", class = "btn btn-primary", disabled = NA),
      actionButton("btn_act", "Active", class = "btn-primary active")
    ),

    h4("Button with Icon", class = "mt-4 mb-3"),
    div(
      class = "d-flex gap-2 flex-wrap",
      actionButton(
        "btn_icon1",
        label = HTML("&#10003; Save"),
        class = "btn-primary"
      ),
      actionButton(
        "btn_icon2",
        label = HTML("&#8594; Next"),
        class = "btn-secondary"
      ),
      actionButton(
        "btn_icon3",
        label = HTML("&#128465; Delete"),
        class = "btn-danger"
      ),
      actionButton(
        "btn_icon4",
        label = HTML("&#9432; Info"),
        class = "btn-info"
      )
    )
  ),

  # --- Forms Tab ---
  nav_panel(
    title = "Forms",
    value = "forms",
    padding = 24,

    h2("Form Components", class = "mb-4"),

    layout_column_wrap(
      width = 1 / 2,

      card(
        card_header("Text Inputs"),
        card_body(
          textInput("text_input", "Text Input", placeholder = "Enter text..."),
          passwordInput(
            "pwd_input",
            "Password Input",
            placeholder = "Enter password..."
          ),
          textAreaInput(
            "area_input",
            "Text Area",
            rows = 3,
            placeholder = "Enter longer text..."
          ),
          numericInput(
            "num_input",
            "Numeric Input",
            value = 42,
            min = 0,
            max = 100
          )
        )
      ),

      card(
        card_header("Select & Options"),
        card_body(
          selectInput(
            "select_input",
            "Select Input",
            choices = c("Option 1", "Option 2", "Option 3", "Option 4")
          ),
          selectInput(
            "select_multi",
            "Multi-Select",
            choices = c("Apple", "Banana", "Cherry", "Date"),
            multiple = TRUE
          ),
          checkboxInput("check_single", "Single Checkbox", value = TRUE),
          checkboxGroupInput(
            "check_group",
            "Checkbox Group",
            choices = c("Choice A", "Choice B", "Choice C")
          ),
          radioButtons(
            "radio_group",
            "Radio Buttons",
            choices = c("Option X", "Option Y", "Option Z")
          )
        )
      )
    ),

    card(
      class = "mt-3",
      card_header("Specialized Inputs"),
      card_body(
        layout_column_wrap(
          width = 1 / 3,
          sliderInput("slider", "Slider", min = 0, max = 100, value = 50),
          dateInput("date", "Date Picker", value = Sys.Date()),
          dateRangeInput(
            "date_range",
            "Date Range",
            start = Sys.Date() - 30,
            end = Sys.Date()
          )
        ),
        fileInput("file", "File Upload")
      )
    )
  ),

  # --- Components Tab ---
  nav_panel(
    title = "Components",
    value = "components",
    padding = 24,

    h2("Bootstrap Components", class = "mb-4"),

    layout_column_wrap(
      width = 1 / 2,

      # Alerts
      card(
        card_header("Alerts"),
        card_body(
          div(
            class = "alert alert-primary",
            HTML("<strong>Primary!</strong> This is a primary alert.")
          ),
          div(
            class = "alert alert-success",
            HTML("<strong>Success!</strong> This is a success alert.")
          ),
          div(
            class = "alert alert-warning",
            HTML("<strong>Warning!</strong> This is a warning alert.")
          ),
          div(
            class = "alert alert-danger",
            HTML("<strong>Danger!</strong> This is a danger alert.")
          ),
          div(
            class = "alert alert-info",
            HTML("<strong>Info!</strong> This is an info alert.")
          ),
          div(
            class = "alert alert-light",
            HTML("<strong>Light!</strong> This is a light alert.")
          ),
          div(
            class = "alert alert-dark",
            HTML("<strong>Dark!</strong> This is a dark alert.")
          )
        )
      ),

      # Badges
      card(
        card_header("Badges"),
        card_body(
          h5("Headings with badges:"),
          h5("Example Heading ", span(class = "badge bg-primary", "New")),
          p(
            "Inline badges: ",
            span(class = "badge bg-primary", "Primary"),
            " ",
            span(class = "badge bg-secondary", "Secondary"),
            " ",
            span(class = "badge bg-success", "Success"),
            " ",
            span(class = "badge bg-danger", "Danger"),
            " ",
            span(class = "badge bg-warning text-dark", "Warning"),
            " ",
            span(class = "badge bg-info text-dark", "Info")
          ),
          p(
            "Pill badges: ",
            span(class = "badge rounded-pill bg-primary", "Primary"),
            " ",
            span(class = "badge rounded-pill bg-success", "Success"),
            " ",
            span(class = "badge rounded-pill bg-danger", "Danger")
          )
        )
      )
    ),

    layout_column_wrap(
      width = 1 / 2,
      min_width = "300px",

      # Progress
      card(
        card_header("Progress Bars"),
        card_body(
          div(
            class = "mb-3",
            div(
              class = "d-flex justify-content-between mb-1",
              span("Primary"),
              span("25%")
            ),
            div(
              class = "progress",
              div(class = "progress-bar", style = "width: 25%", "25%")
            )
          ),
          div(
            class = "mb-3",
            div(
              class = "d-flex justify-content-between mb-1",
              span("Success"),
              span("50%")
            ),
            div(
              class = "progress",
              div(
                class = "progress-bar bg-success",
                style = "width: 50%",
                "50%"
              )
            )
          ),
          div(
            class = "mb-3",
            div(
              class = "d-flex justify-content-between mb-1",
              span("Warning"),
              span("75%")
            ),
            div(
              class = "progress",
              div(
                class = "progress-bar bg-warning text-dark",
                style = "width: 75%",
                "75%"
              )
            )
          ),
          div(
            class = "mb-3",
            div(
              class = "d-flex justify-content-between mb-1",
              span("Danger"),
              span("90%")
            ),
            div(
              class = "progress",
              div(class = "progress-bar bg-danger", style = "width: 90%", "90%")
            )
          ),
          div(
            class = "mb-0",
            div(
              class = "d-flex justify-content-between mb-1",
              span("Striped animated"),
              span("65%")
            ),
            div(
              class = "progress",
              div(
                class = "progress-bar progress-bar-striped progress-bar-animated bg-info",
                style = "width: 65%",
                "65%"
              )
            )
          )
        )
      ),

      # Cards
      card(
        card_header("Card Example"),
        card_body(
          h5(class = "card-title", "Card Title"),
          h6(class = "card-subtitle mb-2 text-muted", "Card Subtitle"),
          p(
            class = "card-text",
            "Some quick example text to build on the card title and make up the bulk of the card's content."
          ),
          a(href = "#", class = "card-link", "Card Link"),
          a(href = "#", class = "card-link", "Another Link")
        ),
        card_footer("Card Footer")
      )
    ),

    layout_column_wrap(
      width = 1,

      # Tables
      card(
        class = "mt-3",
        card_header("Tables"),
        card_body(
          tags$table(
            class = "table table-hover",
            tags$thead(
              tags$tr(
                tags$th("#"),
                tags$th("Name"),
                tags$th("Role"),
                tags$th("Status"),
                tags$th("Progress")
              )
            ),
            tags$tbody(
              tags$tr(
                tags$td("1"),
                tags$td("Alice Johnson"),
                tags$td("Program Officer"),
                tags$td(span(class = "badge bg-success", "Active")),
                tags$td(
                  div(
                    class = "progress",
                    style = "height: 6px;",
                    div(class = "progress-bar", style = "width: 85%")
                  )
                )
              ),
              tags$tr(
                tags$td("2"),
                tags$td("Bob Smith"),
                tags$td("Field Coordinator"),
                tags$td(span(class = "badge bg-success", "Active")),
                tags$td(
                  div(
                    class = "progress",
                    style = "height: 6px;",
                    div(class = "progress-bar bg-success", style = "width: 62%")
                  )
                )
              ),
              tags$tr(
                tags$td("3"),
                tags$td("Carol Davis"),
                tags$td("Data Analyst"),
                tags$td(span(class = "badge bg-warning text-dark", "Pending")),
                tags$td(
                  div(
                    class = "progress",
                    style = "height: 6px;",
                    div(class = "progress-bar bg-warning", style = "width: 40%")
                  )
                )
              ),
              tags$tr(
                tags$td("4"),
                tags$td("David Wilson"),
                tags$td("Logistics"),
                tags$td(span(class = "badge bg-danger", "Inactive")),
                tags$td(
                  div(
                    class = "progress",
                    style = "height: 6px;",
                    div(class = "progress-bar bg-danger", style = "width: 15%")
                  )
                )
              )
            )
          )
        )
      )
    ),

    # Pagination and Breadcrumb
    layout_column_wrap(
      width = 1 / 2,
      min_width = "300px",

      card(
        class = "mt-3",
        card_header("Pagination"),
        card_body(
          tags$nav(
            tags$ul(
              class = "pagination justify-content-center",
              tags$li(
                class = "page-item disabled",
                tags$a(class = "page-link", href = "#", "Previous")
              ),
              tags$li(
                class = "page-item active",
                tags$a(class = "page-link", href = "#", "1")
              ),
              tags$li(
                class = "page-item",
                tags$a(class = "page-link", href = "#", "2")
              ),
              tags$li(
                class = "page-item",
                tags$a(class = "page-link", href = "#", "3")
              ),
              tags$li(
                class = "page-item",
                tags$a(class = "page-link", href = "#", "Next")
              )
            )
          )
        )
      ),

      card(
        class = "mt-3",
        card_header("Breadcrumb"),
        card_body(
          tags$nav(
            tags$ol(
              class = "breadcrumb",
              tags$li(class = "breadcrumb-item", tags$a(href = "#", "Home")),
              tags$li(
                class = "breadcrumb-item",
                tags$a(href = "#", "Programs")
              ),
              tags$li(class = "breadcrumb-item active", "Current Program")
            )
          )
        )
      )
    ),

    # List Group
    layout_column_wrap(
      width = 1 / 2,
      min_width = "300px",

      card(
        class = "mt-3",
        card_header("List Group"),
        card_body(
          tags$div(
            class = "list-group",
            tags$a(
              href = "#",
              class = "list-group-item list-group-item-action active",
              tags$div(
                class = "d-flex w-100 justify-content-between",
                h5(class = "mb-1", "Active Item"),
                small("3 days ago")
              ),
              p(class = "mb-1", "This is the currently selected list item."),
              small("Additional details here.")
            ),
            tags$a(
              href = "#",
              class = "list-group-item list-group-item-action",
              tags$div(
                class = "d-flex w-100 justify-content-between",
                h5(class = "mb-1", "Second Item"),
                small(class = "text-muted", "1 week ago")
              ),
              p(class = "mb-1", "This is another list item."),
              small(class = "text-muted", "More details.")
            ),
            tags$a(
              href = "#",
              class = "list-group-item list-group-item-action",
              tags$div(
                class = "d-flex w-100 justify-content-between",
                h5(class = "mb-1", "Third Item"),
                small(class = "text-muted", "2 weeks ago")
              ),
              p(class = "mb-1", "Yet another list item."),
              small(class = "text-muted", "Final details.")
            )
          )
        )
      ),

      # Tabs
      card(
        class = "mt-3",
        card_header("Tabs"),
        card_body(
          tabsetPanel(
            tabPanel(
              "Overview",
              p("This is the overview tab with general information.")
            ),
            tabPanel(
              "Details",
              p(
                "This tab contains detailed information about the selected item."
              )
            ),
            tabPanel("Settings", p("Configure settings and preferences here."))
          )
        )
      )
    ),

    # Callouts
    card(
      class = "mt-3",
      card_header("WFP Callouts"),
      card_body(
        div(
          class = "wfp-callout callout-primary",
          div(class = "wfp-callout-title", "Primary Callout"),
          p("This is a primary callout with important information.")
        ),
        div(
          class = "wfp-callout callout-success",
          div(class = "wfp-callout-title", "Success Callout"),
          p("This action was completed successfully.")
        ),
        div(
          class = "wfp-callout callout-warning",
          div(class = "wfp-callout-title", "Warning Callout"),
          p("Please review this information before proceeding.")
        ),
        div(
          class = "wfp-callout callout-danger",
          div(class = "wfp-callout-title", "Danger Callout"),
          p("This action cannot be undone. Proceed with caution.")
        )
      )
    ),

    # Stats
    card(
      class = "mt-3",
      card_header("Stat Cards"),
      card_body(
        layout_column_wrap(
          width = 1 / 4,
          min_width = "150px",
          div(
            class = "wfp-stat wfp-stat-primary",
            div(class = "wfp-stat-value", "12,450"),
            div(class = "wfp-stat-label", "Beneficiaries"),
            div(class = "wfp-stat-change positive", "+8.5% vs last month")
          ),
          div(
            class = "wfp-stat wfp-stat-success",
            div(class = "wfp-stat-value", "94%"),
            div(class = "wfp-stat-label", "Distribution Rate"),
            div(class = "wfp-stat-change positive", "+2.1% vs last month")
          ),
          div(
            class = "wfp-stat wfp-stat-warning",
            div(class = "wfp-stat-value", "23"),
            div(class = "wfp-stat-label", "Pending Reviews"),
            div(class = "wfp-stat-change negative", "+5 since yesterday")
          ),
          div(
            class = "wfp-stat wfp-stat-danger",
            div(class = "wfp-stat-value", "3"),
            div(class = "wfp-stat-label", "Critical Alerts"),
            div(class = "wfp-stat-change negative", "Needs attention")
          )
        )
      )
    ),

    # Status dots
    card(
      class = "mt-3",
      card_header("Status Indicators"),
      card_body(
        p(span(class = "status-dot status-active"), "Active", class = "me-4"),
        p(
          span(class = "status-dot status-inactive"),
          "Inactive",
          class = "me-4"
        ),
        p(span(class = "status-dot status-warning"), "Warning", class = "me-4"),
        p(span(class = "status-dot status-danger"), "Critical", class = "me-4"),
        p(span(class = "status-dot status-info"), "Info")
      )
    )
  ),

  # --- About Tab ---
  nav_panel(
    title = "About",
    value = "about",
    padding = 24,

    div(
      class = "wfp-hero",
      h1("WFP Bootswatch Theme"),
      p(
        "A complete Bootswatch theme based on the World Food Programme UI Kit design system for R Shiny applications."
      ),
      actionButton("about_btn", "Learn More", class = "btn-light")
    ),

    layout_column_wrap(
      width = 1 / 3,
      min_width = "250px",
      card(
        card_header(tags$strong("Installation")),
        card_body(
          p("Install the package from GitHub:"),
          pre(
            "devtools::install_github(
  'wfp/wfp.bootswatch'
)"
          ),
          p("Or from CRAN:", class = "mt-2"),
          pre(
            "install.packages(
  'wfp.bootswatch'
)"
          )
        )
      ),
      card(
        card_header(tags$strong("Quick Start")),
        card_body(
          p("Apply the WFP theme to your Shiny app:"),
          pre(
            "library(shiny)
library(wfp.bootswatch)

ui <- fluidPage(
  theme = wfp_theme(),
  ...
)"
          ),
          p("Or use the convenience wrapper:", class = "mt-2"),
          pre(
            "ui <- wfpPage(
  title = 'My App',
  ...
)"
          )
        )
      ),
      card(
        card_header(tags$strong("Features")),
        card_body(
          tags$ul(
            tags$li("Complete WFP color palette"),
            tags$li("Open Sans typography"),
            tags$li("All Bootstrap 5 components styled"),
            tags$li(
              "WFP custom components (callouts, stat cards, status dots)"
            ),
            tags$li("Full dark mode support (toggle, auto, or forced)"),
            tags$li("Accessibility compliant (WCAG AA)"),
            tags$li("Flat Material Design aesthetic")
          )
        )
      )
    ),

    div(
      class = "wfp-content-box mt-4",
      h4("Color Palette Reference"),
      p(
        "The theme includes the full WFP color palette mapped to Bootstrap's semantic colors:"
      ),
      tags$table(
        class = "table table-sm",
        tags$thead(
          tags$tr(
            tags$th("Bootstrap"),
            tags$th("WFP Color"),
            tags$th("Hex Code")
          )
        ),
        tags$tbody(
          tags$tr(
            tags$td(tags$span(class = "badge bg-primary", "primary")),
            tags$td("WFP Blue"),
            tags$td(code("#007dbc"))
          ),
          tags$tr(
            tags$td(tags$span(class = "badge bg-secondary", "secondary")),
            tags$td("Navy"),
            tags$td(code("#19486a"))
          ),
          tags$tr(
            tags$td(tags$span(class = "badge bg-success", "success")),
            tags$td("Dark Green"),
            tags$td(code("#336d37"))
          ),
          tags$tr(
            tags$td(tags$span(class = "badge bg-info", "info")),
            tags$td("Aqua"),
            tags$td(code("#26bde2"))
          ),
          tags$tr(
            tags$td(tags$span(class = "badge bg-warning text-dark", "warning")),
            tags$td("Yellow"),
            tags$td(code("#f7b825"))
          ),
          tags$tr(
            tags$td(tags$span(class = "badge bg-danger", "danger")),
            tags$td("Red"),
            tags$td(code("#c5192d"))
          ),
          tags$tr(
            tags$td(tags$span(class = "badge bg-light text-dark", "light")),
            tags$td("Gray 3"),
            tags$td(code("#f5f7fa"))
          ),
          tags$tr(
            tags$td(tags$span(class = "badge bg-dark", "dark")),
            tags$td("Dark Text"),
            tags$td(code("#031c2d"))
          )
        )
      )
    ),

    hr(),

    p(
      class = "text-muted text-center",
      "WFP Bootswatch Theme v0.1.0 | World Food Programme Design System"
    )
  ),

  # --- Dark Mode Toggle ---
  nav_item(
    wfp_dark_mode_toggle(class = "btn-sm btn-outline-light my-1")
  ),

  # --- Footer / Bottom bar ---
  nav_item(
    tags$a(
      href = "https://designsystem.wfp.org/",
      target = "_blank",
      class = "nav-link",
      "WFP Design System \u2197"
    )
  )
)

# --- Server ---
server <- function(input, output, session) {
  # Button click handlers
  observeEvent(input$about_btn, {
    showModal(modalDialog(
      title = "About WFP Bootswatch Theme",
      p(
        "This theme is based on the World Food Programme UI Kit design system."
      ),
      p(
        "It provides a complete, ready-to-use Bootstrap 5 theme for Shiny applications with WFP branding."
      ),
      easyClose = TRUE,
      footer = modalButton("Close")
    ))
  })

  observeEvent(input$btn_primary, {
    showNotification("Primary button clicked!", type = "message")
  })
  observeEvent(input$btn_success, {
    showNotification("Success! Action completed.", type = "message")
  })
  observeEvent(input$btn_danger, {
    showNotification("Danger! Please be careful.", type = "error")
  })
  observeEvent(input$btn_warning, {
    showNotification("Warning! Check your input.", type = "warning")
  })
}

# --- Run App ---
shinyApp(ui = ui, server = server)
