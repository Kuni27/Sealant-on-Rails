# frozen_string_literal: true

json.array! @child_level_details, partial: 'child_level_details/child_level_detail', as: :child_level_detail
