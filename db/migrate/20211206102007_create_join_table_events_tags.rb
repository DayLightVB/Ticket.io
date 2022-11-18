class CreateJoinTableEventsTags < ActiveRecord::Migration[6.1]
  def change
    create_join_table :events, :tags do |t|
      t.index %i[event_id tag_id]
      t.index %i[tag_id event_id]
    end
  end
end
