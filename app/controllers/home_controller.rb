class HomeController < ApplicationController

  def index
  end

  def project
  end

  def team
    @team = YAML::load(File.open(Rails.root.join('config', 'team.yml')))
  end

end