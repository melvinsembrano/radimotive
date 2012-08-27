require 'mysql2'
require 'active_record'

module Radimotive
  module Radiant

    class Page < ActiveRecord::Base
      has_many :page_parts

      def body
        if page_parts && page_parts.first
          page_parts.first.content
        else
          ""
        end
      end

      def children
        Page.where(:parent_id => self.id)
      end

      def published?
        status_id == 100
      end
    end

    class PagePart < ActiveRecord::Base
      belongs_to :page
    end

  end
end
