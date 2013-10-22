class ChoicesController < ApplicationController

  def create
    @choice = Choice.new
  end

end