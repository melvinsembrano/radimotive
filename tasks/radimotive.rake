namespace :radimotive do

  desc 'test migrate from Radiant to Locomotive CMS'
  task :migrate => :environment do
    require 'radiant_to_locomotive/migrator'

    RadiantToLocomotive::Migrator.init
    puts "Migrating our-experience"
    RadiantToLocomotive::Migrator.migrate('our-experience', 'Articles')
    puts "DONE..."

    puts "Migrating our-services"
    RadiantToLocomotive::Migrator.migrate('our-services', 'Articles')
    puts "DONE..."

  end
end

