class BaseController
  def initialize(resources_repository)
    @resources_repository = resources_repository
    @resources_view = view_class.new
  end

  def index
    resources = @resources_repository.all
    @resources_view.display(resources)
  end
end