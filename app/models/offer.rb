class Offer < ActiveRecord::Base
  tableless

  column :title, :string
  column :payout, :string
  column :thumbnail, :string
  column :link, :string
end
