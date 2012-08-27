require 'radimotive'
require 'rails'
module Radimotive
  class Railtie < Rails::Railtie
    railtie_name :radimotive

    rake_tasks do
      load "tasks/radimotive.rake"
    end
  end
end
