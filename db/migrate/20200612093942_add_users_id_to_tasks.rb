class AddUsersIdToTasks < ActiveRecord::Migration[5.2]
  	def up
  		execute 'DELETE FROM tasks;'
  		# executeでの'DELETE FROM tasks;'のSQLにより、今まで作られたタスクがすべて削除
  		add_reference :tasks, :user, null: false, index: true
  	end

  	def down
  		remove_reference :tasks, :user, index: true
  	end
end
