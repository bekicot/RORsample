# frozen_string_literal: true

class Admin::RegularCampaignsController < Admin::BaseController
  def index
    add_breadcrumb I18n.t("index.title", scope: i18n_scope), admin_regular_campaigns_path
    @regular_campaigns = current_shop.regular_campaigns.decorate
  end

  def new
    add_breadcrumb I18n.t("index.title", scope: i18n_scope), admin_regular_campaigns_path
    add_breadcrumb I18n.t("new.title", scope: i18n_scope), new_admin_regular_campaign_path
    @regular_campaign = current_shop.regular_campaigns.new(segment_id: params[:segment_id]).decorate
  end

  def create
    add_breadcrumb I18n.t("index.title", scope: i18n_scope), admin_regular_campaigns_path
    add_breadcrumb I18n.t("new.title", scope: i18n_scope), new_admin_regular_campaign_path

    @regular_campaign = current_shop.regular_campaigns.new
    @launch_form = Admin::RegularCampaign::LaunchForm.new(regular_campaign_params.merge(regular_campaign: @regular_campaign))

    respond_to do |format|
      if @launch_form.save
        format.html { redirect_to admin_regular_campaigns_path }
      else
        @regular_campaign = @launch_form.regular_campaign_decorator
        format.html { render :new }
      end
      format.js
    end
  end

  private

  def launch_campaign_params
    regular_campaign_params[:message_data].merge(regular_campaign: @regular_campaign)
  end

  def regular_campaign_params
    params.require(:regular_campaign).permit(:name, :segment_id, :send_now, :image, :with_discount_code, message_data: [:body, :title, :link, :scheduled_date, :scheduled_time, actions: %i(label url)], discount_data: %i(code countdown_time countdown_position countdown_title button_text background_color color button_background_color button_color)).tap do |result|
      result[:message_data][:actions] = Array.wrap(result[:message_data][:actions])
    end
  end
end
