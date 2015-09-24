Ext.require([
    'Ext.grid.*',
    'Ext.data.*',
    'Ext.panel.*',
    'Ext.layout.container.Border'
]);

Ext.onReady(function(){

  Ext.define('Order',{
      extend: 'Ext.data.Model',
      proxy: {
        type: 'ajax',
        url: "/api/orders"
      },
      fields: [
        { name: '编码', type: "string" },
      ]
  });

  // create the Data Store
  var store = Ext.create('Ext.data.Store', {
    model: 'Order',
  });

  // create the grid
  var grid = Ext.create('Ext.grid.Panel', {
    bufferedRenderer: false,
    store: store,
    columns: [
        {xtype: 'rownumberer'},
        {text: "Author", width: 120, dataIndex: 'Author', sortable: true},
        {text: "Title", flex: 1, dataIndex: 'Title', sortable: true},
        {text: "Manufacturer", width: 125, dataIndex: 'Manufacturer', sortable: true},
        {text: "Product Group", width: 125, dataIndex: 'ProductGroup', sortable: true}
    ],
    forceFit: true,
    height:210,
    split: true,
    region: 'north'
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
    height: 400,
    layout: 'border',
    items: [
      grid, {
        id: 'detailPanel',
        region: 'center',
        bodyPadding: 7,
        bodyStyle: "background: #ffffff;",
        html: '请添加Book'
    }]
  });

  // update panel body on selection change
  grid.getSelectionModel().on('selectionchange', function(sm, selectedRecord) {
    if (selectedRecord.length) {
      var detailPanel = Ext.getCmp('detailPanel');
      detailPanel.update(bookTpl.apply(selectedRecord[0].data));
    }
  });

  store.load();
});
