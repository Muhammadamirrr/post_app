# frozen_string_literal: true

class PostsDashboardController < ApplicationController
  before_action :authenticate_user!

  def index; end
end
