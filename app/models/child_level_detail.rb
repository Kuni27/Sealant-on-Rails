# frozen_string_literal: true

class ChildLevelDetail < ApplicationRecord
  self.primary_key = 'PID'

  belongs_to :patient_detail, foreign_key: 'PID', primary_key: 'PID'
end
