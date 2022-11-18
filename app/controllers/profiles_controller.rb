# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_role = current_user.roles.distinct.pluck(:name).join('  ').humanize
  end
end
