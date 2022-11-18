class SearchController < ApplicationController
  def index
    @query = Event.ransack(params[:q])
    @events = @query.result(distinct: true)
  end
end