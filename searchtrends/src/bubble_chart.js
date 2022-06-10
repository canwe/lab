/* bubbleChart creation function. Returns a function that will
 * instantiate a new bubble chart given a DOM element to display
 * it in and a dataset to visualize.
 *
 * Organization and style inspired by:
 * https://bost.ocks.org/mike/chart/
 *
 */
function bubbleChart() {
  // Constants for sizing
  var width = 940;
  var height = 600;

  // tooltip for mouseover functionality
  var tooltip = floatingTooltip('gates_tooltip', 240);

  // Locations to move bubbles towards, depending
  // on which view mode is selected.
  var center = { x: width / 2, y: height / 2 };

  // @v4 strength to apply to the position forces
  var forceStrength = 0.001;

  // These will be set in create_nodes and create_vis
  var svg = null;
  var bubbles = null;
  var nodes = [];

  // Charge function that is called for each node.
  // As part of the ManyBody force.
  // This is what creates the repulsion between nodes.
  //
  // Charge is proportional to the diameter of the
  // circle (which is stored in the radius attribute
  // of the circle's associated data.
  //
  // This is done to allow for accurate collision
  // detection with nodes of different sizes.
  //
  // Charge is negative because we want nodes to repel.
  // @v4 Before the charge was a stand-alone attribute
  //  of the force layout. Now we can use it as a separate force!
  function charge(d) {
    return -Math.pow(d.radius, 2.0) * forceStrength;
  }

  // Here we create a force layout and
  // @v4 We create a force simulation now and
  //  add forces to it.
  var simulation = d3.forceSimulation()
    .velocityDecay(0.2)
    .force('x', d3.forceX().strength(forceStrength).x(center.x))
    .force('y', d3.forceY().strength(forceStrength).y(center.y))
    .force('charge', d3.forceManyBody().strength(charge))
    .on('tick', ticked);

  // @v4 Force starts up automatically,
  //  which we don't want as there aren't any nodes yet.
  simulation.stop();

  // Nice looking colors - no reason to buck the trend
  // @v4 scales now have a flattened naming scheme
  // https://stackoverflow.com/questions/54516735/how-to-get-different-shades-of-colors-for-a-single-color
  var fillColor = d3.scaleLinear()
    .domain([0, 100])
    .range(['#d6effc', '#fdd4e9'])
    .interpolate(d3.interpolateRgb.gamma(1.9));

  var myNodes = null;
  /*
   * This data manipulation function takes the raw data from
   * the CSV file and converts it into an array of node objects.
   * Each node will store data and visualization values to visualize
   * a bubble.
   *
   * rawData is expected to be an array of data objects, read in from
   * one of d3's loading functions like d3.csv.
   *
   * This function returns the new node array, with a node in that
   * array for each element in the rawData input.
   */
  function createNodes(rawData) {
    // Use the max total_amount in the data as the max in the scale's domain
    // note we have to ensure the total_amount is a number.
    var maxAmount = d3.max(rawData, function (d) { return +d.value; });

    // Sizes bubbles based on area.
    // @v4: new flattened scale names.
    var radiusScale = d3.scalePow()
      .exponent(0.5)
      .range([2, 85])
      .domain([0, maxAmount]);

    // Use map() to convert raw data into node data.
    // Checkout http://learnjsdata.com/ for more on
    // working with data.
    var transformedNodes = rawData.map(function (d) {
      return {
        id: d.id,
        radius: radiusScale(+d.value),
        value: +d.value,
        text: d.text,
//        name: d.grant_title,
//        org: d.organization,
//        group: d.group,
//        year: d.start_year,
        x: Math.random() * (940 - radiusScale(+d.value)),
        y: Math.random() * (600 - radiusScale(+d.value))
      };
    });

    if (null != myNodes) {
      // merge with myNodes
      transformedNodes.forEach(function(node) {
        if (myNodes[node.id]) {
          node.x = myNodes[node.id].x;
          node.y = myNodes[node.id].y;
        }
      });
    }
    myNodes = transformedNodes.reduce((a, v) => ({...a, [v.id]: v}), {});
    // sort them to prevent occlusion of smaller nodes.
    transformedNodes.sort(function (a, b) { return b.value - a.value; });

    return transformedNodes;
  }

  /*
   * Main entry point to the bubble chart. This function is returned
   * by the parent closure. It prepares the rawData for visualization
   * and adds an svg element to the provided selector and starts the
   * visualization creation process.
   *
   * selector is expected to be a DOM element or CSS selector that
   * points to the parent element of the bubble chart. Inside this
   * element, the code will add the SVG continer for the visualization.
   *
   * rawData is expected to be an array of data objects as provided by
   * a d3 loading function like d3.csv.
   */
  var chart = function chart(selector, rawData) {
    // convert raw data into nodes data
    nodes = createNodes(rawData);

    // Create a SVG element inside the provided selector
    // with desired size.
    svg = d3.select(selector)
      // .append('svg')
      .select('svg')
      .attr('width', width)
      .attr('height', height);

    // Bind nodes data to what will become DOM elements to represent them.
    bubbles = svg.selectAll('.bubble')
      .data(nodes, function (d) { return d.id; });

    // Create new circle elements each with class `bubble`.
    // There will be one circle.bubble for each object in the nodes array.
    // Initially, their radius (r attribute) will be 0.
    // @v4 Selections are immutable, so lets capture the
    //  enter selection to apply our transtition to below.
    var bubblesE = bubbles.enter().append('circle')
      .classed('bubble', true)
      .attr('r', 0)
      .attr('fill', function (d) { return fillColor(d.value); })
      .attr('stroke', function (d) { return d3.rgb(fillColor(d.value)).darker(); })
      .attr('stroke-width', 0.3)
      .on('mouseover', showDetail)
      .on('mouseout', hideDetail);

    // @v4 Merge the original empty selection and the enter selection
    bubbles = bubbles.merge(bubblesE);

    // Fancy transition to make bubbles appear, ending with the
    // correct radius
    bubbles.transition()
      .attr('r', function (d) { return d.radius; });

    // Set the simulation's nodes to our newly created nodes array.
    // @v4 Once we set the nodes, the simulation will start running automatically!
    simulation.nodes(nodes);

    // Set initial layout to single group.
    // @v4 Reset the 'x' force to draw the bubbles to the center.
    simulation.force('x', d3.forceX().strength(forceStrength).x(center.x));

    // @v4 We can reset the alpha value and restart the simulation
    simulation.alpha(0.05).restart();
  };

  /*
   * Callback function that is called after every tick of the
   * force simulation.
   * Here we do the actual repositioning of the SVG circles
   * based on the current x and y values of their bound node data.
   * These x and y values are modified by the force simulation.
   */
  function ticked() {
    bubbles
      //.each(collide(.5))
      .attr('cx', function (d) { return d.x; })
      .attr('cy', function (d) { return d.y; });
  }

  // Resolve collisions between nodes.
  function collide(alpha) {
    var quadtree = d3.quadtree(nodes);
    var maxRadius = Math.max(...nodes.map((node) => node.radius));
    return function(d) {
      var padding = 0
      var r = d.radius + maxRadius + padding,
          nx1 = d.x - r,
          nx2 = d.x + r,
          ny1 = d.y - r,
          ny2 = d.y + r;
      quadtree.visit(function(quad, x1, y1, x2, y2) {
        if (quad.point && (quad.point !== d)) {
          var x = d.x - quad.point.x,
              y = d.y - quad.point.y,
              l = Math.sqrt(x * x + y * y),
              r = d.radius + quad.point.radius + padding;
          if (l < r) {
            l = (l - r) / l * alpha;
            d.x -= x *= l;
            d.y -= y *= l;
            quad.point.x += x;
            quad.point.y += y;
          }
        }
        return x1 > nx2 || x2 < nx1 || y1 > ny2 || y2 < ny1;
      });
    };
  }

  /*
   * Function called on mouseover to display the
   * details of a bubble in the tooltip.
   */
  function showDetail(d) {
    // change outline to indicate hover state.
    d3.select(this).attr('stroke', 'black');

    var content = '<span class="name">Search interest: </span><span class="value">' +
                  addCommas(d.value) +
                  '</span><br/>' +
                  '<span class="name"></span><span class="value">' +
                  d.text +
                  '</span>';

    tooltip.showTooltip(content, d3.event);
  }

  /*
   * Hides tooltip
   */
  function hideDetail(d) {
    // reset outline
    d3.select(this)
      .attr('stroke', d3.rgb(fillColor(d.value)).darker());

    tooltip.hideTooltip();
  }

  /*
   * Externally accessible function (this is attached to the
   * returned chart function). Allows the visualization to toggle
   * between "single group" and "split by year" modes.
   *
   * displayName is expected to be a string and either 'year' or 'all'.
   */
  chart.toggleDisplay = function (idx) {
    if (idx === 'update') {
        d3.csv('data/gates_money_updated.csv', display);
    }
  };


  // return the chart function from closure.
  return chart;
}

/*
 * Below is the initialization code as well as some helper functions
 * to create a new bubble chart instance, load the data, and display it.
 */

var myBubbleChart = bubbleChart();

/*
 * Function called once data is loaded from CSV.
 * Calls bubble chart function to display inside #vis div.
 */
function display(error, data) {
  if (error) {
    console.log(error);
  }

  myBubbleChart('#vis', data);
}

/*
 * Sets up the layout buttons to allow for toggling between view modes.
 */
function setupButtons() {
  d3.select('#toolbar')
    .selectAll('.button')
    .on('click', function () {
      // Find the button just clicked
      var button = d3.select(this);
      // Set it as the active button
      button.classed('active', true);
      // Get the id of the button
      var buttonId = button.attr('id');
      // Update the bubble chart based on
      // the currently clicked button.
      myBubbleChart.toggleDisplay(buttonId);
    });
}

/*
 * Helper function to convert a number into a string
 * and add commas to it to improve presentation.
 */
function addCommas(nStr) {
  nStr += '';
  var x = nStr.split('.');
  var x1 = x[0];
  var x2 = x.length > 1 ? '.' + x[1] : '';
  var rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1)) {
    x1 = x1.replace(rgx, '$1' + ',' + '$2');
  }

  return x1 + x2;
}

// https://stackoverflow.com/questions/35910649/how-to-load-a-json-object-instead-of-json-file
// Load the data.
//d3.csv('data/gates_money.csv', display);
//
// fetch google data
var proxyUrl = "https://rocky-springs-6959.herokuapp.com/";
var trendsUrl = "https://trends.google.com/trends/api/realtimetrends?hl=en-US&tz=-180&cat=all&fi=0&fs=0&geo=US&ri=300&rs=20&sort=0"
var widgetsUrl = function(storyId) { return proxyUrl + `https://trends.google.com/trends/api/stories/${storyId}?hl=en-US&tz=-180`; }
var timelineUrl = function(wRequest, token) {
  //{"geo":{"country":"US"},"time":"2022-06-08T05\\:00\\:00+2022-06-09T14\\:00\\:00","resolution":"HOUR","mid":["/m/01jpn4","/m/025_b","/m/07ssc","/g/11b8c3zpmf","/m/06cs1","/m/02m96","/m/04zxvs0"],"locale":"en-US"}
  var reqEnc = encodeURIComponent(JSON.stringify(wRequest, null, ''));
  return proxyUrl + `https://trends.google.com/trends/api/widgetdata/timeline?hl=en-US&tz=-180&req=${reqEnc}&token=${token}&tz=-180`
}
var reqUrl = proxyUrl + trendsUrl;
//https://learn.javascript.ru/fetch
// handy "get" shortcut with error handling
const get = async (url) => {
  const res = await fetch(url) // "GET" is the default method
  if (!res.ok) {
    throw new Error(`${res.status}: ${await res.text()}`)
  }
  return res
};

const googleFmt = async (response) => {
  let txt = await response.text();
  let substIndex = txt.indexOf("{");
  return JSON.parse(txt.substring(substIndex));
}

//https://bl.ocks.org/johnwalley/e1d256b81e51da68f7feb632a53c3518
function showSlider(trends) {

  var minTime = Number.POSITIVE_INFINITY;
  var maxTime = Number.NEGATIVE_INFINITY;
  for (let story of trends) {
    minReduce = story["timeline"].reduce(function(prev, curr) {
      return parseInt(prev["time"]) < parseInt(curr["time"]) ? prev : curr;
    })
    minTime = Math.min(minTime, parseInt(minReduce["time"]));

    maxReduce = story["timeline"].reduce(function(prev, curr) {
      return parseInt(prev["time"]) > parseInt(curr["time"]) ? prev : curr;
    })
    maxTime = Math.max(maxTime, parseInt(maxReduce["time"]));
  }

  function data(sliderValue) {
    function truncateString(str, num) {
      return str.length > num ? str.slice(0, num) + "..." : str;
    }
    //https://www.symbolspy.com/dot-symbol.html
    return trends.map(function(t) {
     var pos = d3.bisect(t["times"], sliderValue);
     return {
      "id": truncateString(t["entityNames"].join(" • "), 30),
      "text": t["entityNames"].join(" • "),
      "value": t["timeline"][Math.max(0, pos - 1)]["value"]
     }
    });
  }
  // Time
  var dataTime = d3.range(minTime, maxTime, 3600).map(function(d) {
    return d;
  });

  var sliderTime = d3
    .sliderBottom()
    .min(d3.min(dataTime))
    .max(d3.max(dataTime))
    .step(3600)
    .width(800)
    // https://d3-wiki.readthedocs.io/zh_CN/master/Time-Formatting/
    .tickFormat(function(d) { d3.timeFormat('%b %e %I:00 %p')(d * 1000) } )
    //.tickValues(dataTime)
    .default(d3.min(dataTime))
    .on('onchange', val => {
      d3.select('#value-time').text(d3.timeFormat('%b %e %I:00 %p')(val * 1000));
      display(null, data(val));
    });

  var svg = d3
    .select('div#slider-time')
    .append('svg')
    .attr('width', 940)
    .attr('height', 100);

  var gTime = svg
    .append('g')
    .attr('transform', 'translate(20,30)');

  var gText = svg
    .append('text')
    .attr('id', 'value-time')
    .attr('transform', 'translate(840,30)');

  gTime.call(sliderTime);

  d3.select('text#value-time').text(d3.timeFormat('%b %e %I:00 %p')(sliderTime.value() * 1000));
  // todo update #vis
  d3.select("#vis img.spinner").remove();
   display(null, data());

}

//https://stackoverflow.com/questions/49432579/await-is-only-valid-in-async-function
// Here we wait for the myfunction to finish
// and then returns a promise that'll be waited for aswell
// It's useless to wait the myfunction to finish before to return
// we can simply returns a promise that will be resolved later

// Also point that we don't use async keyword on the function because
// we can simply returns the promise returned by myfunction
async function start() {

  let resp = await get(reqUrl);
  let json = await googleFmt(resp);

  var trendingStoryIds = json.trendingStoryIds;
  var mLen = Math.min(2, trendingStoryIds.length);

  var stories = []
  for (var i = 0; i < mLen; i++) {

    var storyId = trendingStoryIds[i];
    var storyResp = await get(widgetsUrl(storyId));
    var storyJson = await googleFmt(storyResp);

    for (let widget of (storyJson["widgets"] || [])) {
      if ("TIMESERIES" === widget.id) {
        var timelineResp = await get(timelineUrl(widget.request, widget.token));
        var timelineJson = await googleFmt(timelineResp);
        var timeline = timelineJson["default"]["timelineData"]

        for (let item of timeline) {
          item["time"] = parseInt(item["time"])
        }
        stories.push({
          "entityNames" : storyJson["entityNames"],
          "timeline" : timeline
        })
        break;
      }
    }
  }
  return stories;
}

async function mockStart() {
  var jsondata = await fetch("./data.json")
  .then(response => {
     return response.json();
  });
  var stories = jsondata["data"];
  for (let story of stories) {
    for (let item of story["timeline"]) {
      item["time"] = parseInt(item["time"])
    }
    story["times"] = story["timeline"].map((tl) => tl["time"])
  }
  return stories;
}

// Call start
(async() => {
  let stories = await mockStart();
  showSlider(stories);
})();

// setup the buttons.
//setupButtons();
