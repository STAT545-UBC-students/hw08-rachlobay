# STAT 547 HW08 Creation of Diamonds App

## Table of Contents
- [What is the app and what data are we using?](#what-is-the-app-and-what-data-are-we-using)
- [Important links](#important-links)
- [Features of the app](#features-of-the-app)
    + [Histogram and table of diamonds data](#histogram-and-table-of-diamonds-data)
    + [Summary of Price by Cut](#summary-of-price-by-cut)
    + [Plotly scatterplot of the sample carat vs price](#plotly-scatterplot-of-the-sample-carat-vs-price)

## What is the app and what data are we using?

The aim of this app is to use graphs, interactive tables and widgits to sort and display the diamonds data. 

For my app, I used the diamonds dataset, which comes with the ggplot2 package. So, we get this data set when we load the tidyverse package. 

## Important links

**Here is a link to the app since it is deployed online at shinyapps.io:**
[https://rach21ubc.shinyapps.io/diamonds-app/](https://rach21ubc.shinyapps.io/diamonds-app/). 

Note that the app runs slower than I would like online. But, it still runs :smile:

**Here is a link to the app code that was uploaded to Github:**

https://github.com/STAT545-UBC-students/hw08-rachlobay/blob/master/Diamonds-app/app.R

## Features of the app

What can the app do?

### Histogram and table of diamonds data

Like with the BCL app example, I have a price histogram where the user can select the desired price range for the diamonds. I set the initial range to be quite low (2000 - 4000 dollars) because I don't know of many people who have a lot of k to spend on diamonds. The user may also change the cut of the diamonds that the histogram displays the price for. The default cut is Good, but the user can select any of the five options and the histogram will be recreated to reflect that change. Note that any change to the price range or the cut of the diamonds in the left sidebar will be reflected in the Table of Diamonds Data. Also, note that the histogram has a black line indicating the mean price. The mean changes when you change the price range or the cut of the diamonds. The user can select the colour of the histogram by clicking on the colour panel in the top left corner of the main screen and choosing any colour they wish. 

The table of the diamonds data is interactive as I chose to use the DT package to turn the results into an interactive table. There are many features to this interactivity. For example, the user may choose to show 10, 25, 50 or 100 entries in the table. The user may search for a particular entry in the table (ex. the user may search for VVS2, which is a type of diamond clarity). Additionally, the user may resort the data by the columns. For instance, the user may want to sort the data from lowest depth to highest depth. That may be achieved by clicking on depth so that the triangle next to depth is pointing upward. As I noted above a change to the price range or cut will be reflected in this table. So, if you choose the download the diamonds data option, only the diamonds data corresponding to that price or cut will be downloaded in a csv file. Finally, there is an option of the columns in the table to display in the left sidebar. If you deselect one of the variables, the corresponding column will be removed from the Table of Diamonds Data. So, you can easily filter to the columns that you want and craft the table so that you can download the exact csv file that you want.

### Summary of Price by Cut

I thought that this table would be good to include as it gives you precise numerical means of the prices for the different cuts. So, you can confirm what the mean line on the histogram incidates with the actual value. There is an option to download the summary of price by cut data as a csv file. 

### Plotly scatterplot of the sample carat vs price

I thought would be cool to include thehe plotly scatterplot because it was relatively easy to code but adds an extra level of interactivity for the user. The plot is of diamond carat versus price for the desired price range and cut selected in the left sidebar. If you hover over a point on the scatterplot, you can see the exact point carat and price values. Additionally, plotly allows you to download the plot easily as a png file if you hover over the camera button. You also have the options to zoom in or out of the plot or pan across the plot by using the corresponding buttons in the top right corner of the plot.
The app has many facets to it 

Note, I referred to [this tutorial](https://plot.ly/r/shiny-tutorial/) for the base of the code used to incorporate plotly into my app.