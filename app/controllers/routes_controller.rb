class RoutesController < ActionController::Base
  def route
    render({:template => "routes/index.html.erb"})
  end
  end