class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :contact]

  def home
  end

  def contact
    @members = ["anastasia", "kai", "henrique"]
  end
end
