class Event < ApplicationRecord

  has_many :participations, dependent: :destroy
  belongs_to :user

  validates :duration, :title, :description, :price, :location, presence: true 
  validate :start_date_over_now
  validates :title, length: { in: 5..140 }  
  validate :start_date_over_now
  validates :description, length: { in: 20..1000 }
  validates :price, inclusion: { in: 1..1000 }




  def start_date_over_now
      start_date > Time.now
  end
  
  def five_modulo
    duration % 5 == 0 && duration > 0
  end
  
end
