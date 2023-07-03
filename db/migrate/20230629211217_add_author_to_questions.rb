class AddAuthorToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :author
  end
end
