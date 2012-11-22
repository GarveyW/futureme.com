%if 'scripts' not in globals(): scripts = []
%if 'title' not in globals(): title='FutureMe'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>{{title}}</title>
    <meta name="description" content="An application that shows you how your choices today will affect your health in the future.">
    <meta name="author" content="Kurt Spindler">

    <!-- styles -->
    <link href="./static/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
    <script type="text/javascript" src="/static/bootstrap-modal.js"></script>
    %for script in scripts:
       <script type='text/javascript' src="/static/{{script}}"></script>
    %end
    <style type="text/css">
      body {
        padding-top: 60px;
      }
      .frame {
        padding: 5px; border: 1px solid #aaa;
      }
      .center {
        margin: 5px auto; display: block;
      }
      .large {
        max-width:330px; max-height:230px;
      }
      .medium {
        max-width:210px; max-height:150px;
      }
    </style>

    <!-- fav and touch icons -->
    <link rel="shortcut icon" href="images/favicon.ico">
    <link rel="apple-touch-icon" href="images/apple-touch-icon.png">
    <link rel="apple-touch-icon" sizes="72x72" href="images/apple-touch-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="114x114" href="images/apple-touch-icon-114x114.png">


