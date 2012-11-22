%include header_top title='FutureMe'
%include css_overrides
%include header_bot

<div class="content">
  <div class="page-header">
    <h1>Story Sharing - {{'Success' if success else 'Failure'}}</h1>
  </div>

  <div class="span14">
    %if success:
      <p>Posting your story was successful. Click the button to see it. 
    %else:
      <p>Uh oh! Something went wrong. Click the button to go back to stories and try again.
    %end
    <p><a href="/share" class="btn primary large">Go back to stories!</a>
  </div>
</div>

%include footer

