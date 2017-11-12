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

import socket from "./socket"

// declare the chart.js charts as global vars since we need to update them when we get socket messages (ie. the update_price methods)
var btc_chart;
var eth_chart;
var ltc_chart;

$(function() {

  if ($("#BTCChart").length > 0) {
    // we're on the home page
    draw_all_prices();
    create_sockets();
  }

});

function create_sockets() {
  var btc_chan = socket.channel("prices:btc");
  btc_chan.join()
    .receive("ok", resp => { console.log("Joined btc channel successfully", resp); })
    .receive("error", resp => { console.log("Unable to join btc channel", resp); });

  btc_chan.on("price_update", update_btc_price);

  var ltc_chan = socket.channel("prices:ltc");
  ltc_chan.join()
    .receive("ok", resp => { console.log("Joined ltc channel successfully", resp); })
    .receive("error", resp => { console.log("Unable to join ltc channel", resp); });

  ltc_chan.on("price_update", update_ltc_price);

  var eth_chan = socket.channel("prices:eth");
  eth_chan.join()
    .receive("ok", resp => { console.log("Joined eth channel successfully", resp); })
    .receive("error", resp => { console.log("Unable to join eth channel", resp); });

  eth_chan.on("price_update", update_eth_price);
}

function timeNow() {
  var d = new Date(),
      h = (d.getHours()<10?'0':'') + d.getHours(),
      m = (d.getMinutes()<10?'0':'') + d.getMinutes();
  return (h + ':' + m);
}

function update_btc_price(msg) {
  console.log("btc_update", msg);
  if (typeof btc_chart != 'undefined') {
    btc_chart.data.labels.push("LiveUpdate at " + timeNow());
    btc_chart.data.datasets.forEach((dataset) => {
        dataset.data.push(msg.price);
    });
    btc_chart.update();
  }
}

function update_ltc_price(msg) {
  console.log("ltc_update", msg);
  if (typeof ltc_chart != 'undefined') {
    ltc_chart.data.labels.push("LiveUpdate at " + timeNow());
    ltc_chart.data.datasets.forEach((dataset) => {
        dataset.data.push(msg.price);
    });
    ltc_chart.update();
  }
}

function update_eth_price(msg) {
  console.log("eth_update", msg);
  if (typeof eth_chart != 'undefined') {
    eth_chart.data.labels.push("LiveUpdate at " + timeNow());
    eth_chart.data.datasets.forEach((dataset) => {
        dataset.data.push(msg.price);
    });
    eth_chart.update();
  }
}

function draw_all_prices() {
    draw_prices("BTC");
    draw_prices("ETH");
    draw_prices("LTC");
}

function draw_prices(currency) {
    // define GET request for API
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", "api/prices?currency=" + currency, true); // true for asynchronous request
    xmlHttp.send( null );

    // define callback for when api call completes
    var chart;
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
          chart = new Chart(ctx, {
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

          if (currency == "BTC") {
            btc_chart = chart;
          }
          if (currency == "LTC") {
            ltc_chart = chart;
          }
          if (currency == "ETH") {
            eth_chart = chart;
          }
        }
      }
    }

    return chart;
}
