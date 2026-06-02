#' WFP-themed Shiny Page
#'
#' A convenience wrapper around \code{shiny::fluidPage()} that automatically
#' applies the WFP Bootswatch theme. All arguments are passed through to
#' \code{fluidPage()} except \code{theme} which is set to \code{wfp_theme()}.
#'
#' @param ... Elements to include within the page. Passed to \code{fluidPage()}.
#' @param title The browser window title. Default: \code{NULL}.
#' @param theme A \code{bs_theme} object. Default: \code{wfp_theme()}.
#' @param lang HTML language code. Default: \code{"en"}.
#' @param window_title Deprecated, use \code{title} instead.
#'
#' @return A Shiny UI definition.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' library(shiny)
#' library(wfp.bootswatch)
#'
#' ui <- wfpPage(
#'   title = "My WFP App",
#'   h1("Welcome"),
#'   p("This app uses the WFP theme."),
#'   actionButton("go", "Get Started", class = "btn-primary")
#' )
#'
#' server <- function(input, output) {}
#' shinyApp(ui, server)
#' }
wfpPage <- function(
    ...,
    title = NULL,
    theme = wfp_theme(),
    lang = "en",
    window_title = deprecated()
) {
  if (is_present(window_title)) {
    deprecate_warn("0.1.0", "wfpPage(window_title = )", "wfpPage(title = )")
    title <- window_title
  }

  shiny::fluidPage(
    title = title,
    theme = theme,
    lang = lang,
    ...
  )
}


#' Check if Deprecated Argument is Present
#'
#' Internal helper for deprecation warnings.
#'
#' @param x Argument to check.
#' @keywords internal
is_present <- function(x) {
  !missing(x)
}

#' Issue Deprecation Warning
#'
#' Internal helper for deprecation warnings.
#'
#' @param version Package version when deprecation occurred.
#' @param what Name of deprecated feature.
#' @param with Replacement feature name.
#' @keywords internal
deprecate_warn <- function(version, what, with) {
  warning(
    sprintf("%s was deprecated in wfp.bootswatch %s.\nPlease use %s instead.",
            what, version, with),
    call. = FALSE
  )
}
