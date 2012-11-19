namespace :db do
  desc "Drop, create, migrate then seed the database"
  task :seed => :environment do
    #Rake::Task['db:drop'].invoke
    Rake::Task['db:setup'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    #Rake::Task['db:fixtures:load'].invoke
    Zone.create(:name => 'Zone 1 (Oceanside-Solana Beach)')
    Zone.create(:name => 'Zone 2 (Sorrento Valley)')
    Zone.create(:name => 'Zone 3 (Old Town-Santa Fe Depot)')

    Station.create(:name => 'Oceanside Transit Center', :address => '195 S. Tremont St.', :city => 'Oceanside', :state => 'CA', :zip => '92054', :zone => Zone.first)
    Station.create(:name => 'Carlsbad Village', :address => '2775 State St.', :city => 'Carlsbad', :state => 'CA', :zip => '92008', :zone => Zone.first)
    Station.create(:name => 'Carslbad Poinsettia', :address => '6511 Avenida Encinas', :city => 'Carlsbad', :state => 'CA', :zip => '92009', :zone => Zone.first)
    Station.create(:name => 'Encinitas', :address => '25 East D St.', :city => 'Encinitas', :state => 'CA', :zip => '92024', :zone => Zone.first)
    Station.create(:name => 'Solana Beach', :address => '105 N. Cedros Ave.', :city => 'Solana Beach', :state => 'CA', :zip => '92075', :zone => Zone.second)
    Station.create(:name => 'Sorrento Valley', :address => '11170 Sorrento Valley Rd.', :city => 'San Diego', :state => 'CA', :zip => '92121', :zone => Zone.last)
    Station.create(:name => 'Old Town (San Diego)', :address => '4005 Taylor St.', :city => 'San Diego', :state => 'CA', :zip => '92110', :zone => Zone.last)
    Station.create(:name => 'Sante Fe Depot (San Diego)', :address => '1050 Kettner Blvd.', :city => 'San Diego', :state => 'CA', :zip => '92101', :zone => Zone.last)



    User.create(:name => 'amos', :email => 'amos@amosarts.com', :password => 'fooper', :password_confirmation => 'fooper', :admin => true)
  end
end