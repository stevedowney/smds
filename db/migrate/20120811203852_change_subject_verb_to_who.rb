class ChangeSubjectVerbToWho < ActiveRecord::Migration
  def up
    rename_column :quotes, :subject_verb, :who
  end

  def down
    rename_column :quotes, :who, :subject_verb
  end
end