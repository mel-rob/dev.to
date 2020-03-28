class AddArticleIdToAhoyMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :ahoy_messages, :article_id, :integer
  end
end
