require "pry-byebug"

require_relative "app/repositories/meals_repository"
require_relative "app/repositories/customers_repository"
require_relative "app/repositories/employees_repository"
require_relative "app/repositories/orders_repository"

require_relative "app/controllers/meals_controller"
require_relative "app/controllers/customers_controller"
require_relative "app/controllers/orders_controller"

require_relative "app/router"

MEALS_CSV_FILE = File.join(File.dirname(__FILE__), "app/data/meals.csv")
CUSTOMERS_CSV_FILE = File.join(File.dirname(__FILE__), "app/data/customers.csv")
EMPLOYEES_CSV_FILE = File.join(File.dirname(__FILE__), "app/data/employees.csv")
ORDERS_CSV_FILE = File.join(File.dirname(__FILE__), "app/data/orders.csv")

meals_repository = MealsRepository.new(MEALS_CSV_FILE)
customers_repository = CustomersRepository.new(CUSTOMERS_CSV_FILE)
employees_repository = EmployeesRepository.new(EMPLOYEES_CSV_FILE)
orders_repository = OrdersRepository.new(ORDERS_CSV_FILE, employees_repository, customers_repository, meals_repository)

meals_controller = MealsController.new(meals_repository)
customers_controller = CustomersController.new(customers_repository)
sessions_controller = SessionsController.new(employees_repository)
orders_controller = OrdersController.new(orders_repository, sessions_controller)

router = Router.new(meals_controller, sessions_controller, customers_controller, orders_controller)

router.run