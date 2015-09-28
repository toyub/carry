Ext.onReady(function(){

  //Ext.define("StoreCustomer", {
    //extend: "Ext.data.Model",
    //fields: ["id", "full_name", "first_name"]
  //});

  Ext.define('StoreOrder',{
    extend: 'Ext.data.Model',
    fields: [
      "id",
      {name: "fullname", mapping: "store_customer.full_name" },
    ]
  });

  // create the Data Store
  var store = Ext.create('Ext.data.Store', {
    model: 'StoreOrder',
    proxy: {
      type: 'ajax',
      url: "/api/store_orders"
    },
  });

  // create the grid
  var orderGrid = Ext.create('Ext.grid.Panel', {
    store: store,
    columnLines: true,
    minHeight: 500,
    columns: [
      {xtype: 'rownumberer'},
      {text: "编号", dataIndex: 'id', sortable: true},
      {text: "预约人", dataIndex: 'fullname'},
      {text: "车牌", dataIndex: 'store_customer_first_name'},
      {text: "联系电话", dataIndex: 'store_customer_first_name'},
      {text: "约定时间", dataIndex: 'store_customer_first_name'},
      {text: "约定项目", dataIndex: 'store_customer_first_name'},
      {text: "制单", dataIndex: 'store_customer_first_name'},
      {text: "状态", dataIndex: 'store_customer_first_name'},
      {text: "备注", dataIndex: 'store_customer_first_name'},
      {
        text: "操作",
        xtype: "myactioncolumn",
        items: [{
          glyph: "lnr lnr-edit",
          handler: function(grid, rowIndex, colIndex){
            console.log(rowIndex);
          },
        }]

      }
    ],
    forceFit: true,
    layout: 'fit',
    split: true,
    region: 'north',
    bbar: {xtype: "pagingtoolbar", store: store, displayInfo: true}
  });

  // define a template to use for the detail view
  var bookTplMarkup = [
    'Title: <a href="{DetailPageURL}" target="_blank">{Title}</a><br/>',
    'Author: {Author}<br/>',
    'Manufacturer: {Manufacturer}<br/>',
    'Product Group: {ProductGroup}<br/>'
  ];
  var bookTpl = Ext.create('Ext.Template', bookTplMarkup);

  Ext.create('Ext.Panel', {
    renderTo: 'pre-order-main',
    frame: true,
    title: '订单列表',
    width: "100%",
    layout: 'fit',
    items: [orderGrid]
  });

  // update panel body on selection change
  //orderGrid.getSelectionModel().on('selectionchange', function(sm, selectedRecord) {
    //if (selectedRecord.length) {
      //var detailPanel = Ext.getCmp('detailPanel');
      //detailPanel.update(bookTpl.apply(selectedRecord[0].data));
    //}
  //});

  store.load();
});
