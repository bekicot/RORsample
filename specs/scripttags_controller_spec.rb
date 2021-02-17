# frozen_string_literal: true

require "rails_helper"

RSpec.describe ScripttagsController, type: :controller do
  describe "GET #main_script" do
    subject(:get_main_script) do
      get :main_script, params: { uid: uid }, format: :js
    end
    let(:uid) { "bla-bla" }

    context "when there is no shop with such uid" do
      it "renders main_script.js template" do
        get_main_script
        expect(response).to render_template("empty_main_script.js.erb")
      end
    end

    context "when there is shop with such uid" do
      let!(:shop) { create(:shopify_shop) }
      let(:uid) { shop.uid }

      it "returns 200" do
        get_main_script
        expect(response).to have_http_status(200)
      end

      it "renders main_script.js template" do
        get_main_script
        expect(response).to render_template("main_script.js.erb")
      end
    end
  end
end
