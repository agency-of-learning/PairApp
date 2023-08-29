class AddLinksToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :twitter_link, :string
    add_column :profiles, :linked_in_link, :string
    add_column :profiles, :github_link, :string
    add_column :profiles, :personal_site_link, :string
  end
end
