class JournalsController < ApplicationController

  def index
    @grades = Grade.order('number ASC, letter')
  end

  def show
  end
end
