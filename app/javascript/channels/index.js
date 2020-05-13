// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

$( document ).ready(function() {
  $('#attached-file').on('change', function() {
    var numb = $(this)[0].files[0].size/1024/1024;
    numb = numb.toFixed(2);
    if(numb > 5){
      $('#file-submit').prop('disabled', true);
      alert('to big, maximum is 5MB. You file size is: ' + numb +' MB');
    } else {
      $('#file-submit').prop('disabled', false);
    }
  });
});
