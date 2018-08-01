# earl18-crosstalk

## Summary

This repo contains code for some materials I used in a presentation at the [EARL (Enterprise Applications of the R Language) conference](https://earlconf.com/2018/london/) in London on 12 September 2018.

The presentation was about use of [the `crosstalk` package](http://rstudio.github.io/crosstalk/) to help solve a business problem. You can [view the presentation in your browser](https://matt-dray.github.io/earl18-presentation/).

Note that this talk was restricted to **published data only** and the content of this talk **does not reflect or constitute official government policy**.

## This repo

The talk demonstrated a four-step process in the development of an interactive map tool. Example code is hosted in this repo and the html outputs are viewable in-browser. The steps are shown below (click to be taken to the example):

1. [Leaflet](https://matt-dray.github.io/earl18-crosstalk/01_leaflet.html)
2. [Leaflet + Flexdashboard](https://matt-dray.github.io/earl18-crosstalk/02_leaflet-flexdash.html)
3. [Leaflet + Flexdashboard + DT](https://matt-dray.github.io/earl18-crosstalk/03_leaflet-flexdash-dt.html)
4. [Leaflet + Flexdashboard + DT + Crosstalk](https://matt-dray.github.io/earl18-crosstalk/04_leaflet-flexdash-dt-crosstalk.html)

## Blurb

>Crosstalk: Shiny-like without Shiny
>
>Self-service interactive tools have great power to support decisions by policy-makers. Shiny apps are a natural fit for this, but it's not always easy to share them within the public sector. This is due to issues like a lack of server space, highly sensitive data and users who aren't R-savvy. 
>
>We've approached this problem in the UK's Department for Education by sharing interactive HTML widgets – embeddable JavaScript visualisation libraries – within RMarkdown outputs. Interactivity is, however, limited because selections in one widget don’t impact the data presented in another. 
>
>Joe Cheng's Crosstalk package (http://rstudio.github.io/crosstalk/) overcomes this with shared data objects that react to user inputs, altering the content of multiple widgets on the fly. I'll explain how I used Crosstalk to develop a 'pseudo-app' for exploring schools data with the Leaflet (maps), Plotly (charts) and DT (tables) widgets inside the Flexdashboard framework and how I shared it easily with policy-making users as a static HTML file for exploration in the browser.