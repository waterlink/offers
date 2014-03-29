module Tableless
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def tableless
      extend TablelessDsl
    end
  end

  module TablelessDsl
    def columns
      @columns ||= []
    end

    def column(name, sql_type = nil, default = nil, null = true)
      columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
    end
  end
end

class ActiveRecord::Base
  include Tableless
end

