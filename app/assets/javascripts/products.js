
$(function(){
  console.log('test')

  const buildFileField = (index)=> {
      // 画像用のinputを生成する関数
    const html = `<div data-index="${index}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="item[images_attributes][${index}][src]"
                    id="item_images_attributes_${index}_src"><br>
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }
  const buildImg = (index, url)=> {
    const html = `<div class="item-image"><img class="preview-image" data-index="${index}" src="${url}" width="120px" height="100px">
    <button class="item-image__js-remove">削除</button></div>`;
    return html;
  }
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);

  $('.hidden-destroy').hide();


  $('.ItemNew-Select').on('click', function(e) {
    console.log('test2')
    const previewImages = $('.preview-image');
    
    if(previewImages.length >= 5){
      alert('limit');
      return false;
    }
    const fileField = $('input[type="file"]:last');
    console.log(fileField)
    fileField.trigger('click');
  });

  $('#file-fields').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {
      $('#previews').append(buildImg(targetIndex, blobUrl));
    $('#file-fields').append(buildFileField(fileIndex[0]));
    fileIndex.shift();
    fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
    }
  });

  $('#previews').on('click', '.item-image__js-remove', function() {
    console.log("test")
    // const targetIndex = $(this).parent().data('index')
    // const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // if (hiddenCheck) hiddenCheck.prop('checked', true);
    // $(this).parent().remove();
    // $(`img[data-index="${targetIndex}"]`).remove();
    // if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
    
    // 削除ボタンを押した画像を取得
    var target_image = $(this).parent();
    // 削除画像のdata-image番号を取得
    var target_image_num = target_image.data('image');
    // 対象の画像をビュー上で削除
    target_image.remove();
  });

});