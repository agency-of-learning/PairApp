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
end
