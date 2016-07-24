require_relative "../views/sessions_view"

class SessionsController
  attr_reader :current_user

  def initialize(employees_repository)
    @employees_repository = employees_repository
    @sessions_view = SessionsView.new
  end

  def log_in
    username = @sessions_view.ask_for("username")
    password = @sessions_view.ask_for("password")

    @current_user = @employees_repository.find_by_username(username)
    if @current_user && @current_user.password == password
      print `clear`
      if @current_user.manager?
        @sessions_view.welcome_manager(@current_user)
      elsif @current_user.undelivered_orders.empty?
        @sessions_view.welcome_delivery_guy_without_orders(@current_user)
      else
        @sessions_view.welcome_delivery_guy(@current_user)
      end
      return @current_user
    else
      print `clear`
      @sessions_view.wrong_credentials
      log_in
    end
  end
end