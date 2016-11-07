module UsersHelper

  def provider_type(type)
    if type.is_a? User
      type = type.provider_type
    end

    case type
    when DatabaseMain::User::PROVIDER_TYPE_DIRECT
      '直販'
    when DatabaseMain::User::PROVIDER_TYPE_OEM
      'OEM'
    when DatabaseMain::User::PROVIDER_TYPE_AGENCY
      '代理店'
    end
  end

  def user_status(status)
    if status.is_a? User
      status = status.status
    end

    case status
    when DatabaseMain::User::STATUS_ENABLED
      '有効'
    when DatabaseMain::User::STATUS_DISABLED
      '無効'
    end
  end

  def user_notice(user)
    case user.display_notice
    when 1
      'あり'
    else
      'なし'
    end
  end

  def user_role(role_type)
    case role_type
    when Role::TYPE_ADMIN
      '管理者'
    when Role::TYPE_PROVIDER
      '代理店'
    when Role::TYPE_OWNER
       'レコメンドオーナー'
    when Role::TYPE_ADMIN_ACCOUNTING
        '経理担当者'
    end
  end
  
  def user_status_iconcss(status)
    if status.is_a? User
      status = status.status
    end

    case status
    when DatabaseMain::User::STATUS_ENABLED
      'btn btn-info'
    when DatabaseMain::User::STATUS_DISABLED
      'btn btn-danger'
    end
  end

end
