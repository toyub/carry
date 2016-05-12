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

  initialize: (opt) ->
    @reader = new FileReader()
    @reader.onload = @listenWorkBook
    @collection = new Mis.Collections.ImportMaterialsCollection()
    @collection.reset opt.materials
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
      theads = sheet_rows.shift();
      valid = @validate_header(theads);
      if valid.success
        @insertThead(theads)
        @parseBodyData(sheet_rows)
      else
        $("input#xlf").val('');
        ZhanchuangAlert(valid.notice + "请重新上传")

  validate_header: (header) ->
    return {success: false, notice: "上传数据少与要求"} if header.length < 11
    for head, i in @standard_thead
      return {success: false, notice: "上传数据顺序有误"} if head != header[i]

    {success: true, notice: "上传数据正确"}

  insertThead: (header) ->
    view = new Mis.Views.Materials.tableThead(header: header)
    $('#results > thead').html(view.render().el);

  insertRow: (rowData, new_record) ->
    view = new Mis.Views.Materials.tableTbodyRow({rowData: rowData, new_record: new_record})
    $('#results > tbody').append(view.render().el);

  convertToObj: (dataArray)->
    {
      name:             dataArray[0],
      barcode:          dataArray[1],
      root_category:    dataArray[2],
      second_category:  dataArray[3],
      speci:            dataArray[4],
      unit:             dataArray[5],
      brand:            dataArray[6],
      manufacture:      dataArray[7],
      forSell:          dataArray[8],
      cost_price:       dataArray[9],
      retail_price:     dataArray[10],
      store_house:      dataArray.slice(11),
    }

  checkRowData: (rowData) ->

  parseBodyData: (rows) ->
    for rowData in rows
      new_record = @collection.add(@convertToObj(rowData))
      @insertRow(rowData, new_record)

  render: ->
    @$el.html(@template())
    @

