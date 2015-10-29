# Clone 前端代码
class Capistrano::Git < Capistrano::SCM
  module DefaultStrategy
    def html_clone
      git :clone, "-b #{fetch(:html_branch)}", fetch(:repo_html_url), fetch(:html_project_name)
    end
  end
end

class Capistrano::Configuration::Server < SSHKit::Host
  # 发版显示端口
  def to_s
    hostname + ':' + port.to_s
  end
end
