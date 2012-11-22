%include header title='FutureMe', scripts=['d3.js']

<div class="hero-unit">
  <h2>Your Future Report</h2>
  <p>{{name + ', w' if name else 'W'}}e have your personal report!
  <p>Current blood pressure: <font color="#{{'0f0' if is_healthy else 'f00'}}">{{systolicbp}}/{{diastolicbp}}</font>. Target blood pressure:{{target_systolic}}/{{target_diastolic}}.
  %if is_healthy:
    <p>Your blood pressure is currently at a healthy level. Press the blue button to see your risks change if your blood pressure were to rise.
  %else:
    <p>Your blood pressure is higher than it should be - putting you at a higher risk for heart disease. Press the blue button to see what would happen if you made positive changes to control your blood pressure.
  %end
  <p><a href="javascript:onControlMyBloodPressure();" class="btn primary large" id="controlmybloodpressure">{{'Raise My Blood Pressure' if is_healthy else 'Control My Blood Pressure!'}}</a>
  <a href="#nowwhat" class="btn primary large" id="controlmybloodpressure">What's Next?</a>
  <a href="/clear_cookies" class="btn danger">Reset Report</a>
</div>
<div class="span14" id="chartcontainer">
  <div id="chart">
  </div>
</div>
<br>
<div class="span14">
  <h2 id="nowwhat">Now What?</h2>
  <div class="row">
    <div class="span3">
      <img src="/static/images/direct_project.png" width="150" height="auto" class="frame center" />
    </div>
    <div class="span4">
      <h3>Show your doctor</h3>
      <p>Send this report to your doctor using the <a href="http://directproject.org/">Direct Project</a>. Discuss the results with your doctor and learn more!
      <p><a href="javascript:alert('Not implemented yet! Check back soon!')" class="btn primary">Go!</a>
    </div>
    <div class="span3">
      <img src="/static/images/doctor2.jpg" width="auto" height="150" class="frame center" />
    </div>
    <div class="span4">
      <h3>Take the next steps</h3>
      <p>Learn what you can do with these results. Get personal recommendations on how to improve your health.
      <p><a href="/education" class="btn primary">Learn More!</a>
    </div>



  </div>
</div>

<script type="text/javascript">
  var bar_buffer = 30;
  var onControlMyBloodPressure = function() {
    data = {{below_data if is_healthy else above_data}};
    chart.selectAll("rect")
      .data(data)
      .transition()
      .duration(1500)
      .attr("y", function(d) {return height - d*height; })
      .attr("width", width - bar_buffer)
      .attr("height", function(d) {return d*height; })
      .attr("fill", "{{'red' if is_healthy else 'green'}}")
      .attr("opacity", 0.7);
    chart.selectAll("text")
      .data(data)
      .text(function (d, i) { return ["Healthy ("+Math.round(d*100)+" %)","Heart Disease ("+Math.round(d*100)+" %)", "Stroke ("+Math.round(d*100)+" %)", "Kidney Problems ("+Math.round(d*100)+" %)"][i]; });
    document.getElementById("learnmorebutton").style.visibility="";
    document.getElementById("controlmybloodpressure").style.visibility="hidden";
  }
var width = document.getElementById('chart').offsetWidth / 4;
var height = 400;
var data = {{above_data if is_healthy else below_data}};
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
  .attr("fill", "{{'green' if is_healthy else 'red'}}")
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

