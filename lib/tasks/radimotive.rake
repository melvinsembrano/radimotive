namespace :radimotive do

  desc 'Migrate All content specify on a config file'
  task :migrate_all, [:config] => :environment do |t, args|
    args.with_defaults(:config => 'config/radimotive.yml')
    if File.exist?(args[:config])
      data = YAML.load_file(args[:config])

      Radimotive::Migrator.init
      data["contents"].each do |a,b|
        puts "Migrating contents from #{a}..."
        Radimotive::Migrator.migrate(a, b)
      end
      puts "DONE..."
    else
      puts "Radimotive file not found!"
    end
  end

  desc 'Migrate a Radiant page group to Locomotive CMS'
  task :migrate, [:page_group, :model_name] => :environment do |t, args|
    require 'radiant_to_locomotive/migrator'
    args.with_defaults(:page_group => nil, :model_name => nil)
    if args[:page_group].nil?
      puts "Invalid syntax! Please follow the proper syntax: `rake radimotive:migrate['blogs','Blog']`"
    else
      model_name = args[:model_name] || args[:page_group]

      Radimotive::Migrator.init
      puts "Migrating our-experience"
      Radimotive::Migrator.migrate(args[:page_group], model_name)
      puts "DONE..."
    end

  end
end

