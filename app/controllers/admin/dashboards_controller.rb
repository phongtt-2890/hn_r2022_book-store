class Admin::DashboardsController < Admin::AdminController
  authorize_resource class: false

  def home; end
end
