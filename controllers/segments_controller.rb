# frozen_string_literal: true

class Admin::SegmentsController < Admin::BaseController
  before_action :set_segment, only: [:show]

  def index
    add_breadcrumb I18n.t("index.title", scope: i18n_scope), admin_segments_path
    @segments = current_shop.segments.decorate
  end

  def show
    add_breadcrumb I18n.t("index.title", scope: i18n_scope), admin_segments_path
    add_breadcrumb @segment.name, admin_segment_path(@segment)
  end

  private

  def set_segment
    @segment = current_shop.segments.find(params[:id]).decorate
    @visitors = @segment.visitors.decorate
  end
end
