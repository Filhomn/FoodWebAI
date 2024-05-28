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
  # Write the api_key to a file
  writeLines(api_key, "Key.txt")
  gpt3_authenticate("Key.txt")

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
