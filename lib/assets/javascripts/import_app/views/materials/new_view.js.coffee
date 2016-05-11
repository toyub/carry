Mis.Views.Materials ||= {}

class Mis.Views.Materials.NewView extends Backbone.View
  template: JST['import/materials/new']

  standard_thead: [
      "商品名称",
      "条码",
      "一级分类",
      "二级分类",
      "规格",
      "单位",
      "品牌",
      "生产商",
      "是否销售",
      "成本价格",
      "销售价格",
  ]

  initialize: ->
    @reader = new FileReader()
    @reader.onload = @listenWorkBook
    $('.field').html(@render().el)

  events: ->
    'change input#xlf' : 'handleUploadXlf'

  handleUploadXlf: (e) ->
    files = e.target.files;
    @reader.readAsBinaryString(files[0])

  listenWorkBook: (e) =>
    data = e.target.result
    wb = XLSX.read(data, {type: 'binary'})
    @handleWorkBook(wb)

  handleWorkBook: (workbook) ->
    for sheetName in workbook.SheetNames
      sheet = workbook.Sheets[sheetName];
      sheet_rows = sheet_to_row(sheet);
      trs = [];
      theads = sheet_rows.shift();
      is_valid = @validate_header(theads);
      console.log is_valid

  validate_header: (header) ->
    return false if header.length < 11
    for head, i in @standard_thead
      return if head != header[i]

    true

  render: ->
    @$el.html(@template())
    @

