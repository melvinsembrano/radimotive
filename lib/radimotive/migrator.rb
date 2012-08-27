require 'action_view/helpers/text_helper'
require 'radimotive/radiant_page'

module Radimotive
  class Migrator
    extend ActionView::Helpers::TextHelper

    # def self.init(config_file = File.join(Rails.root, 'config', 'radiant_db.yml'))
    def self.init(config_file = 'config/radiant_db.yml', env = 'development')
      if File.exist?(config_file)
        @config = YAML.load_file(config_file)[env]
        ActiveRecord::Base.establish_connection(@config)
      else
        raise "Radiant database configuration file now found"
      end
    end

    def self.migrate(slug, model_name)

      page = Radimotive::Radiant::Page.find_by_slug(slug)
      if page
        ct = Locomotive::ContentType.where(:name => model_name).first
        if ct
          ct.entries.where(:page_type => slug).delete_all
          page.children.each do |p|
            if p.published?
              puts "Migrating page #{p.title}..."
              en = ct.entries.build({
                :title => p.title,
                :excerpts => truncate(p.body, :length => 200),
                :body => p.body,
                :page_type => slug
              })
              en.save
            end
          end
        else
          puts "Locomotive model #{model_name} not yet created..."
        end
      else
        puts "Slug not found"
      end
    end
  end

end
