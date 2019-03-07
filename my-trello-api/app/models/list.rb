class List < ApplicationRecord
  belongs_to :board
  has_many :tasks
  accepts_nested_attributes_for :tasks
  before_destroy :delete_all_tasks
  validates :name, presence: true

  def delete_all_tasks
    self.tasks.each do |task|
      task.destroy
    end
  end

  def board_change(identify)
    select_list = List.find(identify)
    self.board == select_list ? true : false
  end

end
