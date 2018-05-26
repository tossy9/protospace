$(function(){
  $('.image-preview').on('change', 'input[type="file"]', function(e) {
    var file = e.target.files[0],
        reader = new FileReader();
    $('.cover-image-upload').css('background','url()');
  });
});
