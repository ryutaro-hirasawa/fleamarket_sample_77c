$(function(){
/*$(document).on('turbolinks:load', ()=> {*/
  // 画像用のinputを生成する関数
  const buildFileField = (index)=> {
    const html = `<div data-index="${index}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="item[images_attributes][${index}][src]"
                    id="item_images_attributes_${index}_src"><br>
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }

  /* テキストを参考に追記 */
  const buildImg = (index, url)=> {
    const html = `<img class="preview-image" data-index="${index}" src="${url}" width="100px" height="100px">`;
    /*  #image-box*/
    /*    class="image-box"*/
    /*      class="image-box__button__delite" data-index="${indexLength}" 削除*/
    /*const html = `
    .image-box
      <img>
      sakujyo
      henshu
    `;*/
    return html;
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];

  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);
  $('.hidden-destroy').hide();

  $('.ItemNew-Img').on('click', function(e) {
    const previewImages = $('.preview-image');
    /*console.log(previewImages.length);*/
    if(previewImages.length >= 10){
      alert('limit');
      return false;
    }
    const fileField = $('input[type="file"]:last');
    fileField.trigger('click');
  });

  /*console.log('load');*/
  $('#file-fields').on('change', '.js-file', function(e) {
    /*console.log('change', this);*/
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    // 該当indexを持つimgタグがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  // 新規画像追加の処理
      $('#previews').append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る

    // fileIndexの先頭の数字を使ってinputを作る
    $('#file-fields').append(buildFileField(fileIndex[0]));
    fileIndex.shift();
    // 末尾の数に1足した数を追加する
    fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
    }
  });

   

  $('#image-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index')
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();

    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));

  });
});