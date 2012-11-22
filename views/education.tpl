%include header_top title='FutureMe'
%include css_overrides
%include header_bot
				
<div class="content">
  <div class="page-header">
    <h1>Your Personalized Recommendations</h1>
    <p>Based on the information you provided, these tips will best help you lead a heart-healthier life.
  </div>

  <div class="span14">
  %if smoking:
    <div class="row">
      <div class="span4">
        <img src="/static/images/smoking_cigarettes.jpg" height="130" width="auto" class="frame center"/>
      </div>
      <div class="span10">
        <h3>Smoking</h3>
        <p>Smoking really is bringing you down - in more ways than you might realize. Learn the hows and the whys by clicking on the button.
        <p><a href="/smoking" class="btn">Learn More</a>
      </div>
    </div>
  %end

  %if aspirin:
    <div class="row">
      <div class="span4">
        <img src="/static/images/aspirin.jpg" height="130" width="auto" class="frame center"/>
      </div>
      <div class="span10">
        <h3>Take Aspirin</h3>
        <p>Taking aspirin can reduce your risk of heart disease. Talk to your doctor to learn more.
      </div>
    </div>
  %end

  %if controlweight:
    <div class="row">
      <div class="span4">
        <img src="/static/images/scale.jpg" height="130" width="auto" class="frame center"/>
      </div>
      <div class="span10">
        <h3>Healthy Body Weight</h3>
        <p>Maintaining a healthy body weight will dramatically reduce your risk for heart disease. Get active and get going to a healthier you!
      </div>
    </div>
  %end
  %if fruits:
    <div class="row">
      <div class="span4">
        <img src="/static/images/fruits.jpg" height="130" width="auto" class="frame center"/>
      </div>
      <div class="span10">
        <h3>Fruits and Vegetables</h3>
        <p>Eating a healthy diet, rich in fruits and vegetables, will help you lead a stronger, healthier life.
      </div>
    </div>
  %end
  %if salt:
    <div class="row">
      <div class="span4">
        <img src="/static/images/salt.jpg" height="130" width="auto" class="frame center"/>
      </div>
      <div class="span10">
        <h3>Limit Your Salt</h3>
        <p>High salt intake is linked to high blood pressure, so make sure you get your salt consumption under control. Play the game here to test your knowledge about salt.
        <p><a href="/salt_smart" class="btn">Test Your Knowledge</a>
      </div>
    </div>
  %end
  %if exercise:
    <div class="row">
      <div class="span4">
        <img src="/static/images/rockclimbing.jpg" height="130" width="auto" class="frame center"/>
      </div>
      <div class="span10">
        <h3>Exercise</h3>
        <p>Do half an hour of aerobic activity each day and you'll be well on your way to living a healthier life.
      </div>
    </div>
  %end
  %if alcohol:
    <div class="row">
      <div class="span4">
        <img src="/static/images/teetotaler.jpg" height="130" width="auto" class="frame center"/>
      </div>
      <div class="span10">
        <h3>Limit alcohol</h3>
        <p>Alcohol can also increase your blood pressure. Try to limit your consumption to 1 drink a day for women, 2 drinks a day for men.
      </div>
    </div>
  %end
  </div>
</div>

%include footer

