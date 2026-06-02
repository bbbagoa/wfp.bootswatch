#' Create a WFP Bootswatch Theme
#'
#' Creates a \code{bslib::bs_theme()} object with WFP (World Food Programme)
#' branding applied. This theme can be used with any Shiny application or
#' R Markdown document that supports \code{bslib} theming.
#'
#' @param version The Bootstrap version to use. Defaults to 5.
#' @param primary Primary brand color. Default: WFP Blue \code{"#007dbc"}.
#' @param secondary Secondary color. Default: WFP Navy \code{"#19486a"}.
#' @param success Success color. Default: WFP Dark Green \code{"#336d37"}.
#' @param info Info color. Default: WFP Aqua \code{"#26bde2"}.
#' @param warning Warning color. Default: WFP Yellow \code{"#f7b825"}.
#' @param danger Danger color. Default: WFP Red \code{"#c5192d"}.
#' @param light Light color. Default: \code{"#f5f7fa"}.
#' @param dark Dark color. Default: \code{"#031c2d"}.
#' @param base_font Base font family. Default: WFP Open Sans stack.
#' @param code_font Code font family. Default: Source Code Pro stack.
#' @param heading_font Heading font family. Default: same as \code{base_font}.
#' @param font_scale Overall font scale multiplier. Default: 1.0.
#' @param enable_shadows Enable shadow effects. Default: \code{FALSE} (WFP uses flat design).
#' @param enable_gradients Enable gradient effects. Default: \code{FALSE}.
#' @param dark_mode Enable dark mode support. One of \code{FALSE} (no dark mode),
#'   \code{TRUE} (force dark mode), or \code{"auto"} (respect system preference).
#'   Default: \code{FALSE}.
#' @param ... Additional arguments passed to \code{bslib::bs_theme()}.
#'
#' @return A \code{bs_theme} object that can be passed to Shiny apps or
#'   R Markdown documents.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Basic usage in a Shiny app
#' library(shiny)
#' library(bslib)
#' library(wfp.bootswatch)
#'
#' ui <- fluidPage(
#'   theme = wfp_theme(),
#'   titlePanel("WFP Themed App"),
#'   sidebarLayout(
#'     sidebarPanel(
#'       sliderInput("obs", "Observations:", min = 0, max = 1000, value = 500)
#'     ),
#'     mainPanel(
#'       plotOutput("distPlot")
#'     )
#'   )
#' )
#'
#' server <- function(input, output) {
#'   output$distPlot <- renderPlot({
#'     hist(rnorm(input$obs))
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#' # With dark mode toggle support (respects system preference)
#' theme <- wfp_theme(dark_mode = "auto")
#'
#' # Force dark mode
#' theme <- wfp_theme(dark_mode = TRUE)
#'
#' # With customizations
#' theme <- wfp_theme(
#'   primary = "#0A6EB4",
#'   font_scale = 1.1,
#'   enable_shadows = TRUE
#' )
#' }
wfp_theme <- function(
    version = 5,
    primary = "#007dbc",
    secondary = "#19486a",
    success = "#336d37",
    info = "#26bde2",
    warning = "#f7b825",
    danger = "#c5192d",
    light = "#f5f7fa",
    dark = "#031c2d",
    base_font = wfp_font()$base,
    code_font = wfp_font()$code,
    heading_font = NULL,
    font_scale = 1.0,
    enable_shadows = FALSE,
    enable_gradients = FALSE,
    dark_mode = FALSE,
    ...
) {
  if (is.null(heading_font)) {
    heading_font <- base_font
  }

  # Get the package-installed SCSS directory
  scss_dir <- system.file("wfp-theme", package = "wfp.bootswatch")

  # Determine the 'data-bs-theme' attribute value
  bs_theme_attr <- switch(
    as.character(dark_mode),
    "TRUE"  = "dark",
    "true"  = "dark",
    "auto"  = "auto",
    "FALSE" = "light",
    "false" = "light",
    "light" = "light",
    "light"
  )

  # Create the base bs_theme with WFP colors
  theme <- bslib::bs_theme(
    version = version,
    bootswatch = NULL,
    preset = NULL,
    primary = primary,
    secondary = secondary,
    success = success,
    info = info,
    warning = warning,
    danger = danger,
    light = light,
    dark = dark,
    base_font = base_font,
    code_font = code_font,
    heading_font = heading_font,
    font_scale = font_scale,
    `enable-shadows` = enable_shadows,
    `enable-gradients` = enable_gradients,
    ...
  )

  # Add WFP custom SCSS layers
  theme <- bslib::bs_add_rules(theme, sass::sass_file(file.path(scss_dir, "wfp.scss")))

  # Add font dependency for Open Sans
  theme <- bslib::bs_bundle(
    theme,
    bslib::bs_theme_dependency(
      htmltools::htmlDependency(
        name = "wfp-fonts",
        version = "0.1.0",
        src = list(href = "https://fonts.googleapis.com"),
        stylesheet = c(
          "css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;1,300;1,400;1,500;1,600;1,700;1,800&display=swap",
          "css2?family=Noto+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap",
          "css2?family=Source+Code+Pro:wght@400;500;600;700&display=swap"
        )
      )
    )
  )

  # Add dark mode toggle JS if dark_mode is enabled
  if (isTRUE(dark_mode) || identical(dark_mode, "auto")) {
    js_file <- system.file("wfp-theme", "wfp-dark-mode.js", package = "wfp.bootswatch")
    if (file.exists(js_file)) {
      theme <- bslib::bs_bundle(
        theme,
        bslib::bs_theme_dependency(
          htmltools::htmlDependency(
            name = "wfp-dark-mode-js",
            version = "0.1.0",
            src = system.file("wfp-theme", package = "wfp.bootswatch"),
            script = "wfp-dark-mode.js"
          )
        )
      )
    }

    # Add the data-bs-theme attribute setter
    theme <- bslib::bs_bundle(
      theme,
      bslib::bs_theme_dependency(
        htmltools::htmlDependency(
          name = "wfp-bs-theme-attr",
          version = "0.1.0",
          head = sprintf(
            '<script>(function(){var h=document.documentElement;var m="%s";if(m==="auto"){var p=window.matchMedia("(prefers-color-scheme: dark)");h.setAttribute("data-bs-theme",p.matches?"dark":"light");p.addEventListener("change",function(e){h.setAttribute("data-bs-theme",e.matches?"dark":"light");});}else{h.setAttribute("data-bs-theme",m);}})();</script>',
            bs_theme_attr
          )
        )
      )
    )
  }

  theme
}


#' Dark Mode Toggle for WFP Theme
#'
#' Creates a toggle button or switch that allows users to switch between
#' light and dark modes at runtime. This function generates the UI for
#' a dark mode control.
#'
#' @param id The input ID for the toggle. Default: \code{"wfp_dark_mode"}.
#' @param label Label text. Default: \code{NULL} (icon only).
#' @param icon Icon to display. Default: a moon/sun icon.
#' @param class Additional CSS classes. Default: \code{"btn-sm"}.
#'
#' @return A Shiny UI element (button) that toggles dark mode.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' library(shiny)
#' library(wfp.bootswatch)
#'
#' ui <- fluidPage(
#'   theme = wfp_theme(dark_mode = "auto"),
#'   wfp_dark_mode_toggle(),
#'   h1("My App")
#' )
#'
#' server <- function(input, output, session) {
#'   observeEvent(input$wfp_dark_mode, {
#'     # The toggle is handled automatically by JavaScript
#'     # But you can react to the change here if needed
#'     message("Dark mode: ", input$wfp_dark_mode)
#'   })
#' }
#' }
wfp_dark_mode_toggle <- function(
    id = "wfp_dark_mode",
    label = NULL,
    icon = NULL,
    class = "btn-sm"
) {
  if (is.null(icon)) {
    icon <- htmltools::HTML("&#9788;&#65038;")
  }

  htmltools::tags$button(
    id = id,
    class = paste("btn btn-outline-secondary wfp-dark-mode-toggle", class),
    type = "button",
    `aria-label` = "Toggle dark mode",
    `data-wfp-toggle` = "dark-mode",
    icon,
    if (!is.null(label)) htmltools::tags$span(class = "ms-1", label)
  )
}


#' Programmatically Toggle Dark Mode
#'
#' Sends a message to the client to toggle or set the dark mode state.
#' Use this from the server side to control dark mode programmatically.
#'
#' @param session The Shiny session object.
#' @param mode Either \code{"toggle"} to switch, \code{"dark"} to enable,
#'   or \code{"light"} to disable. Default: \code{"toggle"}.
#'
#' @return Invisible NULL. Called for side effects.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' server <- function(input, output, session) {
#'   # Toggle dark mode when a button is clicked
#'   observeEvent(input$toggle_btn, {
#'     wfp_toggle_dark_mode(session, "toggle")
#'   })
#'
#'   # Force dark mode
#'   observeEvent(input$force_dark, {
#'     wfp_toggle_dark_mode(session, "dark")
#'   })
#' }
#' }
wfp_toggle_dark_mode <- function(session = shiny::getDefaultReactiveDomain(),
                                  mode = c("toggle", "dark", "light")) {
  mode <- match.arg(mode)

  if (is.null(session)) {
    warning("wfp_toggle_dark_mode() must be called from within a Shiny server function.")
    return(invisible(NULL))
  }

  session$sendCustomMessage("wfp-set-dark-mode", list(mode = mode))
  invisible(NULL)
}
