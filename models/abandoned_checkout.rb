class AbandonedCheckout < ApplicationRecord
  has_paper_trail

  belongs_to :browser
  has_one :shop, through: :browser
  has_one :visitor, through: :browser

  validates :browser, presence: true
  validates :token, :cart_token, presence: true

  def sessions
    browser.sessions.where(id: session_ids)
  end
end
