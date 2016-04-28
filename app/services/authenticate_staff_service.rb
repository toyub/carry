class AuthenticateStaffService
  include Serviceable
  include StatusObject

  delegate :mis_locked?, :app_locked?, :erp_locked?, to: :@user

  def initialize(user, password, options = {})
    @user = user
    @password = password
    @platform = options[:platform]
  end

  def password_correct?
    @user.encrypted_password == StoreStaff.encrypt_with_salt(@password, @user.salt)
  end

  def call
    return Status.new(success: false, notice: '用户名或密码错误') if !validated?
    return Status.new(success: false, notice: '用户已停用') if locked?
    return Status.new(success: false, notice: '该门店已停用,请联系管理员！') if store_closed?

    Status.new(success: true, notice: '登陆成功')
  end

  def validated?
    @user.present? && password_correct?
  end

  def locked?
    if @platform == "app"
      app_locked?
    elsif @platform == "erp"
      erp_locked?
    else
      mis_locked?
    end
  end

  def store_closed?
    !@user.store.available
  end


end
