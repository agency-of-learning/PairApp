class FeaturedBlogPostPolicy < ApplicationPolicy
  alias_method :featured_post, :record

  def index?
    true
  end

  def create?
    user.admin? && featured_post.new_record? && featured_post.blog_post.published?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
