# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    subject(:do_index) do
      get :index
    end

    context "when shop is authorized" do
      let!(:shop) { create(:shop) }

      before { authorize_shop(shop) }

      it "redirects to admin_root_url" do
        do_index
        expect(response).to redirect_to(admin_root_url)
      end
    end

    context "when shop is not authorized" do
      it "redirects to admin_root_url" do
        do_index
        expect(response).to redirect_to("/login")
      end
    end
  end
end
