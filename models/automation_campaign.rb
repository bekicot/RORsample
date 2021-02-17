# frozen_string_literal: true

class AutomationCampaign < ApplicationRecord
  STATUSES = %w(pending started).freeze
  TYPES = %w(custom abandoned_cart).freeze

  has_paper_trail

  belongs_to :shop
  has_many :attempts, -> { ordered_by_position }, class_name: "AutomationCampaigns::Attempt", dependent: :destroy
  has_many :campaign_trigger_items, through: :attempts

  has_many :browsers, through: :campaign_trigger_items
  has_many :sessions, through: :campaign_trigger_items
  has_many :events, through: :sessions

  validates :name, :status, :kind, :shop, presence: true
  validates :name, uniqueness: { scope: :shop_id }
  validates :status, inclusion: STATUSES
  validates :kind, inclusion: TYPES

  scope :abandoned_cart, -> { where(kind: "abandoned_cart") }

  STATUSES.each do |mth|
    scope mth, -> { where(status: mth) }

    define_method "#{mth}?" do
      status == mth
    end

    define_method "#{mth}!" do
      update!(status: mth)
    end
  end

  alias_method :start!, :started!
end
