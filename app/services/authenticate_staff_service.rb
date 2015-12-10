class AuthenticateStaffService
  include Serviceable
  include StatusObject

  delegate :locked?, to: :@user

  def initialize(user, password)
    @user = user
    @password = password
  end

  def password_correct?
    @user.encrypted_password == StoreStaff.encrypt_with_salt(@password, @user.salt)
  end

  def call
    return Status.new(success: false, notice: '用户名或密码错误') if !validated?
    return Status.new(success: false, notice: '用户已停用') if locked?

    Status.new(success: true, notice: '登陆成功')
  end

  def validated?
    @user.present? && password_correct?
  end
end
