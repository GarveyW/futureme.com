%include header_top title='FutureMe'
%include css_overrides
%include header_bot

<div class="content">

  <div class="span14">
    <h1>Tell Your Story</h1>
    <p>Post a video of yourself. Make a commitment to changing your lifestyle to lower your risk for heart disease. Or share your experience on ways that you were able to reduce your risk.
    <p>Post the video to YouTube, and then copy the URL here. Add a description, and go!
    <form action="/share_story" method="post">
      <fieldset>
        <div class="clearfix">
          <label for="youtubeurl">Youtube URL</label>
          <div class="input">
            <input class="span" id="youtubeurl" name="youtubeurl" size="30" type="text" />
          </div>
        </div>
        <div class="clearfix">
          <label for="videodescription">Description</label>
          <div class="input">
            <textarea class="xxlarge" id="videodescription" name="videodescription" rows="10"></textarea>
          </div>
        </div><!-- /clearfix -->
      </fieldset>
      <div class="actions">
        <div class="row">
          <div class="span5">
            <br>
            <br>
            <button type="submit" class="btn primary large">Submit</button>
            <button type="reset" class="btn">Cancel</button>
          </div>
          <div class="span5">
            <p>You can also share your commitment with your friends and family directly using the Million Hearts network. Click the button to learn more.
            <p><a href="http://millionhearts.hhs.gov/individuals.shtml" class="btn info">Million Hearts</a>
          </div>
        </div>
      </div>
    </form>
  </div>
  <div class="span14">
    <h1>See Stories</h1>
    <p>See other people's videos here - the commitments they've made and the experiences they've had in reducing their risk.
      
    %for video_tuple in videos:
      <div class="row">
        <div class="span7">
          <iframe width="399" height="233" src="http://www.youtube.com/embed/{{video_tuple[0]}}" frameborder="2" allowfullscreen></iframe>
        </div>
        <div class="span7">
          <h2>{{video_tuple[1]}}</h2>
          {{video_tuple[2]}}
        </div>
      </div>
      <br>
    %end
  </div>
</div>

%include footer

