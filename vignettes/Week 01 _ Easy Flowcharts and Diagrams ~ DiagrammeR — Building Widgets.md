Week 01 | Easy Flowcharts and Diagrams ~ DiagrammeR — Building Widgets

*   [About](http://www.buildingwidgets.com/)
*   [Blog](http://www.buildingwidgets.com/blog)

# [Building Widgets](http://www.buildingwidgets.com/)

one a week because one a month is not enough

*   [About](http://www.buildingwidgets.com/)
*   [Blog](http://www.buildingwidgets.com/blog)

# [Week 01 | Easy Flowcharts and Diagrams ~ DiagrammeR](http://www.buildingwidgets.com/blog/2015/1/8/week-01-easy-flowcharts-and-diagrams-diagrammer)

[January 08, 2015](http://www.buildingwidgets.com/blog/2015/1/8/week-01-easy-flowcharts-and-diagrams-diagrammer "Permalink")

*   [Already Cheating?](#example01already)
*   [This Week’s Widget -](#example01diagrammer) [`DiagrammeR`](https://github.com/rich-iannone/DiagrammeR)
    *   [What Does it Do?](#example01what)
    *   [Better Than Where We Found It](#example01better)
    *   [Examples in `R`](#example01examples)
    *   [Conclude and Reproduce](#example01conclude)

Unfortunately, I don't quite have the workflow from Rmd to Squarespace worked out yet, so I had to use `iframes`. For the fully interactive version, see the [GH-pages version](http://timelyportfolio.github.io/buildingwidgets/week01).

## Already Cheating?

It’s just week 1 of the Building Widgets [widget-a-week challenge](http://www.buildingwidgets.com/blog/2015/1/2/can-i-commit), and some might think I am already cheating for two reasons:

1.  This widget was started last week, and
2.  I’m not the sole author.

However, these “transgressions” will likely occur throughout the year, since many widgets will be multi-week projects, and I very much like collaborating on widgets.

## Other Widgets This Week

I expect there to be `htmlwidgets` everywhere, so I thought I could devote a small section to widgets announced each week. This week we were greeted by the very fine [`metricsgraphics`](http://rud.is/b/2015/01/08/new-r-package-metricsgraphics/).

## This Week’s Widget - [`DiagrammeR`](https://github.com/rich-iannone/DiagrammeR)

[`DiagrammeR`](https://github.com/rich-iannone/DiagrammeR) is authored by Air Quality Scientist [Richard Iannone](http://about.me/rich_i/) who has quite a record of [GitHub activity](https://github.com/rich-iannone#contributions-calendar). Thanks Richard for letting me play along. If you are asking why I am involved, [`DiagrammeR`](https://github.com/rich-iannone/DiagrammeR) didn’t start out as a [`htmlwidget`](http://htmlwidgets.org). Since I along with > 5,000 other starrers love [`mermaid.js`](https://github.com/knsv/mermaid) and the `htmlwidgets` infrastructure is so compelling, I thought [`DiagrammeR`](https://github.com/rich-iannone/DiagrammeR) would be perfect as one of the first `htmlwidgets`. For more details on the conversion, see [Widgets for Christmas](http://timelyportfolio.blogspot.com/2014/12/widgets-for-christmas.html) or for those more technically inclined inspect this [pull request](https://github.com/rich-iannone/DiagrammeR/pull/2).

### What Does it Do?

[`mermaid.js`](https://github.com/knsv/mermaid) offers easy diagrams through a markdown-like spec and leverages [`d3`](http://d3js.org) and [`dagre-d3`](https://github.com/cpettitt/dagre-d3). The `mermaid.js` [site](http://knsv.github.io/mermaid/flowchart.html) offers quite a few examples of flowcharts, experimental sequence diagrams, and other diagrams.

### Better Than Where We Found It

In many cases, development of a `htmlwidget` can often impact the JavaScript library in various ways, such as bringing attention, offering new perspective, providing new examples and tests, and applying in different contexts and fields of study. Just to insure that we didn’t just take from `mermaid.js`, we were able to file two issues with `mermaid.js` and demonstrate one way of forcing the diagram to fit in its container `div`.

### Examples in `R`

In general for all the widgets to come, I will try to create entirely new examples and put them in `R` contexts. I will also try to convert examples from documentation of popular static `R` packages.

#### Example 1 - Stylish Nodes

As basic as they come, this example shows the options for shapes of nodes and some styling with `CSS`.

```
library(DiagrammeR)

DiagrammeR("
  graph TD;
    A[rect]-- add style -->A2[rect + style];
    B{rhombus}---|+ some style|B2{rhombus + style};
    C(rounded);   D((circle)); 
    style A2 fill:#c12,stroke-width:5px;
    style B2 fill:none, stroke-dasharray:10;
")
```

#### Example 2 - Workflow of a Building Widgets Post

As I mentioned in my first blog post, I chose to build the site on [Squarespace](http://squarespace.com). Getting the workflow right will require quite a bit of iteration, but for now, here is a diagram of the workflow.

```
library(DiagrammeR)
# workflow of a post graph
DiagrammeR("
  graph TD;
    hw{htmlwidget} -->experiments;
    hw -->content;
    experiments -->RMarkdown
    content -->RMarkdown
    RMarkdown -->|R/knitr|Markdown;
    Markdown -->|Pandoc|HTML;
    HTML -->|git push| Github;
    HTML -->|copy/paste| Squarespace ;
")
```

#### Example 3 - Dependencies of [Showcase Widgets](http://htmlwidgets.org/showcase_leaflet)

We learn about some of the first `htmlwidgets` in the [showcase](http://htmlwidgets.org/showcase_leaflet). `htmlwidgets` will often depend on many of the same JavaScript libraries. Fortunately, `htmlwidgets` handles these duplicate dependencies very nicely. Let’s make a diagram of the dependencies from all of the showcase `htmlwidgets`.

```
# htmlwidgets network of yaml dependency or package imports/suggest
library(yaml)
library(DiagrammeR)

showcaseWidgets = list(
  c("leaflet","rstudio/leaflet/master/inst/htmlwidgets/leaflet.yaml")
  ,c("dygraphs","rstudio/dygraphs/master/inst/htmlwidgets/dygraphs.yaml")
  ,c("networkD3","christophergandrud/networkD3/master/inst/htmlwidgets/sankeyNetwork.yaml")
  ,c("DT","rstudio/DT/master/inst/htmlwidgets/datatables.yaml")
  ,c("rthreejs","bwlewis/rthreejs/master/inst/htmlwidgets/globe.yaml")
)

deps = lapply(
  showcaseWidgets
  ,function(w){
    y = paste0(
      "https://raw.githubusercontent.com/"
      ,w[2]
    )
    deps = yaml.load_file( y )
    data.frame(
      widget = w[1]
      ,dependency = unlist(deps)[grep(x=names(unlist(deps)),pattern=".name")]
      ,stringsAsFactors = F
    )
  }
)

deps = do.call(rbind,deps)
```

```
DiagrammeR(
  c(
    "graph LR;"
    ,sapply(
      1:nrow(deps)
      ,function(n){
        paste0(
          "id",which(unique(deps[,1])==deps[n,1]),"["
          ,deps[n,"widget"]
          ,"]-->"
          ,"id",which(unique(deps[,2])==deps[n,2])+nrow(deps),"["
          , deps[n,"dependency"]
          ,"]"
        )
      }
    )
    ,paste0(
      "style id"
      , 1:length(unique(deps[,1]))
      , " fill:"
      , RColorBrewer::brewer.pal( n = 9, "Set1")[1:length(unique(deps[,1]))]
    )
  )
)
```

#### Example 4 - `igraph`

Example 3 certainly could have benefitted from the power of `igraph` to build and manipulate the network of dependencies. Here is one way of combining `igraph` and `DiagrammeR`.

```
library(igraph)
library(pipeR)
library(DiagrammeR)

# make a simple graph
iG <- graph.formula(Sam+-Mary+-Tom++Jill)

# get the edges in a form almost ready for DiagrammeR
print( E(iG) ) %>>%
  unlist %>>%
  unname %>>%
  (
    c(
      "graph LR"
      ,paste0(gsub(x=.,pattern="(\\s)*(->)(\\s)*",replacement="-->"))
    )
  ) %>>%
  paste(collapse=";") %>>%
  DiagrammeR
```

```
## Edge sequence:
##                 
## [1] Mary -> Sam 
## [2] Tom  -> Mary
## [3] Tom  -> Jill
## [4] Jill -> Tom
```

#### Example 5 - Using `htmltools`

RStudio’s package [`htmltools`](http://github.com/rstudio/htmltools) offers all sorts of helpful tools when constructing web content. We designed `DiagrammeR` to collaborate nicely with `htmltools`. In this example, we’ll use `DiagrammeR()` with an empty spec just to inject the necessary dependencies. `tags$div(class='mermaid',...,spec,...)` will provide the diagram spec.

With `tagList` from `htmltools` we could also compose web content with multiple `DiagrammeR`s along with all the HTML & JavaScript that we know and love. The next example will illustrate this.

```
library(htmltools)
library(DiagrammeR)

tagList(
  tags$div(
    class="mermaid"
    ,"graph LR; tw[htmltools tag] --> diagram"
  )
  ,DiagrammeR()  # here just used to inject dependencies
)
```

#### Example 6 - Animated Path

I would consider this example **advanced**. Various examples on the web demonstrate `CSS` animation to make an animated `path` in `SVG`. I chose this [example](http://css-tricks.com/svg-line-animation-works) and amended it to work with our `mermaid.js` diagram. As far as I know, it is the first example of its kind.

```
library(htmltools)
# animated path example (advanced) and does not work in RStudio
dg = DiagrammeR("
  graph LR; animA[A]; style animA stroke-dasharray: 10,  animation: dash 1s linear infinite; 
")
# add a call our script makeAnimated defined in tags$script after render
dg$x$tasks = htmlwidgets::JS("makeAnimated")
tagList(
  dg
  ,tags$script(sprintf("
    function makeAnimated (el){
      // get the stylesheet and add a rule for an animated path
      var sty = document.styleSheets[4] //el.getElementsByTagName('style')[0];
      // http://davidwalsh.name/add-rules-stylesheets
      //   http://css-tricks.com/svg-line-animation-works/
      sty.insertRule('%s')
    }"
    ,HTML( ' @keyframes dash { to { stroke-dashoffset: 20;  } } ' )
  ))
)
```

#### Example 7 - Sequence Diagram

I just learned about sequence diagrams as I read through the `mermaid.js` documentation, so I apologize if this is not quite right. While we are on the topic of `htmlwidgets`, a sequence diagram might help explain the life of a `htmlwidget`.

```
library(DiagrammeR)
DiagrammeR("
  sequenceDiagram;
    participant R;
    Note left of R: Get Data<br/>Do Calculations
    htmlwidgets->>R: dependencies, binding 
    alt Static
      R->>Browser: json;
      Note right of Browser: User Interact
    else Shiny
      loop continuously in response to event
        R-->>Browser: json over socket;
        Browser-->>R: json over socket;
        Note left of R: Get Data<br/>Do Calculations
        Note right of Browser: User Interact
      end
    end
")
```

### Conclude and Reproduce

I hope you enjoyed the first installment of the widget a week project. Please, please let me know your thoughts,comments, brilliant ideas, applications, favorite JavaScript libraries.

Tags: [r](http://www.buildingwidgets.com/blog/tag/r#show-archive)

<a id="yui_3_17_2_1_1582601570310_181"></a>8 Likes

Share

[Prev](http://www.buildingwidgets.com/blog/2015/1/15/week-02-) / [Next](http://www.buildingwidgets.com/blog/2015/1/2/can-i-commit)

### Comments (0)

Newest First Subscribe via e-mail

Preview Post Comment…

## Posts By Month

* * *

*   [January 2019](http://www.buildingwidgets.com/blog?month=01-2019)
    *   [Build Your Own React-based htmlwidget](http://www.buildingwidgets.com/blog/2019/1/27/build-your-own-react-based-htmlwidget) Jan 27, 2019
*   [November 2017](http://www.buildingwidgets.com/blog?month=11-2017)
    *   [React in R](http://www.buildingwidgets.com/blog/2017/11/19/react-in-r) Nov 19, 2017
    *   [Visualizing Trees | Partition + Sankey](http://www.buildingwidgets.com/blog/2017/11/12/visualizing-trees-partition-sankey) Nov 12, 2017
*   [October 2017](http://www.buildingwidgets.com/blog?month=10-2017)
    *   [Visualizing Trees | Partition + Tree](http://www.buildingwidgets.com/blog/2017/10/28/visualizing-trees-partition-tree) Oct 28, 2017
    *   [Visualizing Trees | Sankey + Tree](http://www.buildingwidgets.com/blog/2017/10/21/visualizing-trees-sankey-tree) Oct 21, 2017
    *   [JavaScript in R Series of Posts](http://www.buildingwidgets.com/blog/2017/10/21/javascript-in-r-series-of-posts) Oct 21, 2017
*   [June 2017](http://www.buildingwidgets.com/blog?month=06-2017)
    *   [sunburstR going d3v4](http://www.buildingwidgets.com/blog/2017/6/10/sunburstr-going-d3v4) Jun 10, 2017
*   [February 2017](http://www.buildingwidgets.com/blog?month=02-2017)
    *   [Another Little Shiny Module Trick](http://www.buildingwidgets.com/blog/2017/2/9/another-little-shiny-module-trick) Feb 9, 2017
    *   [Super Simple Shiny Module Code](http://www.buildingwidgets.com/blog/2017/2/7/super-simple-shiny-module-code) Feb 7, 2017
*   [December 2016](http://www.buildingwidgets.com/blog?month=12-2016)
    *   [Break from Unpaid Open Source](http://www.buildingwidgets.com/blog/2016/12/9/bhkisodyhvttcub1mvz10fc5ow2no2) Dec 9, 2016
*   [November 2016](http://www.buildingwidgets.com/blog?month=11-2016)
    *   [d3 hierarchy as R nested tibble](http://www.buildingwidgets.com/blog/2016/11/28/d3-hierarchy-as-r-nested-tibble) Nov 28, 2016
    *   [PlotCon 2016](http://www.buildingwidgets.com/blog/2016/11/3/plotcon-2016) Nov 3, 2016
*   [September 2016](http://www.buildingwidgets.com/blog?month=09-2016)
    *   [Recursion in R](http://www.buildingwidgets.com/blog/2016/9/16/recursion-in-r) Sep 16, 2016
    *   [Custom Styling for htmlwidgets](http://www.buildingwidgets.com/blog/2016/9/7/custom-styling-for-htmlwidgets) Sep 7, 2016
*   [August 2016](http://www.buildingwidgets.com/blog?month=08-2016)
    *   [Why d3r?](http://www.buildingwidgets.com/blog/2016/8/28/why-d3r) Aug 28, 2016
    *   [htmlwidgets | Look Ma No R](http://www.buildingwidgets.com/blog/2016/8/4/htmlwidgets-look-ma-no-r) Aug 4, 2016
*   [July 2016](http://www.buildingwidgets.com/blog?month=07-2016)
    *   [Ooms Magical Polyglot World](http://www.buildingwidgets.com/blog/2016/7/25/ooms-magical-polyglot-world) Jul 25, 2016
*   [June 2016](http://www.buildingwidgets.com/blog?month=06-2016)
    *   [Mid-year Updates](http://www.buildingwidgets.com/blog/2016/6/10/mid-year-updates) Jun 10, 2016
*   [February 2016](http://www.buildingwidgets.com/blog?month=02-2016)
    *   [Who Makes the Open Source You Use?](http://www.buildingwidgets.com/blog/2016/2/28/who-makes-the-open-source-you-use) Feb 28, 2016
    *   [Time Isn't Money...](http://www.buildingwidgets.com/blog/2016/2/12/time-isnt-money) Feb 12, 2016
*   [January 2016](http://www.buildingwidgets.com/blog?month=01-2016)
    *   [End of Year Summary](http://www.buildingwidgets.com/blog/2016/1/19/end-of-year-summary) Jan 19, 2016
*   [December 2015](http://www.buildingwidgets.com/blog?month=12-2015)
    *   [Week 52 | d3kit_timeline](http://www.buildingwidgets.com/blog/2015/12/30/week-52-d3kittimeline) Dec 30, 2015
    *   [Week 51 | functionplotR](http://www.buildingwidgets.com/blog/2015/12/18/week-51-functionplotr) Dec 18, 2015
    *   [Week 50 | summarytrees_htmlwidget](http://www.buildingwidgets.com/blog/2015/12/16/week-50-summarytreeshtmlwidget) Dec 16, 2015
    *   [Week 49 | d3radarR](http://www.buildingwidgets.com/blog/2015/12/9/week-49-d3radarr) Dec 9, 2015
    *   [Week 48 | stmCorrViz](http://www.buildingwidgets.com/blog/2015/12/1/week-48-stmcorrviz) Dec 1, 2015
*   [November 2015](http://www.buildingwidgets.com/blog?month=11-2015)
    *   [Week 47 | vegaliteR](http://www.buildingwidgets.com/blog/2015/11/25/week-47-vegaliter) Nov 25, 2015
    *   [Week 46 | colaR](http://www.buildingwidgets.com/blog/2015/11/19/week-46-colar) Nov 19, 2015
    *   [Week 45 | shotsignR](http://www.buildingwidgets.com/blog/2015/11/13/week-45-shotsignr) Nov 13, 2015
    *   [Week 44 | tooltipsterR](http://www.buildingwidgets.com/blog/2015/11/6/week-44-tooltipsterr) Nov 6, 2015
*   [October 2015](http://www.buildingwidgets.com/blog?month=10-2015)
    *   [Week 43 | emoji](http://www.buildingwidgets.com/blog/2015/10/26/week-43-emoji) Oct 26, 2015
    *   [Week 42 | adjacency matrix](http://www.buildingwidgets.com/blog/2015/10/22/week-42-adjacency-matrix) Oct 22, 2015
    *   [Week 41 | railroadR](http://www.buildingwidgets.com/blog/2015/10/16/week-41-railroadr) Oct 16, 2015
    *   [Week 40 | networkD3 0.2.1 -> 0.2.4](http://www.buildingwidgets.com/blog/2015/10/8/week-40-networkd3-021-024) Oct 8, 2015
    *   [Week 39 | timelineR](http://www.buildingwidgets.com/blog/2015/10/2/week-39-timeliner) Oct 2, 2015
*   [September 2015](http://www.buildingwidgets.com/blog?month=09-2015)
    *   [Week 38 | datacomb](http://www.buildingwidgets.com/blog/2015/9/28/week-38-datacomb) Sep 28, 2015
    *   [Week 37 | parsetR](http://www.buildingwidgets.com/blog/2015/9/17/week-37-parsetr) Sep 17, 2015
    *   [Week 36 | stockchartR](http://www.buildingwidgets.com/blog/2015/9/10/week-36-stockchartr) Sep 10, 2015
    *   [Week 35 | gifrecordeR](http://www.buildingwidgets.com/blog/2015/9/5/week-35-gifrecorder) Sep 5, 2015
*   [August 2015](http://www.buildingwidgets.com/blog?month=08-2015)
    *   [Week 34 | Contributions](http://www.buildingwidgets.com/blog/2015/8/29/week-34-contributions) Aug 29, 2015
    *   [Week 33 | bioFabric_htmlwidget](http://www.buildingwidgets.com/blog/2015/8/20/week-33-biofabrichtmlwidget) Aug 20, 2015
    *   [Week 32 | mapshaperWidget](http://www.buildingwidgets.com/blog/2015/8/14/week-32-mapshaperwidget) Aug 14, 2015
    *   [Week 31 | taucharts](http://www.buildingwidgets.com/blog/2015/8/5/week-31-taucharts) Aug 5, 2015
*   [July 2015](http://www.buildingwidgets.com/blog?month=07-2015)
    *   [Week 29 | d3treeR v2](http://www.buildingwidgets.com/blog/2015/7/22/week-29-d3treer-v2) Jul 22, 2015
    *   [Week 28 | d3treeR](http://www.buildingwidgets.com/blog/2015/7/17/week-28-d3treer) Jul 17, 2015
    *   [Week 27 | d3hiveR](http://www.buildingwidgets.com/blog/2015/7/11/week-27-d3hiver) Jul 11, 2015
    *   [Week 26 | sunburstR](http://www.buildingwidgets.com/blog/2015/7/2/week-26-sunburstr) Jul 2, 2015
*   [June 2015](http://www.buildingwidgets.com/blog?month=06-2015)
    *   [Week 25 | sweetalertR](http://www.buildingwidgets.com/blog/2015/6/29/week-25-sweetalertr) Jun 29, 2015
    *   [Week 24 | flowtypeR](http://www.buildingwidgets.com/blog/2015/6/17/week-24-flowtyper) Jun 17, 2015
    *   [Week 23 | formattable](http://www.buildingwidgets.com/blog/2015/6/12/week-23-formattable) Jun 12, 2015
    *   [Week 22 | d3vennR](http://www.buildingwidgets.com/blog/2015/6/5/week-22-d3vennr) Jun 5, 2015
*   [May 2015](http://www.buildingwidgets.com/blog?month=05-2015)
    *   [Week 21 | radialNetwork](http://www.buildingwidgets.com/blog/2015/5/28/week-21-radialnetwork) May 28, 2015
    *   [Week 20 | VivaGraphJS in DiagrammeR](http://www.buildingwidgets.com/blog/2015/5/22/week-20-vivagraphjs-in-diagrammer) May 22, 2015
    *   [Week 19 | loryR slider](http://www.buildingwidgets.com/blog/2015/5/14/week-19-loryr-slider) May 14, 2015
    *   [Week 18 | ComicR](http://www.buildingwidgets.com/blog/2015/5/8/week-18-comicr) May 8, 2015
    *   [Week 17 | materializeR](http://www.buildingwidgets.com/blog/2015/5/1/week-17-materializer) May 1, 2015
*   [April 2015](http://www.buildingwidgets.com/blog?month=04-2015)
    *   [Week 16 | gamer](http://www.buildingwidgets.com/blog/2015/4/21/week-16-gamer) Apr 21, 2015
    *   [Week 15 | listviewer](http://www.buildingwidgets.com/blog/2015/4/14/week-15-listviewer) Apr 14, 2015
    *   [Week 14 | Exporting Widget](http://www.buildingwidgets.com/blog/2015/4/9/week-14-exporting-widget) Apr 9, 2015
    *   [Week 13 | Interactive stm](http://www.buildingwidgets.com/blog/2015/4/2/week-13-interactive-stm) Apr 2, 2015
*   [March 2015](http://www.buildingwidgets.com/blog?month=03-2015)
    *   [Week 12 | Intense Images](http://www.buildingwidgets.com/blog/2015/3/25/week-12-intense-images) Mar 25, 2015
    *   [Week 11| dimple as htmlwidget](http://www.buildingwidgets.com/blog/2015/3/18/week-11-dimple-as-htmlwidget) Mar 18, 2015
    *   [Week 10 | Responsive Toolbars](http://www.buildingwidgets.com/blog/2015/3/11/week-10-responsive-toolbars) Mar 11, 2015
    *   [Week 09 | sortableR Almost Anything](http://www.buildingwidgets.com/blog/2015/3/4/week-09-sortabler-almost-anything) Mar 4, 2015
*   [February 2015](http://www.buildingwidgets.com/blog?month=02-2015)
    *   [Week 08 | Interactive Phylogeny](http://www.buildingwidgets.com/blog/2015/2/26/week-08-interactive-phylogeny) Feb 26, 2015
    *   [Week 07 | R gets Bokeh](http://www.buildingwidgets.com/blog/2015/2/17/week-07-r-gets-bokeh) Feb 17, 2015
    *   [Week 06 | What Makes a Good htmlwidget](http://www.buildingwidgets.com/blog/2015/2/12/week-06-what-makes-a-good-htmlwidget) Feb 12, 2015
    *   [Week 05 | KaTeX in R](http://www.buildingwidgets.com/blog/2015/2/5/week-05-katex-in-r) Feb 5, 2015
*   [January 2015](http://www.buildingwidgets.com/blog?month=01-2015)
    *   [Week 04 | Interactive Parallel Coordinates](http://www.buildingwidgets.com/blog/2015/1/30/week-04-interactive-parallel-coordinates-1) Jan 30, 2015
    *   [Week 03 | More Network Layouts](http://www.buildingwidgets.com/blog/2015/1/23/week-03-more-network-layouts) Jan 23, 2015
    *   [Week 02 | PAN & ZOOM R PLOTS](http://www.buildingwidgets.com/blog/2015/1/15/week-02-) Jan 15, 2015
    *   [Week 01 | Easy Flowcharts and Diagrams ~ DiagrammeR](http://www.buildingwidgets.com/blog/2015/1/8/week-01-easy-flowcharts-and-diagrams-diagrammer) Jan 8, 2015
    *   [Can I Commit?](http://www.buildingwidgets.com/blog/2015/1/2/can-i-commit) Jan 2, 2015