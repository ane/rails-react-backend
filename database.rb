require 'sinatra'
require 'sinatra/sequel'
require 'sequel'
require 'sequel/extensions/seed'

set :database, 'sqlite://blah.sqlite3'

puts "Creating table because it doesn't exist" if !database.table_exists?('artists')

Sequel.extension :seed
Sequel::Seed.setup(:development)

migration "Create artist table" do
  database.create_table :artists do
    primary_key :id
    varchar     :name
    varchar     :instrument
    integer     :arsonist, :default => true
  end

end

Sequel::Model.plugin :json_serializer 

class Artist < Sequel::Model
  plugin :json_serializer
  def validate
    super
    errors.add(:name, "can't be empty") if name.empty?
    errors.add(:instrument, "can't be empty") if instrument.empty?
  end
end


Sequel::Seeder.apply(database, './seeds')
