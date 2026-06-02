#' WFP Color Palette
#'
#' Returns the complete WFP color palette as a named list.
#' These colors follow the WFP UI Kit design system specifications.
#'
#' @return A named list of WFP brand and UI colors.
#' @export
#' @examples
#' palette <- wfp_color_palette()
#' palette$primary
#' palette$navy
wfp_color_palette <- function() {
  list(
    # Primary brand colors
    primary      = "#007dbc",
    primary_51   = "#0085c6",
    primary_dark = "#006193",
    primary_light= "#3399cc",

    # Secondary
    secondary    = "#19486a",
    navy         = "#19486a",

    # Semantic colors
    success      = "#336d37",
    info         = "#26bde2",
    warning      = "#f7b825",
    danger       = "#c5192d",
    light        = "#f5f7fa",
    dark         = "#031c2d",

    # Extended palette
    aqua         = "#26bde2",
    dark_green   = "#336d37",
    lime         = "#8ad220",
    yellow       = "#f7b825",
    ochre        = "#d29536",
    orange       = "#fd6925",
    red          = "#c5192d",
    dark_red     = "#8d0b33",
    magenta      = "#dd1367",

    # Grays
    gray_1       = "#dfe3e6",
    gray_2       = "#f0f3f6",
    gray_3       = "#f5f7fa",
    white        = "#ffffff",

    # Text colors
    dark_text_01 = "#031c2d",
    dark_text_02 = "#415058",
    dark_text_03 = "#6f787c",

    # Light text
    light_text_01= "#ffffff",
    light_text_02= "#e3e7e8",
    light_text_03= "#b8bfc3"
  )
}


#' WFP Font Stack
#'
#' Returns the WFP font stack configuration. WFP uses Open Sans for Latin
#' characters and Noto Sans as a fallback for non-Latin scripts.
#'
#' @return A list with 'base' and 'code' font family strings.
#' @export
#' @examples
#' fonts <- wfp_font()
#' fonts$base
wfp_font <- function() {
  list(
    base = '"Open Sans", "Noto Sans", system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif',
    code = '"Source Code Pro", SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace'
  )
}
