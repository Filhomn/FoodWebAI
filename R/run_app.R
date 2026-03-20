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
  with_golem_options(
    app = shinyApp(
      ui = app_ui,
      server = app_server,
      onStart = function() {
        # This fires ONCE before any session starts
        Sys.setenv(OPENAI_API_KEY = api_key)
        message("Key set in onStart: ", nchar(Sys.getenv("OPENAI_API_KEY")) > 0)
      },
      options = options,
      enableBookmarking = enableBookmarking,
      uiPattern = uiPattern
    ),
    golem_opts = list(api_key = api_key, ...)
  )
}
