$(function(){
  $('.cover-image-upload').on('change', 'input[type="file"]', function(e) {
    var file = e.target.files[0];
    var reader = new FileReader();
    
    // 画像ファイル以外の場合は何もしない
    if(file.type.indexOf("image") < 0){
      alert("画像ファイルを指定してください");
      return false;
    }
    
     reader.onload = (function(file) {
      return function(e) {
        //既存のプレビューを削除
        $(".cover-image-upload img").empty();
        // .prevewの領域の中にロードした画像を表示するimageタグを追加
        $(".cover-image-upload img").attr({
          src: e.target.result,
          width: "100%",
          height: "100%"
      });
      };
    })(file);
    reader.readAsDataURL(file);
  });
  
  //SUB
  $('.image-upload').on('change', 'input[type="file"]', function(e) {
    var file = e.target.files[0];
    var reader = new FileReader();
    
    // 画像ファイル以外の場合は何もしない
    if(file.type.indexOf("image") < 0){
      alert("画像ファイルを指定してください");
      return false;
    }
    
     reader.onload = (function(file) {
      return function(e) {
        //既存のプレビューを削除
        $(".image-upload img").empty();
        // .prevewの領域の中にロードした画像を表示するimageタグを追加
        $(".image-upload img").attr({
          src: e.target.result,
          width: "100%",
          height: "100%"
      });
      };
    })(file);
    reader.readAsDataURL(file);
  });
  });
