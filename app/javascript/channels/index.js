// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

$( document ).ready(function() {
  function readURL(file) {
    var reader = new FileReader();
    reader.addEventListener("load", function () {
      $('#attached-file').attr('data-url', reader.result)
    });
    if (file) {
      reader.readAsDataURL(file);
    }
  }

  $('#attached-file').on('change', function() {
    var numb = $(this)[0].files[0].size/1024/1024;
    numb = numb.toFixed(2);
    if(numb > 5){
      $('#file-submit').prop('disabled', true);
      alert('to big, maximum is 5MB. You file size is: ' + numb +' MB');
    } else {
      readURL($(this)[0].files[0]);
      $('#file-submit').prop('disabled', false);
    }
  });

  $('form').on('submit', function() {
    event.preventDefault();
    formData = {'attachment': {}};
    formData['attachment']['attachment'] = $('#attached-file').data('url');
    formData['attachment']['title'] = $('#title').val();
    formData['attachment']['description'] = $('#description').val();

    $.ajax({
      type : 'POST',
      url :  window.location.origin + '/attachments',
      data : formData,
      dataType : 'script',
      encode : true
    })
    .done(function(data, textStatus, jqXHR) {
    });
  });
});
