class OffersRequest < ActiveRecord::Base
  tableless

  column :uid, :string
  column :pub0, :text
  column :page, :integer
end
