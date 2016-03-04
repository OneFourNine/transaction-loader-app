module ApplicationHelper
  def current_tenant
    tenant_name = session[:TENANT_ID]
    Tenant.find_by(name: tenant_name)
  end

  def current_user
    session[:user_key]
  end
end
