class Account::GroupsController < ApplicationController
  def index
    @groups = current_user.group
  end 
end
