class PagesController < ApplicationController
  #skip_before_action :authenticate_user!, only: [ :home, :contact]

  def home
    if params[:query].present?
      @meals_by_name = Meal.search_by_name_or_description(params[:query])
      @meals_by_ingredients = Meal.search_by_ingredient(params[:query]) - @meals_by_name
    else
      @meals_by_name = Meal.all
      @meals_by_ingredients = []
    end
  end


  def contact
    @members = ["anastasia", "kai", "henrique"]
  end
end
