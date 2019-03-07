class Task < ApplicationRecord
  belongs_to :list
  validates :name, :description, presence: true

  def as_json(options={})
    super(
      :include => {list: {only: [:board_id]}}
    )
  end
end
