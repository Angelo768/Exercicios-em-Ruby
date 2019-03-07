class Board < ApplicationRecord

  has_many :lists, :dependent => :destroy
  after_create :create_list
  accepts_nested_attributes_for :lists
  validates :name, presence: true

  def create_list
    List.create(name: "TO DO", board_id: self.id)
    List.create(name: "DOING", board_id: self.id)
    List.create(name: "DONE", board_id: self.id)
  end

  def as_json(options={})
    super(
      :include => {:lists => {:include =>
                  {:tasks => {:except => [:created_at, :updated_at]}},
                   :except => [:created_at, :updated_at]
                 }
               }, root: true
    )
  end

end
