// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

$(function() {

  if ($("#BTCChart").length > 0) {
    draw_prices("BTC");
    draw_prices("ETH");
    draw_prices("LTC");
  }

});


function draw_prices(currency) {
    // define GET request for API
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", "api/prices?currency=" + currency, true); // true for asynchronous request
    xmlHttp.send( null );

    // define callback for when api call completes
    xmlHttp.onreadystatechange = function() {
      if (xmlHttp.readyState == 4) {
        if (xmlHttp.status == 200) {

          // parse out data into a list of prices and a list of dates so we can put them in the graph
          var prices_and_dates = JSON.parse(xmlHttp.responseText);
          var prices = [];
          var dates = [];

          var i;
          for (i = 0; i < prices_and_dates.length; i++) {
            prices.push(prices_and_dates[i].price);
            dates.push(prices_and_dates[i].date);
          }

          // use chart.js to draw the actual chart
          var ctx = document.getElementById(currency + 'Chart').getContext('2d');
          var chart = new Chart(ctx, {
              // The type of chart we want to create
              type: 'line',

              // The data for our dataset
              data: {
                  labels: dates,
                  datasets: [{
                      label: currency + " Price Chart",
                      backgroundColor: 'rgb(255, 99, 132)',
                      borderColor: 'rgb(255, 99, 132)',
                      data: prices,
                  }]
              },

              // Configuration options go here
              options: {}
          });
        }
      }
    }
}
