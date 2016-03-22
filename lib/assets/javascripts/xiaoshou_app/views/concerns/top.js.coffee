Mis.Views.Concerns.Top =
  #included: ->
    #res = s.underscored(@::constructor.name).split("_")
    #resource = res[1]
    #subResource = res[2]
    #action = res[3]
    #@::redirect_url = "#store_#{resource}s" unless subResource == 'profiles' && action == 'index'
    #@::topTitle = "#{@::rootResourceName[resource]}#{@::subResourceName[subResource]}#{@::actionName[action]}"

  actionName:
    index: '列表'
    new: '新建'
    edit: '编辑'
    show: '详情'

  rootResourceName:
    service: '服务'
    package: '套餐'
    customer: '客户'

  subResourceName:
    profiles: '信息'
    settings: '设置'
    trackings: '回访设置'
    sales: '销售记录'


  renderTop: ->
    top = new Mis.Views.XiaoshouSharedTop(title: @topTitle(), redirect_url: @redirectUrl())
    @prependChild(top)

  topTitle: ->
    "#{@rootResourceName[@rootResource()]}#{@subResourceName[@subResource()]}#{@actionName[@action()]}"

  redirectUrl: ->
    "#store_#{@rootResource()}s" unless @subResource() == 'profiles' && @action() == 'index'

  showCommissionTemplate: (evt)->
    detail_tmpl = JST['kucun/commissions/new/detail']
    target = evt.target;
    select = $(target).siblings('select')[0]
    if select.value
      $.get '/api/store_commission_templates/' + select.value + '.json', (response) ->
        $("#commission_tempalte_detail").html(detail_tmpl(response)).show()
    else
      ZhanchuangAlert('请选择一个方案')
