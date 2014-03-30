class Offer < ActiveRecord::Base
  tableless

  column :title, :string
  column :payout, :string
  column :thumbnail, :string
  column :link, :string

  validates_presence_of :title, :payout, :thumbnail, :link
end
