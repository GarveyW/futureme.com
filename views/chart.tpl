%include header title='FutureMe', scripts=['d3.js']

<div class="hero-unit">
  <h2>Your Future</h2>
  <p>{{name + ', t' if name else 'T'}}his is our prognosis of your health! Your target blood pressure is:{{target_systolic}}/{{target_diastolic}}.<br>
  Your current blood pressure: <font color="#{{'0f0' if is_healthy else 'f00'}}">{{systolicbp}}/{{diastolicbp}}</font>.<br>
  %if is_healthy:
    Your blood pressure is currently at a healthy level. Press the blue button to see what would happen if your blood pressure gets too high.
  %else:
    Your blood pressure is higher than it should be - putting you at a higher risk for many diseases. Press the blue button to see what would happen if you made positive changes to control your blood pressure.
  %end
  <a href="javascript:onControlMyBloodPressure();" class="btn primary large" id="controlmybloodpressure">{{'Raise My Blood Pressure' if is_healthy else 'Control My Blood Pressure!'}} &raquo;</a>
  <a href="/education" class="btn large" id="learnmorebutton">Learn More! &raquo;</a>
</div>
<div class="span16" id="chartcontainer">
  <div id="chart">
  </div>
</div>
<script type="text/javascript">
  var bar_buffer = 30;
  var onControlMyBloodPressure = function() {
    data = {{above_data if is_healthy else below_data}};
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
var data = {{below_data if is_healthy else above_data}};
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
  .attr("text-anchor", "center")
  .text(function (d, i) { return ["Healthy ("+Math.round(d*100)+" %)","Heart Disease ("+Math.round(d*100)+" %)", "Stroke ("+Math.round(d*100)+" %)", "Kidney Problems ("+Math.round(d*100)+" %)"][i]; });
</script>

%include footer

