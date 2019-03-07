class Contact < ApplicationRecord

  #Validations
  validates :name, :email, :birthdate, presence: true
  #Associations
  belongs_to :kind
  has_many :phones
  has_one :address

  # For add nested attributes
  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address, allow_destroy: true

  # def as_json(options={})
  #   h = super(options)
  #   h[:birthdate] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
  #   h
  # end

  def as_json(options={})
    super(
      root: true,
      include: {kind: {only: [:description]},
      address: {only: [:id, :street, :city]},
      phones: {only: [:id, :number]}}
    )
  end

end
