class OffersRequest < ActiveRecord::Base
  tableless

  column :uid, :string, 'john'
  column :pub0, :text, ''
  column :page, :integer, 1

  validates_presence_of :uid, :page
  validates_numericality_of :page
end
