\name{wfp.bootswatch-package}
\alias{wfp.bootswatch}
\alias{wfp.bootswatch-package}
\docType{package}
\title{WFP Bootswatch Theme for Shiny}
\description{
A complete Bootswatch theme based on the World Food Programme (WFP)
UI Kit design system for use in Shiny applications via \code{bslib}.
}
\details{
The \code{wfp.bootswatch} package provides a ready-to-use Bootstrap 5 theme
with WFP branding. It includes:

\itemize{
  \item Complete WFP color palette mapped to Bootstrap semantics
  \item Open Sans typography with Noto Sans fallback
  \item All Bootstrap 5 components styled per WFP guidelines
  \item WFP custom components (callouts, stat cards, status dots)
  \item Accessibility compliant (WCAG AA)
  \item Flat Material Design aesthetic
}

The main function is \code{\link{wfp_theme}()}, which creates a \code{bs_theme}
object that can be passed to Shiny applications. For convenience, the
\code{\link{wfpPage}()} wrapper automatically applies the theme.
}
\section{Getting Started}{
\preformatted{
library(shiny)
library(wfp.bootswatch)

# Apply WFP theme
ui <- fluidPage(
  theme = wfp_theme(),
  ...
)

# Or use the convenience wrapper
ui <- wfpPage(
  title = "My App",
  ...
)
}
}
\references{
\itemize{
  \item WFP Design System: \url{https://designsystem.wfp.org/}
  \item WFP UI Kit: \url{https://uikit.wfp.org/}
  \item Bootstrap 5: \url{https://getbootstrap.com/docs/5.3/}
  \item bslib: \url{https://rstudio.github.io/bslib/}
}
}
\author{WFP Design Team}
\keyword{package}
