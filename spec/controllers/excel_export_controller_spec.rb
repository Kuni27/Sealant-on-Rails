# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExcelExportsController, type: :controller do
  describe 'export_child_level_details' do
    it 'responds with success and sends the Excel file' do
      get :export_child_level_details
      expect(response).to have_http_status(:success)
      expect(response.header['Content-Type']).to eq 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      expect(response.header['Content-Disposition']).to match(/^attachment; filename="ChildLevelDetails\.xlsx"/)
    end
  end

  describe 'export_event_details' do
    it 'responds with success and sends the Excel file' do
      get :export_event_details
      expect(response).to have_http_status(:success)
      expect(response.header['Content-Type']).to eq 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      expect(response.header['Content-Disposition']).to match(/^attachment; filename="EventDetails\.xlsx"/)
    end
  end
end
