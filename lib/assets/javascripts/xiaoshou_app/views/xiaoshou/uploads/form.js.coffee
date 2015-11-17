class Mis.Views.XiaoshouUploadsForm extends Backbone.View

  el: '#piccut'

  template: JST['xiaoshou/uploads/form']

  events:
    'click .js-cancel': 'close'

  render: ->
    @$el.html(@template(url: 'xx'))
    @

  open: ->
    @render()
    @initFileReading()
    @$el.show()

  initFileReader: =>
    fr = new FileReader()
    fr.onload = (e) ->
      $('#image_tag').remove()
      $("#gallery").remove()

      image = new Image()
      image.className = "resize-image"
      image.id = 'image_tag'
      image.src = this.result

      div = document.createElement("div")
      div.id='gallery'
      div.className = 'resize-container'
      div.style.top = '-1px'
      div.style.left = '115px'
      div.appendChild(image)
      $('#arrange').append div

      resizeableImage(document.getElementById('image_tag'), $('.js-crop')[0], $("#preview_list"))
    fr

  readFile: (fileReader) ->
    document.getElementById("imgfile").onchange = (e) ->
      f1 = this.files.item(0)
      if (f1.type == 'image/png' || f1.type == 'image/jpeg')
        fileReader.readAsDataURL(f1, 'image/png')
      else
        alert('错误的文件格式，请选择PNG或JPG格式的图片文件！')
        this.value = ''

  initFileReading: ->
    return false if !document.getElementById("imgfile")
    @readFile @initFileReader()

  close: ->
    @undelegateEvents()
    @$el.hide()
