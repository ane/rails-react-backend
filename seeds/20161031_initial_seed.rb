# coding: utf-8


Sequel.seed(:development, :test) do
  def run
    artists = [
      {:name => "Øystein Aarseth", :instrument => "Guitar", :arsonist => true},
      {:name => "Per Yngve Ohlin", :instrument => "Lyrics", :arsonist => true},
      {:name => "Attila Csihar", :instrument => "Vocals", :arsonist => false},
      {:name => "Varg Vikernes", :instrument => "Bass", :arsonist => true},
      {:name => "Jan Axel Blomberg", :instrument => "Drums", :arsonist => false}
    ].each do |artist|
      Artist.create artist
    end
  end
end
