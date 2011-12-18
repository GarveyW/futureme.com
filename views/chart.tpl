%include header title='FutureMe', scripts=['d3.js']

<div class="hero-unit">
  <h2>Your Future</h2>
  <p>{{first_name}}, this is our prognosis of your health!</p>
  <a href="javascript:onControlMyBloodPressure();" class="btn primary large" id="controlmybloodpressure">Control My Blood Pressure! &raquo;</a>
  <a href="/static/education.html" class="btn large" id="learnmorebutton">Learn More! &raquo;</a>
</div>
<div class="span16" id="chartcontainer">
  <div id="chart">
  </div>
</div>
<script type="text/javascript">
  var bar_buffer = 30;
  var onControlMyBloodPressure = function() {
    data = {{adjusted_data}};//$percent_under;
    /*chart.selectAll("rect")
      .data(data2)
      .enter().append("svg:rect")
      .attr("x", 0)
      .attr("y", 0)
      .attr("width", 30)
      .attr("height", 30)
      .attr("fill: red")
      .attr("opacity", 0.7);*/
    chart.selectAll("rect")
      .data(data)
      .transition()
      .duration(1000)
      .attr("y", function(d) {return height - d*height; })
      .attr("width", width - bar_buffer)
      .attr("height", function(d) {return d*height; })
      .attr("fill", "green")
      .attr("opacity", 0.7);
    chart.selectAll("text")
      .data(data)
      .text(function (d, i) { return ["Healthy ("+Math.round(d*100)+" %)","Heart Disease ("+Math.round(d*100)+" %)", "Stroke ("+Math.round(d*100)+" %)", "Kidney Problems ("+Math.round(d*100)+" %)"][i]; });
    document.getElementById("learnmorebutton").style.visibility="";
    document.getElementById("controlmybloodpressure").style.visibility="hidden";
  }
var width = document.getElementById('chart').offsetWidth / 4;
var height = 400;
var data = [2, 3, 6, 9];//$percent_over;
var chart = d3.select("div#chart")
.append("svg:svg")
.attr("class", "chart")
.attr("width", width * data.length)
.attr("height", height);
  var x = d3.scale.ordinal()
  .domain(data)
  .range([0, width * data.length])
  var y = d3.scale.linear()
.domain([0, d3.max(data)])
  .range([0, height]);
  // chart.selectAll("rect")
  //     .data(data2)
  //       .enter().append("svg:rect")
  //          .attr("x", function(d, i) { return i * width; })
  //          .attr("y", function(d) { return height - d; })
  //          .attr("width", width)
  //          .attr("height", function(d) { return d; })
  //          .attr("fill", "red")
  //          .attr("opacity", 0.0);
  chart.selectAll("rect")
.data(data)
  .enter().append("svg:rect")
  .attr("x", function(d, i) { return i * width; })
  .attr("y", function(d) { return height - d*height; })
  .attr("width", width-bar_buffer)
  .attr("height", function(d) { return d*height; })
  .attr("fill", "red")
  .attr("opacity", 0.7);
  chart.selectAll("text")
.data(data)
  .enter().append("svg:text")
  .attr("x", function(d, i) { return i * width; })
  .attr("y", function(d, i) { return height - d; })
  .attr("dy", -height + 100)
  .attr("font-size", 16)
  .attr("dx", 3)
  //.attr(
  .attr("text-anchor", "center")
  .text(function (d, i) { return ["Healthy ("+Math.round(d*100)+" %)","Heart Disease ("+Math.round(d*100)+" %)", "Stroke ("+Math.round(d*100)+" %)", "Kidney Problems ("+Math.round(d*100)+" %)"][i]; });
</script>





%include footer

