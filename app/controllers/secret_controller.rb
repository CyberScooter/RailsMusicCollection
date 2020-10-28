class SecretController < ApplicationController

  before_action :authorized, only: [:new]

  def new
  end
end
