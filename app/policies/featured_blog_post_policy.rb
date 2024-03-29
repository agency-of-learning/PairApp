class FeaturedBlogPostPolicy < ApplicationPolicy
  alias_method :featured_post, :record

  def index?
    true
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user&.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
