namespace :db do
  desc "Drop, create, migrate then seed the database"
  task :seed => :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    #Rake::Task['db:fixtures:load'].invoke
    Zone.create(:name => 'Zone 1 (Oceanside-Solana Beach)')
    Zone.create(:name => 'Zone 2 (Sorrento Valley)')
    Zone.create(:name => 'Zone 3 (Old Town-Santa Fe Depot')

    Station.create(:name => 'Oceanside Transit Center', :address => '195 S. Tremont St.', :city => 'Oceanside', :state => 'CA', :zip => '92054')
    Station.create(:name => 'Carlsbad Village', :address => '2775 State St.', :city => 'Carlsbad', :state => 'CA', :zip => '92008')
    Station.create(:name => 'Carslbad Poinsettia', :address => '6511 Avenida Encinas', :city => 'Carlsbad', :state => 'CA', :zip => '92009')
    Station.create(:name => 'Encinitas', :)
  end
end