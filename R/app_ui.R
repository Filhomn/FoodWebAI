#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    ui <- fluidPage(theme = shinytheme("superhero"),
                    useShinyjs(),



                    tags$head(
                      tags$style(
                        HTML("
        .shiny-notification {
          position: fixed;
          top: 50%;
          left: 50%;
          transform: translate(-50%, -50%);
          z-index: 9999;
          max-width: 500px;
          text-align: center;
          background-color: rgba(255, 255, 255, 0.9); /* Lighter background color */
          border-radius: 4px;
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Softer box shadow */
          color: #212529;
          font-family: 'Helvetica', sans-serif; /* Use Helvetica or Arial for Apple-like fonts */
          font-size: 20px;
        }

        .btn {
          background-color: #000; /* Black background for buttons */
          color: #fff;
          border-color: #000;
        }

        /* CSS for the hover effect */
        .uk-card-hover:hover {
        opacity: 0.7;
        }
          .custom-font-size {
    font-size: 30px;
          }
           .black-text {
        color: black;
      }
      .cell-color-black .htRight, .cell-color-black .htLeft, .cell-color-black .htCenter, .cell-color-black .numeric, .cell-color-black .htDimmed {
        color: black;
      }
     #editableTable2 { color: black;}
      #editableTable1 { color: black;}

      .zoom-effect {
        transition: transform 0.5s ease;
    }
    .zoom-effect:hover {
        transform: scale(1.009);
    }

    .small-btn {
    font-size: 10px; padding: 5px 10px; text-align: center;
    }

     #author1:hover {
        opacity: 1;
        }

      ")
                      )
                    ),

                    tags$style(HTML(
                      '#controls3 {background-color: #607d8b; border-width:1px; opacity: 0.7; border-radius: 10px !important; box-shadow: 0px 3px 10px rgba(0, 0, 0, 0.5);}
    #controls3:hover{opacity: 1;}'
                    )),
                    tags$style(HTML(
                      '#controls31 {background-color: #607d8b; border-width:1px; opacity: 0.7; border-radius: 10px !important; box-shadow: 0px 3px 10px rgba(0, 0, 0, 0.5);} #controls31:hover{opacity: 1;}'
                    )),



                    tags$head(tags$link(rel="stylesheet", href="https://cdn.jsdelivr.net/npm/twemoji@13.0.1/2/twemoji-awesome.css")),
                    tags$head(tags$link(rel="stylesheet", href="uikit.min.css")),
                    tags$head(tags$script(src="https://cdn.jsdelivr.net/npm/uikit@3.11.1/dist/js/uikit.min.js")),
                    tags$head(tags$link(rel = "stylesheet", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css")),




                    HTML("

  <style>
  .uk-height-large {
    position: relative;
    overflow: hidden;
  }

.uk-3d-network {
  position: absolute;
  top: 0%;
  left: 0%;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: -1;
  transform-style: preserve-3d;
}

.uk-3d-dot {
  width: 20px;
  height: 20px;
  background-color: white; /* Orange color */
    border-radius: 50%;
  position: absolute;
  animation: moveDot 40s ease-in-out infinite;
}

@keyframes moveDot {
  0%, 100% {
    transform: translate3d(var(--start-x), var(--start-y), var(--start-z));
  }
  50% {
    transform: translate3d(var(--start-x), var(--start-y), calc(var(--start-z) + 3 * 100px));
  }
}
</style>

  <script>
  document.addEventListener('DOMContentLoaded', function () {
    const canvas = document.getElementById('canvas');
    const ctx = canvas.getContext('2d');
    const colors = ['#3fb1e3', '#6be6c1', '#626c91', '#a0a7e6', '#c4ebad', '#96dee8'];
    const dots = [];

    function createRandomDot() {
  const xStart = Math.random() * canvas.width;
  const yStart = Math.random() * canvas.height;
  const zStart = Math.random() * 3; // Adjust the z value to match the keyframes (0 to 3)
  const radius = 10;
  const randomColor = colors[Math.floor(Math.random() * colors.length)];

  // Spread the dots more evenly across the screen width
  const xEnd = (xStart + canvas.width * 0.2) + Math.random() * (canvas.width * 0.6);
  const yEnd = Math.random() * canvas.height;
  const zEnd = Math.random() * 3; // Adjust the z value to match the keyframes (0 to 3)

  const dot = {
    x: xStart,
    y: yStart,
    z: zStart,
    xStart,
    yStart,
    zStart,
    xEnd,
    yEnd,
    zEnd,
    radius,
    color: randomColor,
    transitionDuration: 20000 + Math.random() * 4000, // Random transition duration between 12000ms and 17000ms
  };

  dots.push(dot);
}

    function drawLines() {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      ctx.beginPath();
      for (let i = 0; i < dots.length; i++) {
        for (let j = i + 1; j < dots.length; j++) {
          const dot1 = dots[i];
          const dot2 = dots[j];
          const dx = dot2.x - dot1.x;
          const dy = dot2.y - dot1.y;
          const distance = Math.sqrt(dx * dx + dy * dy);

          // Draw a line if the distance is less than a threshold value
          if (distance < 200) {
            ctx.moveTo(dot1.x, dot1.y);
            ctx.lineTo(dot2.x, dot2.y);
          }
        }
      }
      ctx.strokeStyle = 'white';
      ctx.lineWidth = 0.1;
      ctx.opacity = 0.9;
      ctx.stroke();

      // Draw the dots after the lines to avoid them being hidden by the lines
      for (let i = 0; i < dots.length; i++) {
        const dot = dots[i];
        ctx.beginPath();
        ctx.arc(dot.x, dot.y, dot.radius, 0, 2 * Math.PI);
        ctx.fillStyle = dot.color;
        ctx.fill();
        ctx.closePath();
      }
    }


function update() {
  // Calculate the zoom scale based on the dot's position
  const maxZoom = 2; // Adjust the maximum zoom factor as needed
  const minZoom = 1; // Adjust the minimum zoom factor as needed
  const zoomScale = minZoom + (maxZoom - minZoom) * (3 - dots[0].z) / 3;

  // Get the device pixel ratio
  const devicePixelRatio = window.devicePixelRatio || 1;

  // Adjust the canvas size based on the zoom scale and device pixel ratio
  const canvasWidth = window.innerWidth * zoomScale * devicePixelRatio;
  const canvasHeight = window.innerHeight * zoomScale * devicePixelRatio;
  canvas.width = canvasWidth;
  canvas.height = canvasHeight;

  // Scale the canvas context to match the device pixel ratio
  const ctx = canvas.getContext('2d');
  ctx.scale(devicePixelRatio, devicePixelRatio);

  for (let i = 0; i < dots.length; i++) {
    const dot = dots[i];
    dot.z = (dot.z + 0.01) % 3; // Update the z position

    // Calculate the interpolated position based on the keyframes
    const progress = (Date.now() % dot.transitionDuration) / dot.transitionDuration;
    const t = progress < 0.5 ? progress * 2 : (1 - progress) * 2;
    dot.x = lerp(dot.xStart, dot.xEnd, t);
    dot.y = lerp(dot.yStart, dot.yEnd, t);
    dot.z = lerp(dot.zStart, dot.zEnd, t);

    // Calculate the scale based on the dot's z position
    const dotScale = minZoom + (maxZoom - minZoom) * (3 - dot.z) / 3;

    // Apply the scaling to the dot's size
    dot.radius = 10 * dotScale; // You can adjust the initial dot size as needed
  }

  drawLines();

  requestAnimationFrame(update);
}



    // Helper function for linear interpolation
    function lerp(a, b, t) {
      return a + (b - a) * t;
    }

    // Set the canvas size to match the container size
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    // Create 200 random dots
    for (let i = 0; i < 100; i++) {
      createRandomDot();
    }

    // Start the animation loop
    update();
  });
</script>

  <div class='uk-height-large uk-background-cover uk-overflow-hidden uk-height-medium uk-panel uk-flex uk-flex-center uk-flex-middle uk-margin-remove' uk-parallax='bgy: -200;' style='background-image: url('norte4.png');'>
  <div class='uk-3d-network'></div>
  <div class='uk-width-1-2@m uk-text-center uk-margin-auto uk-margin-auto-vertical'>
  <canvas id='canvas' style='position: absolute; top: 0; left: 0; z-index: -1;' uk-parallax='scale: 1, 20'; image-rendering: optimizeQuality;></canvas>
  <p class='custom-font-size' uk-parallax='opacity: 0,1;start: 300%; end: 200%; y: 100,100; scale: 2,1; viewport: 0.5;color: white;'>Food Webs A.I.</p>
  </div>
  </div>

  "),


                    tags$ul(
                      class = "uk-flex-center uk-tab uk-background-default uk-margin-remove",
                      `uk-switcher`='animation: uk-animation-slide-left-medium, uk-animation-slide-right-medium',
                      tags$li(id="aqui4",class='action-button',
                              class='uk-active',
                              tags$a(id = 'aqui4',class='action-button',
                                     HTML("<p style='font-size: 14px;'>Introduction</p>"))
                      ),
                      tags$li(id = 'aqui3',class='action-button',
                              tags$a(id = 'aqui3',class='action-button',
                                     HTML("<p style='font-size: 14px;'>Food Web</p>"))
                      ),
                      tags$li(id = 'aqui5',class='action-button',
                              tags$a(id = 'aqui3',class='action-button',
                                     HTML("<p style='font-size: 14px;'>About</p>"))
                      )
                    ),

                    tags$ul(
                      class='uk-switcher uk-margin-remove',
                      tags$li(

                        tags$div(
                          class = "uk-section uk-padding-remove-bottom uk-padding-remove-top",

                          # Hero Section
                          tags$div(
                            class = "uk-height-large uk-background-cover uk-overflow-hidden uk-height-medium uk-panel uk-flex uk-flex-center uk-flex-middle uk-margin-remove",
                            tags$div(
                              class = "uk-3d-network"
                            ),
                            tags$div(
                              class = "uk-width-1-2@m uk-text-center uk-margin-auto uk-margin-auto-vertical uk-light",
                              tags$h1("Interactive Food-Webs"),
                              tags$p("Explore the intricate connections in ecosystems using interactive food webs", style = "font-size: 18px;"),
                              tags$p("Uncover the flow of energy and matter between species, and discover the hidden secrets of nature's intricate networks.", style = "font-size: 18px;"),
                              tags$p("Join us on this fascinating journey of understanding the complex world of food webs and ecosystem dynamics.", style = "font-size: 18px;")
                            )
                          ),

                          # Cards Section (Using Grid)
                          tags$div(
                            class = "uk-grid uk-child-width-1-2@s uk-child-width-1-3@m uk-margin-top uk-grid-match",
                            tags$div(
                              class = "uk-card uk-card-default uk-card-body uk-card-hover uk-card-secondary uk-background-blend-multiply uk-transition-toggle uk-margin-bottom",
                              tags$div(
                                class = "uk-icon uk-flex uk-flex-center uk-margin-bottom",
                                tags$i(class = "fas fa-globe fa-2x", style = "color: darkgray;")
                              ),
                              tags$h3("Welcome to Food Web A.I.", style = "font-size: 22px;"),
                              tags$p("In the complex world of ecosystems, understanding the interactions between different species is crucial. A food web is a powerful representation that
                   captures the intricate connections between various organisms in an ecosystem.", style = "font-size: 18px;"),
                              tags$p("The 'Food Web A.I.' web application is designed to help you explore and visualize
                   these connections using interactive and dynamic charts.", style = "font-size: 18px;")
                            ),

                            tags$div(
                              class = "uk-card uk-card-default uk-card-body uk-card-hover uk-card-secondary uk-background-blend-multiply uk-transition-toggle uk-margin-bottom",
                              tags$div(
                                class = "uk-icon uk-flex uk-flex-center uk-margin-bottom",
                                tags$i(class = "fas fa-book fa-2x", style = "color: darkgray;")
                              ),
                              tags$h3("Why study food webs?", style = "font-size: 22px;"),
                              tags$p("Food webs provide valuable insights into the flow of energy and matter within an ecosystem.
                   By analyzing the relationships between predators, prey, and other species, scientists can better
                   understand the stability and resilience of ecosystems.", style = "font-size: 18px;")
                            ),

                            tags$div(
                              class = "uk-card uk-card-default uk-card-body uk-card-hover uk-card-secondary uk-background-blend-multiply uk-transition-toggle uk-margin-bottom",
                              tags$div(
                                class = "uk-icon uk-flex uk-flex-center uk-margin-bottom",
                                tags$i(class = "fas fa-robot fa-2x", style = "color: darkgray;")
                              ),
                              tags$h3("Using A.I. for Deeper Insights", style = "font-size: 22px;"),
                              tags$p("Take your analysis to the next level with the power of Artificial Intelligence!
                   The 'Food Web A.I.' app employs advanced A.I. algorithms to extract valuable
                   insights from your uploaded data.", style = "font-size: 18px;"),
                              tags$p("Leveraging A.I. technology, you can gain a deeper understanding of ecosystem
                   structures, trophic interactions, and even predict potential impacts of environmental
                   changes on food webs.", style = "font-size: 18px;")
                            )
                          ),
                          br(),
                          br(),
                          br(),

                          # Call-to-Action Card
                          tags$div(
                            class = "uk-card uk-card-default uk-card-body uk-card-hover uk-background-blend-multiply uk-opacity-80 uk-transition-toggle",
                            style = "background-color: darkblue; color: white;",
                            tags$p("Join us on this ecosystem exploration!"),
                            tags$p("Click on the 'Food Web' tab to upload your data and begin visualizing the complex interactions between species. Feel free to experiment with different settings and uncover hidden patterns in ecosystems."),
                            tags$p("Let's embark on a journey to discover the hidden secrets of nature's food webs together!")
                          )
                        ),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br()

                      ),

                      tags$li(
                        conditionalPanel(condition="input.aqui3>0",


                                         absolutePanel(
                                           id = "controls31",
                                           class = "panel panel-default",
                                           fixed = FALSE,
                                           draggable = TRUE,
                                           top = 510,
                                           left = 'auto',
                                           right = "2%",
                                           bottom = "auto",
                                           width = "50%",
                                           height = "auto",
                                           style = "z-index: 1000; padding: 10px 10px 10px 10px; display:none;",
                                           tags$div(id = 'close_1',
                                                    class = "action-button",
                                                    shiny::icon("circle-xmark", style = "float: right;")),
                                           br(),
                                           div(style="display: inline-block;vertical-align:top; width: 300px;",
                                               tags$div(
                                                 class = "uk-card uk-card-default uk-card-body zoom-effect",
                                                 style = "margin: 0px; padding: 10px; border-radius: 10px !important; box-shadow: 0px 3px 10px rgba(0, 0, 0, 0.5);",
                                                 HTML("<center><p style = font-size: 30px; color: white;>Connectance</p></center>"),
                                                 echarts4rOutput('text1'))),
                                           div(style="display: inline-block;vertical-align:top;",br()),
                                           div(style="display: inline-block;vertical-align:top; width: 300px;",
                                               tags$div(
                                                 class = "uk-card uk-card-default uk-card-body zoom-effect",
                                                 style = "margin: 0px; padding: 10px; border-radius: 10px !important; box-shadow: 0px 3px 10px rgba(0, 0, 0, 0.5);",

                                                 HTML("<center><p style = font-size: 30px; color: white;>Energy transfer per Trophic level</p></center>"),
                                                 echarts4rOutput('text2')))

                                         ),



                                         absolutePanel(
                                           id = "controls3",
                                           class = "panel panel-default",
                                           fixed = FALSE,
                                           draggable = TRUE,
                                           top = 510,
                                           left = '2%',
                                           right = "auto",
                                           bottom = "auto",
                                           width = "auto",
                                           height = "auto",
                                           style = "z-index: 1000; padding: 10px 10px 10px 10px;",



                                           tags$div(
                                             class = "uk-card uk-card-default uk-card-body",
                                             style = "margin: 0px; padding: 10px;",
                                             actionButton(inputId = "help1",
                                                          label = NULL,
                                                          icon = shiny::icon("circle-question", style = "color:black;"),
                                                          style = "float: right; margin: 0px; padding: 0px; background-color: transparent; border:none;"),
                                             br(),
                                             tags$div(
                                               onclick = "toggleCollapse()",
                                               tags$h3(
                                                 class = "uk-card-title",
                                                 HTML('<b>First - Data type:</b>'),
                                                 shiny::icon("caret-down", style = "float: right;")
                                               )
                                             ),
                                             HTML('<hr>'),

                                             div(id = "collapseDiv", style = "display: block;",
                                                 p(
                                                   HTML('Choose the data format<br> you wish to upload.'),
                                                   class = 'uk-text-large uk-text-center', style = 'font-size: 16px; color: black; font-family: "Times New Roman", Times, serif; font-weight: normal;'
                                                 ),
                                                 HTML('<hr>'),# Changed "none" to "block"
                                                 selectInput('ch5', "Data input format", choices = c('', 'Manual' = 'Free', 'A.I. FoodWeb' = "Generative Chart", 'Regular', 'Ecopath'))
                                             )
                                           ),


                                           tags$script(
                                             'document.getElementById("ch5").onchange = function() {
  var x = document.getElementById("collapseDiv");
  x.style.display = "none";
};
function toggleCollapse() {
  var x = document.getElementById("collapseDiv");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
'),





                                           conditionalPanel(condition = "input.ch5 == 'Ecopath' || input.ch5 == 'Regular'",
                                                            br(),


                                                            tags$div(class="uk-card uk-card-default uk-card-body",
                                                                     style="margin: 0px; padding: 10px;",
                                                                     actionButton(inputId = "help2",
                                                                                  label = NULL,
                                                                                  icon = shiny::icon("circle-question", style = "color:black;"),
                                                                                  style = "float: right; margin: 0px; padding: 0px; background-color: transparent; border:none;"),
                                                                     br(),
                                                                     tags$div(
                                                                       onclick = "toggleCollapse2()",


                                                                       tags$h3(class="uk-card-title", HTML('<b>Second -  Upload Files<b>'),shiny::icon("caret-down", style = "float: right;")),
                                                                       HTML('<hr>')),
                                                                     tags$div(id = "collapseDiv2",
                                                                              conditionalPanel(condition = "input.ch5 == 'Ecopath'",
                                                                                               p(
                                                                                                 HTML('Export from Ecopath the csv files:<br><b>Basic Estimates</b> and <b>Consumption</b>.<br> Upload them below:'),
                                                                                                 class = 'uk-text-large uk-text-center', style = 'font-size: 16px; color: black; font-family: "Times New Roman", Times, serif; font-weight: normal;'
                                                                                               )),
                                                                              conditionalPanel(condition = "input.ch5 == 'Regular'",
                                                                                               p(
                                                                                                 HTML('Upload the csv files:<br><b>Basic Estimates</b> and <b>Consumption</b>.<br>'),
                                                                                                 class = 'uk-text-large uk-text-center', style = 'font-size: 16px; color: black; font-family: "Times New Roman", Times, serif; font-weight: normal;'
                                                                                               ),
                                                                                               div(class = "uk-flex uk-flex-center",

                                                                                                   downloadButton("downloadZipBtn", "Download Example", class = "small-btn"))



                                                                              ),
                                                                              HTML('<hr>'),
                                                                              conditionalPanel(condition = "input.ch5 == 'Ecopath'",
                                                                                               fileInput("file1", "Upload Ecopath Basic_estimates csv file"),
                                                                                               fileInput("file2", "Upload Ecopath Consumption csv file")),
                                                                              conditionalPanel(condition = "input.ch5 == 'Regular'",
                                                                                               fileInput("file1R", "Upload Basic_estimates csv file"),
                                                                                               fileInput("file2R", "Upload Consumption csv file"))


                                                                     )),

                                                            tags$script(
                                                              'document.getElementById("file2").onchange = function() {
  var x = document.getElementById("collapseDiv2");
  x.style.display = "none";
};
function toggleCollapse2() {
  var x = document.getElementById("collapseDiv2");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
'),


                                                            conditionalPanel(
                                                              condition = "output.filesUploaded",
                                                              br(),
                                                              tags$div(class="uk-card uk-card-default uk-card-body",
                                                                       style="margin: 0px; padding: 10px;",

                                                                       br(),
                                                                       tags$div(
                                                                         onclick = "toggleCollapse3()",
                                                                         tags$h3(class="uk-card-title", HTML('<b>Third - Adjust Chart</b>'),shiny::icon("caret-down", style = "float: right;")),
                                                                         HTML("<hr>")),
                                                                       tags$div(id = "collapseDiv3",
                                                                                p(
                                                                                  HTML('Choose the type of chart; theme;<br> node format and size;<br> and font-size'),
                                                                                  class = 'uk-text-large uk-text-center', style = 'font-size: 16px; color: black; font-family: "Times New Roman", Times, serif; font-weight: normal;'
                                                                                ),
                                                                                HTML("<hr>"),
                                                                                selectInput('ch6',"Choose the Chart Type", choices = c('FoodWeb'='none','Circular'='circular', 'Force'='force')),

                                                                                selectInput('ch2',"Choose the chart Theme", choices = c('dark','vintage', 'chalk','dark-blue','dark-bold','dark-digerati','dark-fresh-cut',
                                                                                                                                        'dark-mushroom','halloween', 'purple-passion',
                                                                                                                                        'walden','wef','weforum','westeros','wonderland')),
                                                                                selectInput('ch3',"Nodes Format", choices = c("circle", "square",'roundRect','pin','triangle','Icons', 'Emoji')),
                                                                                sliderInput('ch4','Node Size',min=0, max=3, step=0.1, value=2),
                                                                                sliderInput('fontsize','Font-Size',min=3, max=30, step=1, value=8),
                                                                                sliderInput('ch20','Zoom',min=0, max=2, step=0.2, value=0),
                                                                                actionButton('ch21', 'Show Indexes'),


                                                                                HTML("<hr>"),
                                                                                p(
                                                                                  HTML('Update the FoodWeb with A.I. generated groups.<br>
                                  Only <b>Trophic Position</b> is not A.I generated.'),
                                                                                  class = 'uk-text-large uk-text-center', style = 'font-size: 16px; color: black; font-family: "Times New Roman", Times, serif; font-weight: normal;'
                                                                                ),
                                                                                p(
                                                                                  HTML('<b>Caution: AI-generated results may contain uncertainties.<br>
                                  Verify and cross-check the data<br>
                                  before making critical decisions.</b>'),
                                                                                  class = 'uk-text-large uk-text-center', style = 'font-size: 12px; color: red; font-family: "Times New Roman", Times, serif; font-weight: normal;'
                                                                                ),
                                                                                HTML("<hr>"),

                                                                                selectInput('ch1',"Categories", choices = c("Trophic Position", "Groups",
                                                                                                                            'Nocturnal or Diurnal',
                                                                                                                            'Niche and Habitat (Ocean)',
                                                                                                                            'Niche and Habitat (River)',
                                                                                                                            'Migration Patterns',
                                                                                                                            'Conservation Status')),
                                                                                br()
                                                                       ))),
                                                            tags$script('function toggleCollapse3() {
  var x = document.getElementById("collapseDiv3");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
'),


                                                            conditionalPanel(
                                                              condition = "output.filesUploaded",
                                                              br(),
                                                              tags$div(class="uk-card uk-card-default uk-card-body",
                                                                       style="margin: 0px; padding: 10px; overflow-y: auto;",

                                                                       br(),
                                                                       tags$div(id = 'fourth', class = 'action-button',
                                                                                onclick = "toggleCollapse3_1()",
                                                                                tags$h3(class="uk-card-title", HTML('<b>Fourth - Look and Review your data:</b>'),shiny::icon("caret-down", style = "float: right;")),
                                                                                HTML("<hr>")),
                                                                       conditionalPanel(condition = 'input.fourth > 0',
                                                                                        tags$div(id = "collapseDiv3_1",
                                                                                                 style="display: none;",
                                                                                                 tags$div(
                                                                                                   class = "uk-container",
                                                                                                   tags$div(
                                                                                                     class = "uk-grid",
                                                                                                     tags$div(class="uk-width-1-2",
                                                                                                              tags$h3(HTML('<center><b>Basic Estimates</b></center>')),
                                                                                                              rHandsontableOutput("editableTable3")
                                                                                                     ),
                                                                                                     tags$div(class="uk-width-1-2",
                                                                                                              tags$h3(HTML('<center><b>Consumption</b></center>')),
                                                                                                              rHandsontableOutput("editableTable4")
                                                                                                     )
                                                                                                   ),

                                                                                                 )))

                                                              )),
                                                            tags$script('function toggleCollapse3_1() {
  var x = document.getElementById("collapseDiv3_1");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
'),


                                           ),
                                           conditionalPanel(condition = "input.ch5 == 'Free'",
                                                            br(),
                                                            tags$div(class="uk-card uk-card-default uk-card-body",
                                                                     style="margin: 0px; padding: 10px; overflow-y: auto;",
                                                                     actionButton(inputId = "help3",
                                                                                  label = NULL,
                                                                                  icon = shiny::icon("circle-question", style = "color:black;"),
                                                                                  style = "float: right; margin: 0px; padding: 0px; background-color: transparent; border:none;"),
                                                                     br(),
                                                                     tags$div(
                                                                       onclick = "toggleCollapse4()",
                                                                       tags$h3(class="uk-card-title", HTML('<b>Second - Fill the table below:</b>'),shiny::icon("caret-down", style = "float: right;")),
                                                                       HTML("<hr>")),
                                                                     tags$div(id = "collapseDiv4",
                                                                              tags$div(
                                                                                class = "uk-container",
                                                                                tags$div(
                                                                                  class = "uk-grid",
                                                                                  tags$div(class="uk-width-1-2",
                                                                                           tags$h3(HTML('<center><b>Basic Estimates</b></center>')),
                                                                                           rHandsontableOutput("editableTable1")
                                                                                  ),
                                                                                  tags$div(class="uk-width-1-2",
                                                                                           tags$h3(HTML('<center><b>Consumption</b></center>')),
                                                                                           rHandsontableOutput("editableTable2")
                                                                                  )
                                                                                ),
                                                                                tags$div(
                                                                                  class = "uk-grid",
                                                                                  tags$div(
                                                                                    class = "uk-width-1-2 uk-flex uk-flex-center",
                                                                                    actionButton("addRowBtn1", "Add Row (Table 1)")
                                                                                  ),
                                                                                  tags$div(
                                                                                    class = "uk-width-1-2 uk-flex uk-flex-center",
                                                                                    actionButton("addRowBtn2", "Add Row (Table 2)")
                                                                                  )
                                                                                )
                                                                              ))),
                                                            tags$script('function toggleCollapse4() {
  var x = document.getElementById("collapseDiv4");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
'),


                                                            br(),
                                                            tags$div(class="uk-card uk-card-default uk-card-body",
                                                                     style="margin: 0px; padding: 10px;",
                                                                     tags$div(
                                                                       onclick = "toggleCollapse5()",
                                                                       tags$h3(class="uk-card-title", HTML('<b>Third - Adjust Chart</b>'),shiny::icon("caret-down", style = "float: right;")),
                                                                       HTML("<hr>")),
                                                                     tags$div(id = "collapseDiv5",
                                                                              selectInput('ch7',"Choose the Chart Type", choices = c('FoodWeb'='none','Circular'='circular', 'Force'='force')),

                                                                              selectInput('ch8',"Choose the chart Theme", choices = c('dark','vintage', 'chalk','dark-blue','dark-bold','dark-digerati','dark-fresh-cut',
                                                                                                                                      'dark-mushroom','halloween', 'purple-passion',
                                                                                                                                      'walden','wef','weforum','westeros','wonderland')),
                                                                              selectInput('ch9',"Nodes Format", choices = c("circle", "square",'roundRect','pin','triangle')),
                                                                              sliderInput('ch10','Node Size',min=0, max=3, step=0.1, value=2),
                                                                              sliderInput('fontsize2','Font-Size',min=3, max=30, step=1, value=8))),
                                                            tags$script('function toggleCollapse5() {
  var x = document.getElementById("collapseDiv5");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
')


                                           ),
                                           conditionalPanel(condition = "input.ch5 == 'Generative Chart'",
                                                            br(),
                                                            tags$div(class="uk-card uk-card-default uk-card-body",
                                                                     style="margin: 0px; padding: 10px;",
                                                                     actionButton(inputId = "help4",
                                                                                  label = NULL,
                                                                                  icon = shiny::icon("circle-question", style = "color:black;"),
                                                                                  style = "float: right; margin: 0px; padding: 0px; background-color: transparent; border:none;"),
                                                                     br(),
                                                                     tags$div(
                                                                       onclick = "toggleCollapse6()",


                                                                       tags$h3(class="uk-card-title", HTML('<b>Second -  Upload Files<b>'),shiny::icon("caret-down", style = "float: right;")),
                                                                       HTML('<hr>')),
                                                                     tags$div(id = "collapseDiv6",

                                                                              p(
                                                                                HTML('Upload the csv file with a <b>species</b> list.<br>'),
                                                                                class = 'uk-text-large uk-text-center', style = 'font-size: 16px; color: black; font-family: "Times New Roman", Times, serif; font-weight: normal;'
                                                                              ),
                                                                              div(class = "uk-flex uk-flex-center",

                                                                                  downloadButton("downloadZipBtn2", "Download Example", class = "small-btn")),

                                                                              HTML('<hr>'),

                                                                              fileInput("file1_1", "Upload the species list csv file"))),


                                                            tags$script(
                                                              'document.getElementById("file2").onchange = function() {
  var x = document.getElementById("collapseDiv6");
  x.style.display = "none";
};
function toggleCollapse6() {
  var x = document.getElementById("collapseDiv6");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
'),
                                                            br(),
                                                            conditionalPanel(
                                                              condition = "output.filesUploaded2",
                                                              tags$div(class="uk-card uk-card-default uk-card-body",
                                                                       style="margin: 0px; padding: 10px;",
                                                                       tags$div(
                                                                         onclick = "toggleCollapse7()",
                                                                         tags$h3(class="uk-card-title", HTML('<b>Third - Adjust Chart</b>'),shiny::icon("caret-down", style = "float: right;")),
                                                                         HTML("<hr>")),
                                                                       tags$div(id = "collapseDiv7",
                                                                                selectInput('ch7_1',"Choose the Chart Type", choices = c('FoodWeb'='none','Circular'='circular', 'Force'='force')),

                                                                                selectInput('ch8_1',"Choose the chart Theme", choices = c('dark','vintage', 'chalk','dark-blue','dark-bold','dark-digerati','dark-fresh-cut',
                                                                                                                                          'dark-mushroom','halloween', 'purple-passion',
                                                                                                                                          'walden','wef','weforum','westeros','wonderland')),
                                                                                selectInput('ch9_1',"Nodes Format", choices = c("circle", "square",'roundRect','pin','triangle')),
                                                                                sliderInput('ch10_1','Node Size',min=0, max=3, step=0.1, value=0.6),
                                                                                sliderInput('fontsize3','Font-Size',min=3, max=30, step=1, value=8),
                                                                                sliderInput('ch20_1','Zoom',min=0, max=3, step=0.2, value=2),
                                                                       ))),
                                                            tags$script('function toggleCollapse7() {
  var x = document.getElementById("collapseDiv7");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
'),


                                                            conditionalPanel(
                                                              condition = "output.filesUploaded2",
                                                              br(),
                                                              tags$div(class="uk-card uk-card-default uk-card-body",
                                                                       style="margin: 0px; padding: 10px; overflow-y: auto;",
                                                                       shiny::icon("circle-question", style = "float: right;"),
                                                                       br(),
                                                                       tags$div(id = 'fourth2', class = 'action-button',
                                                                                onclick = "toggleCollapse4_1()",
                                                                                tags$h3(class="uk-card-title", HTML('<b>Fourth - Look and Review your data:</b>'),shiny::icon("caret-down", style = "float: right;")),
                                                                                HTML("<hr>")),
                                                                       conditionalPanel(condition = 'input.fourth2 > 0',
                                                                                        tags$div(id = "collapseDiv4_1",
                                                                                                 style="display: none;",
                                                                                                 tags$div(
                                                                                                   class = "uk-container",
                                                                                                   tags$div(
                                                                                                     class = "uk-grid",
                                                                                                     tags$div(class="uk-width-1-2",
                                                                                                              tags$h3(HTML('<center><b>Basic Estimates</b></center>')),
                                                                                                              rHandsontableOutput("editableTable5")
                                                                                                     ),
                                                                                                     tags$div(class="uk-width-1-2",
                                                                                                              tags$h3(HTML('<center><b>Consumption</b></center>')),
                                                                                                              rHandsontableOutput("editableTable6")
                                                                                                     )
                                                                                                   ),

                                                                                                 )))

                                                              )),
                                                            tags$script('function toggleCollapse4_1() {
  var x = document.getElementById("collapseDiv4_1");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
')




                                                            ###


                                           )
                                         ),
                                         hidden(absolutePanel(
                                           id = "help1_panel",
                                           class = "panel panel-default",
                                           fixed = FALSE,
                                           draggable = TRUE,
                                           top = 510,
                                           left = 'auto',
                                           right = "20%",
                                           bottom = "auto",
                                           width = "50%",
                                           height = "auto",
                                           style = "z-index: 1000; padding: 10px 10px 10px 10px; display:none;",

                                           tags$div(
                                             class = "uk-card uk-card-default uk-card-body",
                                             style = "margin: 0px; padding: 20px;font-weight: normal; color: black;",
                                             actionButton(inputId = "help1_1",
                                                          label = NULL,
                                                          icon = shiny::icon("xmark", style = "color:black;"),
                                                          style = "float: right; margin: 0px; padding: 0px; background-color: transparent; border:none;"),

                                             HTML("
  <p style='font-size: 18px; color: black;'><b>Help Menu</b></p><br>
<p>The app allows users to work with four types of data:</p>
<ul>
  <li><b>Manual:</b> This option enables users to directly create a food web within the app.</li>
  <li><b>FoodWebAI:</b> Users can generate a food web by providing a list of species, utilizing Artificial Intelligence.</li>
  <li><b>Regular:</b> This feature enables users to create a food web using CSV files in a custom format within the app.</li>
  <li><b>Ecopath:</b> Users can import CSV files exported from Ecopath software to create a food web.</li>
</ul>



    "))

                                         )),
                                         hidden(absolutePanel(
                                           id = "help2_panel",
                                           class = "panel panel-default",
                                           fixed = FALSE,
                                           draggable = TRUE,
                                           top = 510,
                                           left = 'auto',
                                           right = "20%",
                                           bottom = "auto",
                                           width = "50%",
                                           height = "auto",
                                           style = "z-index: 1000; padding: 10px 10px 10px 10px; display:none;",

                                           tags$div(
                                             class = "uk-card uk-card-default uk-card-body",
                                             style = "margin: 0px; padding: 20px;font-weight: normal; color: black;",
                                             actionButton(inputId = "help2_2",
                                                          label = NULL,
                                                          icon = shiny::icon("xmark", style = "color:black;"),
                                                          style = "float: right; margin: 0px; padding: 0px; background-color: transparent; border:none;"),
                                             conditionalPanel(condition = "input.ch5 == 'Ecopath'",
                                                              HTML("
 <div style='font-size: 18px; color: black; text-align: center;'><b>Help Menu</b></div><br>
<div style='text-align: justify; margin: 0 auto; max-width: 600px;'>
    <p>In the Ecopath module, the app works with two tables exported directly from the program: basic estimates (Figure A-1) and consumption (Figure B-1). These tables can be exported in CSV format by clicking on the top-right button highlighted in red (Figure A-2 and B-2).</p>

    <div style='text-align: center;'>
        <p style='font-weight: bold; margin-bottom: 5px;'>Figure A: Exporting the Basic Estimates table from Ecopath software</p>
        <img src='assets/IMG_1367.jpeg' alt='Basic Estimates' style='max-width: 100%; border-radius: 5px;'>
    </div>

    <div style='text-align: center; margin-top: 20px;'>
        <p style='font-weight: bold; margin-bottom: 5px;'>Figure B: Exporting the consumption table from Ecopath software</p>
        <img src='assets/IMG_1368.jpeg' alt='Consumption' style='max-width: 100%; border-radius: 5px;'>
    </div>
</div>
    ")),

                                             conditionalPanel(condition = "input.ch5 == 'Regular'",
                                                              HTML("

         <div style='font-size: 18px; color: black; text-align: center;'><b>Help Menu</b></div><br>
<div style='text-align: justify; margin: 0 auto; max-width: 600px;'>
    <p>In the Custom Format module, users can create both tables directly in Excel and export them to CSV format. The tables include basic estimates (Figure A-1) and consumption (Figure B-1).</p>

    <div style='text-align: center;'>
        <p style='font-weight: bold; margin-bottom: 5px;'>Figure A: Exporting the Basic Estimates table from Excel</p>
        <img src='assets/IMG_1361.jpeg' alt='Basic Estimates' style='width:200px;height:300px; border-radius: 5px;'>
    </div>

    <div style='text-align: center; margin-top: 20px;'>
        <p style='font-weight: bold; margin-bottom: 5px;'>Figure B: Exporting the consumption table from Excel</p>
        <img src='assets/IMG_1362.jpeg' alt='Consumption' style='width:200px;height:300px; border-radius: 5px;'>
    </div>
</div>


    ")),

                                             conditionalPanel(condition = "input.ch5 == 'Generative Chart'",
                                                              HTML("

       <div style='font-size: 18px; color: black; text-align: center;'><b>Help Menu</b></div><br>
<div style='text-align: justify; margin: 0 auto; max-width: 600px;'>
    <p>In the A.I. Foodweb module, users can input a single file containing a list of species and generate a food web chart. This module streamlines the process of creating food webs, offering a convenient solution for users.</p>

    <div style='text-align: center;'>
        <p style='font-weight: bold; margin-bottom: 5px;'>Figure A: Example input file for the A.I. Foodweb module</p>
        <img src='assets/IMG_1369.jpeg' alt='Input File Example' style='width:200px; height:600px; border-radius: 5px;'>
    </div>

</div>


    ")),

                                             conditionalPanel(condition = "input.ch5 == 'Free'",
                                                              HTML("

       <div style='font-size: 18px; color: black; text-align: center;'><b>Help Menu</b></div><br>
<div style='text-align: justify; margin: 0 auto; max-width: 600px;'>
    <p>In the Manual module, users can directly create the food web within the app interface. This module provides an intuitive and user-friendly way to design and visualize food webs without the need for external files.</p>


</div>


    "))




                                           )

                                         )),


                                         conditionalPanel(condition = "input.ch5 == 'Ecopath'",
                                                          uiOutput('ui1')),
                                         conditionalPanel(condition = "input.ch5 == 'Regular'",
                                                          uiOutput('ui1R')),
                                         conditionalPanel(condition = "input.ch5 == 'Free'",
                                                          uiOutput('ui2')),
                                         conditionalPanel(condition = "input.ch5 == 'Generative Chart'",
                                                          uiOutput('ui3')),
                                         br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
                                         br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
                                         br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
                                         br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
                                         br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
                                         br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
                                         br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
                                         br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
                                         br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
                                         br(),







                        )),
                      tags$li(

                       br()


                      )

                    )





    )

  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )
  add_resource_path(
    'assets', app_sys('app/www/assets')
  )
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "FoodwebAI"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
