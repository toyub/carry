(function(win, $){
  var create_xhr_with = function(options){
    var xhr = new XMLHttpRequest();
    if(options.onabort){
      xhr.onabort = options.onabort
    }
    if(options.onabort){
      xhr.onabort = options.onabort
    }
    if(options.onerror){
      xhr.onerror = options.onerror
    }
    if(options.onload){
      xhr.onload = options.onload
    }
    if(options.onloadend){
      xhr.onloadend = options.onloadend
    }
    if(options.onloadstart){
      xhr.onloadstart = options.onloadstart
    }
    if(options.onprogress){
      xhr.onprogress = options.onprogress
    }
    if(options.onreadystatechange){
      xhr.onreadystatechange = options.onreadystatechange
    }
    if(options.ontimeout){
      xhr.ontimeout = options.ontimeout
    }
    if(options.upload.onprogress){
      xhr.upload.onprogress = options.upload.onprogress
    }
    return xhr;
  }

  var qiniu_putb64 = function(base64_data, uptoken, opt){
    if(!base64_data || !uptoken){
      throw Error('Require 2 params "base64_data" and "uptoken"!');
    }
    var url = "http://up.qiniu.com/putb64/-1";
    var xhr = create_xhr_with(opt);
    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-Type", "application/octet-stream");
    xhr.setRequestHeader("Authorization", uptoken);
    xhr.send(base64_data);
    return xhr;
  }

  var  qiniu_b64_upload = function(img_data_url, opt){
    var base64code = img_data_url.replace('data:image/png;base64,', '');
    $.get('/api/qiniu/upload_token.json').done(function(data){
      if(data.uptoken){
        return qiniu_putb64(base64code, data.uptoken, opt);
      }else{
        throw Error("can not fetch 'Qiniu Upload Token'");
      }
    });
  }

  function QiniuUploadHandle(total, form_url, redirect_to){
    this.total = total;
    this.form_url = form_url;
    this.progress = 0;
    this.qiniu_results = [];

    this.add_results = function(idx, result){
      this.qiniu_results.push({idx: idx, qiniu_res: result});
      this.progress += 1;
    };

    this.form_data = function(){
      var sorted = this.qiniu_results.sort(function(r1, r2){return r1.idx > r2.idx});
      var keys = sorted.map(function(res){ return res.qiniu_res.key});
      return {results: keys};
    };

    this.save_image_for = function(url){
      var formdata = JSON.stringify(this.form_data());
      $.ajax({
        url: url,
        type: 'POST',
        data: formdata,
        contentType: 'application/json; charset=UTF-8'
      })
      .done(function(response){
          UploadDialog.completed();
      });
    }

    this.deal_with = function(idx, response){
      this.add_results(idx, response);
      if (this.progress == this.total){this.save_image_for(this.form_url);}
    }

    this.starting = function(){
      var opt = {};
      if(redirect_to){
        opt.close = function(){window.location.replace(redirect_to);}
      }
      UploadDialog.show(opt);
    }
  }

  function uploading(imgs, form_url, redirect_to){
    if(imgs.length > 0){
      var upload_handle = new QiniuUploadHandle(imgs.length, form_url, redirect_to);
      upload_handle.starting();

      imgs.each(function(idx, img, undef){/* *this = img;*/
         qiniu_b64_upload(img.src, {
          onloadstart:function(evt){
            UploadDialog.add_progress(idx + 1);
          },

          upload: {
            onprogress: function(evt){
              var progress_val = (evt.loaded / evt.total)*100;
              UploadDialog.up_progress(idx + 1, progress_val);
            }
          },

          onloadend: function(evt){/* *this=XMLHttpRequest; *evt=XMLHttpRequestProgressEvent */
            var res_json = JSON.parse(this.response);
            upload_handle.deal_with(idx, res_json);
          }
         })
      });
    }
  }

  window.uploading = uploading;
})(window, jQuery);
