Ext.onReady(function(){
  if($("#pre-order-main").length <= 0)
    return;

  Ext.define('StoreOrder',{
    extend: 'Ext.data.Model',
    fields: [
      "id",
      { name: "fullname", mapping: "store_customer.full_name" },
      { name: "store_vehicle_license_number", mapping: "store_vehicle.license_number" },
      { name: "store_customer_phone_number", mapping: "store_customer.phone_number" },
      "subscribe_date",
      "order_type",
      "state",
      "remark"
    ]
  });

  // create the Data Store
  var store = Ext.create('Ext.data.Store', {
    model: 'StoreOrder',
    proxy: {
      type: 'ajax',
      url: "/api/store_subscribe_orders"
    },
  });

  var topBannerPanel = Ext.create("Ext.panel.Panel", {
    bodyPadding: 5,
    layout: {
      type: "box"
    },
    items: [{
      emptyText: "输入车牌或电话",
      labelAlign: "right",
      fieldLabel: "信息查询",
      id: "phone_or_number",
      xtype: "textfield",
      fieldStyle: {
        color: "#717171"
      }
    },{
      labelAlign: "right",
      fieldLabel: "预约时间",
      id: "order_time",
      xtype: "textfield"
    },{
      xtype: "button",
      margin: "0 0 0 10px",
      text: "查询",
      handler: function(){
        var phone = Ext.getCmp("phone_or_number").getValue();
        var orderTime = Ext.getCmp("order_time").getValue();
        if(phone == "")
          console.log("空的");
        store.load({ params: { phone: phone }});
      }
    }]
  })

  // create the grid
  var orderGrid = Ext.create('Ext.grid.Panel', {
    store: store,
    columnLines: true,
    minHeight: 600,
    columns: [
      {text: "#", xtype: 'rownumberer', width: 50},
      {text: "预约人", dataIndex: 'fullname', sortable: false},
      {text: "车牌", dataIndex: 'store_vehicle_license_number'},
      {text: "联系电话", dataIndex: 'store_customer_phone_number'},
      {text: "约定时间", dataIndex: 'subscribe_date'},
      {text: "约定项目", dataIndex: 'store_customer_first_name'},
      {text: "制单", dataIndex: 'order_type'},
      {text: "状态", dataIndex: 'state'},
      {text: "备注", dataIndex: 'remark', width: 150},
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
    split: true,
    bbar: {xtype: "pagingtoolbar", store: store, displayInfo: true}
  });

  Ext.create('Ext.Panel', {
    renderTo: 'pre-order-main',
    frame: true,
    width: "100%",
    items: [
      topBannerPanel,
      orderGrid
    ]
  });
  store.load();
});
