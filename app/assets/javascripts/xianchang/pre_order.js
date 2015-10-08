Ext.onReady(function(){
  if($("#pre-order-main").length <= 0)
    return;

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
    minHeight: 600,
    dockedItem: [
      {
        xtype: "toolbar",
        dock: "top",
        items: [
          { text: "你哈ahshshdajsdasd" }
        ]
      }
    ],
    columns: [
      {text: "#", xtype: 'rownumberer', width: 50},
      {text: "预约人", dataIndex: 'fullname', sortable: false},
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
          handler: function(grid, rowIndex, colIndex){}
        },
        {
          glyph: "lnr lnr-pencil",
          handler: function(grid, rowIndex, colIndex){}
        },{
          glyph: "lnr lnr-file-empty",
          handler: function(grid, rowIndex, colIndex){}
        },{
          glyph: "lnr lnr-trash",
          handler: function(grid, rowIndex, colIndex){}
        }]
      }
    ],
    forceFit: true,
    layout: 'fit',
    split: true,
    region: 'north',
    bbar: {xtype: "pagingtoolbar", store: store, displayInfo: true}
  });

  Ext.create('Ext.Panel', {
    renderTo: 'pre-order-main',
    frame: true,
    width: "100%",
    layout: 'fit',
    items: [
      {
        bodyPadding: 5,
        layout: {
          type: "box"
        },
        items: [{
          emptyText: "输入手机和号码",
          labelAlign: "right",
          name: "phone",
          fieldLabel: "信息查询",
          xtype: "textfield"
        },{
          labelAlign: "right",
          name: "order_time",
          fieldLabel: "预约时间",
          xtype: "textfield"
        },{
          xtype: "button",
          margin: "0 0 0 10px",
          text: "查询",
          handler: function(){
            console.log("提交");
          }
        }]
      },
      //topBannerPanel,
      orderGrid
    ]
  });

  store.load();
});
