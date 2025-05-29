module ApplicationHelper
  def show_internal_navbar?
    (controller_name == "users" && action_name == "show") ||
    (controller_name == "meals" && action_name == "my_meals") ||
    (controller_name == "exchanges" && action_name == "exchanges_dashboard")
  end
end
