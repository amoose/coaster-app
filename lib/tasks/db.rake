namespace :db do
  desc "setup, create, migrate then seed the database"
  task :seed => :environment do
    Rake::Task['db:setup'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke

    seed = YAML.load(ERB.new(File.read(File.join(Rails.root, 'config', 'trains.yml'))).result).symbolize_keys

    seed[:zones].each do |zone|
        Zone.create(:name => zone.second['name'])
    end

    seed[:stations].each do |station|

        Station.create(
                :name => station.first,
                :address => station.last['address'],
                :city => station.last['city'],
                :state => station.last['state'],
                :zip => station.last['zip'].to_s,
                :zone => Zone.find(station.last['zone'])
            )

            station.last['trains'].each do |train|
                # binding.pry
                Train.create(
                    :name => train.first,
                    :departure_time => Time.parse(train.last['departure_time']),
                    :direction => train.last['direction'],
                    :station => Station.find_by_name(station.first),
                    :recurring => train.last['recurring'],
                    :completed => train.last['completed'],
                    :recurring_value => train.last['recurring_value']
                )
        end
    end

    User.create(:name => 'amos', :email => 'a+admin@tynsax.com', :password => 'foobar', :password_confirmation => 'foobar', :admin => true)
    User.create(:name => 'moose', :email => 'a+moose@tynsax.com', :password => 'foobar', :password_confirmation => 'foobar', :admin => false)
  end


  desc "setup, create, migrate then seed the database"
  task :seed_heroku => :environment do
    Rake::Task['db:setup'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke

    seed = YAML.load(ERB.new(File.read(File.join(Rails.root, 'config', 'trains2.yml'))).result).symbolize_keys

    seed[:zones].each do |zone|
        Zone.create(:name => zone.second['name'])
    end

    seed[:stations].each do |station|

        Station.create(
                :name => station.first,
                :address => station.last['address'],
                :city => station.last['city'],
                :state => station.last['state'],
                :zip => station.last['zip'].to_s,
                :zone => Zone.find(station.last['zone'])
            )

            station.last['trains'].each do |train|
                # binding.pry
                Train.create(
                    :name => train.first,
                    :departure_time => Time.parse(train.last['departure_time']),
                    :direction => train.last['direction'],
                    :station => Station.find_by_name(station.first),
                    :recurring => train.last['recurring'],
                    :completed => train.last['completed'],
                    :recurring_value => train.last['recurring_value']
                )
        end
    end

    User.create(:name => 'amos', :email => 'a+admin@tynsax.com', :password => 'foobar', :password_confirmation => 'foobar', :admin => true)
    User.create(:name => 'moose', :email => 'a+moose@tynsax.com', :password => 'foobar', :password_confirmation => 'foobar', :admin => false)
  end
end