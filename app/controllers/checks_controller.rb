class ChecksController < ApplicationController

  def index
    @checks = Check.all
  end

  def create
    @check = Check.create(check_name: params[:check_name], check_hostname: params[:check_hostname])
    redirect_to "/checks/#{@check.id}"
  end

  def new
  end

  def show
    @check = Check.find(params[:id])
    auth = {:username => 'stuff@logi-tek.net', :password => 'tina2000'}
    query = {'host' => @check.check_hostname, 'type' => 'http'}
    response = HTTParty.get('https://api.pingdom.com/api/2.0/single', headers: {"app-key" => "2j7igy6801oc1cw1yrm0xyozbsmx9p97"}, :basic_auth => auth, :query => query).body
    @checks = JSON.parse(response).to_h
  end

end