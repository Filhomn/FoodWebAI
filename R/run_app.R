#' Run the Shiny Application
#'
#' @param api_key API key to pass to golem_opts and save in a file.
#' See `?golem::get_golem_options` for more details.
#' @inheritParams shiny::shinyApp
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(
    api_key,
    onStart = NULL,
    options = list(),
    enableBookmarking = NULL,
    uiPattern = "/",
    ...
) {
  # Write the API key to .Renviron
  renviron_path <- file.path(Sys.getenv("HOME"), ".Renviron")
  
  # Read existing .Renviron if it exists, filter out old key, append new one
  existing <- if (file.exists(renviron_path)) readLines(renviron_path) else character(0)
  existing <- existing[!grepl("^OPENAI_API_KEY=", existing)]
  writeLines(c(existing, paste0("OPENAI_API_KEY=", api_key)), renviron_path)
  
  # Reload .Renviron so the current session picks it up immediately
  readRenviron(renviron_path)

  with_golem_options(
    app = shinyApp(
      ui = app_ui,
      server = app_server,
      onStart = onStart,
      options = options,
      enableBookmarking = enableBookmarking,
      uiPattern = uiPattern
    ),
    golem_opts = list(api_key = api_key, ...)
  )
}
