class Menu
  def self.menu_for_staff(staff)
    [{
      icon: 'fa-clock-o', name: '现场管理',shortcut: 'xianchang',
      second_menu: [
          {
            href: '1',
            name: '现场一',
            controller: '1',
            action: 'index'
          }
        ]
      },

      {
        icon: 'fa-calculator', name: '收银',shortcut: 'shouyin',
        second_menu: []
      },

      {
        icon: 'fa-user', name: 'CRM',shortcut: 'crm',
        second_menu: []
      },

      {
        icon: 'fa-shopping-cart', name: '销售管理',shortcut: 'xiaoshou',
        second_menu: []
      },

      {
        icon: 'fa-users', name: '员工管理',shortcut: 'yuangong',
        second_menu: []
      },

      {
        icon: 'fa-cubes', name: '库存',shortcut: 'kucun',
        second_menu: [
          {:href=>"/kucun/materials/", :controller=>"materials", :action=>"index", :name=>"库存列表"},
          {:href=>"/kucun/material_inventories/new", :controller=>"materials", :action=>"show", :name=>"入库"},
          {:href=>"/kucun/materials/", :controller=>"materials", :action=>"show", :name=>"出库"},
          {:href=>"/kucun/store_suppliers", :controller=>"kucun/store_suppliers", :action=>"index", :name=>"订货"},
          {:href=>"/kucun/materials/", :controller=>"materials", :action=>"show", :name=>"盘点"},
          {:href=>"/kucun/materials/", :controller=>"materials", :action=>"show", :name=>"报损"},
          {:href=>"/kucun/materials/", :controller=>"materials", :action=>"show", :name=>"退货"}
        ]
      },

      {
        icon: 'fa-jpy', name: '财务助手',shortcut: 'caiwu',
        second_menu: []
      },

      {
        icon: 'fa-line-chart', name: '统计分析',shortcut: 'tongji',
        second_menu: []
      },

      {
        icon: 'fa-cog', name: '系统设置',shortcut: 'sys_conf',
        second_menu: []
      }
    ]
  end
end
