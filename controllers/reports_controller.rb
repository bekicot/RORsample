# frozen_string_literal: true

class Admin::ReportsController < Admin::BaseController
  def index
    add_breadcrumb I18n.t("index.title", scope: i18n_scope), admin_reports_path
    render "admin/system/maintenance"
  end
end
