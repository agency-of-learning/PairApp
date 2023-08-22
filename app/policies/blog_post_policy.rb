class BlogPostPolicy < ApplicationPolicy
  alias_method :blog_post, :record

  def show?
    true
  end

  def create?
    true
  end

  def update?
    user == blog_post.user
  end

  def destroy?
    user == blog_post.user
  end

  def feature?
    return false unless user&.admin?

    !blog_post.featured? && blog_post.published?
  end
end
