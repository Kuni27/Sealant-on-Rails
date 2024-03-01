# frozen_string_literal: true

class EventDetail < ApplicationRecord
  validates :EventDate, presence: false, allow_blank: true
  validates :School, presence: false, allow_blank: true
  validates :ConsentFD, presence: false, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
  validates :DenHrs, presence: false, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
  validates :DenTravelHrs, presence: false, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
  validates :DenTravelMil, presence: false, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
  validates :HygHours, presence: false, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
  validates :HygTravelMil, presence: false, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
  validates :HygTravelHrs, presence: false, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
  validates :AssistantTravelMil, presence: false, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
  validates :AssistantHrs, presence: false, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
  validates :AssistantTravelHrs, presence: false, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
  validates :OtherHrs, presence: false, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
  validates :OtherTravelHrs, presence: false, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
  validates :OtherTravelMiles, presence: false, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
  validates :NumberOfSSPDriven, presence: false, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
  validates :TotalMilesDriven, presence: false, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
  # Not needed in event details page
  validates :ChildScreened, presence: false, allow_blank: true
  validates :ChildReceivingSealant, presence: false, allow_blank: true
  validates :NumberOfSealed, presence: false, allow_blank: true
  validates :NumberFlourideVarnish, presence: false, allow_blank: true
  validates :NumberProphy, presence: false, allow_blank: true
end
