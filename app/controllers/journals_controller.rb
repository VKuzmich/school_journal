class JournalsController < ApplicationController

  def index
    @grades = Grade.order('number ASC, letter')
  end

  def show
    # @grade = Grade.find_by_id(:id)
  end
end
