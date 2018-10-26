// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery;
import "bootstrap";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

$(function() {
  var now = new Date();
  var day = now.getDay();
  var month = now.getMonth();
  var year = now.getFullYear();

  var second = now.getSeconds();
  var minutes = now.getMinutes();
  var hours = now.getHours();

  var dateTime = month + "/" + day + "/" + year + "  ";
  dateTime = dateTime + hours + ":" + minutes + ":" + second;

  var taskID = $('#getTaskId').text()

  $('#startTime').val(dateTime);
  $('#endTime').val(dateTime);

  $('#FormSubmit').click((ev) => {
    let startTime = $('#startTime').val()
    let endTime = $('#endTime').val()

    let mesg = JSON.stringify({
      timeblock: {
      start: startTime,
      end: endTime,
      task_id: taskID
    },
  });



  console.log("Hello")

  $.ajax("/ajax/timeblocks", {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: mesg,
    error: function(xhr, status, error) {
      var err = eval("(" + xhr.responseText + ")");
      alert(err.Message);
    },
    success: (resp) => {
      console.log("did it!");
    } ,
  });
});
});



function getTimeblock() {
  var startLoc = $('#displayStart')
  var endLoc = $('#displayEnd')
}
