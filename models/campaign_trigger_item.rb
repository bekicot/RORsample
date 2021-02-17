# frozen_string_literal: true

class CampaignTriggerItem < ApplicationRecord
  belongs_to :session
  belongs_to :source, polymorphic: true

  has_paper_trail

  has_one :browser, through: :session
  has_one :shop, through: :browser
  has_many :events, through: :session

  validates :session, :source, :scheduled_time, presence: true

  scope :executable_now, -> { where("scheduled_time <= ?", Time.now.utc).not_processed.where(failed_at: nil) }
  scope :subscribed, -> { joins(:browser).merge(Browser.subscribed) }
  scope :processed, -> { where.not(processed_at: nil) }
  scope :delivired, -> { processed }
  scope :not_processed, -> { where(processed_at: nil) }
  scope :failed, -> { where.not(failed_at: nil) }
  scope :not_failed, -> { where(failed_at: nil) }
end
