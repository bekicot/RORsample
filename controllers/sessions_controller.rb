# frozen_string_literal: true

class Admin::SessionsController < Admin::BaseController
  before_action :set_visitor, :set_segment

  def index
    add_breadcrumb I18n.t("admin.segments.index.title"), admin_segments_path
    add_breadcrumb @segment.name
    add_breadcrumb @visitor.full_name, admin_visitor_path(@segment, @visitor)
    add_breadcrumb I18n.t("index.title", scope: i18n_scope)

    @online_events = @visitor.events.joins(:sessions).merge(Session.online).decorate.uniq
  end

  private

  def set_segment
    @segment = current_shop.segments.find(params[:segment_id]).decorate
  end

  def set_visitor
    @visitor = current_shop.visitors.find(params[:visitor_id]).decorate
  end
end
