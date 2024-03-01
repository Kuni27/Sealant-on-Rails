# frozen_string_literal: true

# spec/controllers/child_level_details_controller_spec.rb
require 'rails_helper'

RSpec.describe ChildLevelDetailsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      child_detail = ChildLevelDetail.create(child_level_detail_params)
      get :show, params: { PID: child_detail.PID }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters and child detail with given PID does not exist' do
      it 'creates a new child level detail' do
        PatientDetail.create(patient_detail_params)

        expect do
          post :create, params: { child_level_detail: child_level_detail_params }
        end.to change(ChildLevelDetail, :count).by(1)
      end

      it 'redirects to the child_data path' do
        patient_detail = PatientDetail.create(patient_detail_params)
        post :create, params: { child_level_detail: child_level_detail_params }
        expect(response).to redirect_to("/child_data?patient_detail_id=#{patient_detail.PID}")
      end
    end

    context 'with valid parameters and child detail with given PID already exists' do
      it 'does not create a new child level detail' do
        PatientDetail.create(patient_detail_params)
        post :create, params: { child_level_detail: child_level_detail_params }

        expect do
          post :create, params: { child_level_detail: child_level_detail_params }
        end.to change(ChildLevelDetail, :count).by(0)
      end

      it 'redirects to the child_data path' do
        patient_detail = PatientDetail.create(patient_detail_params)
        post :create, params: { child_level_detail: child_level_detail_params }
        expect(response).to redirect_to("/child_data?patient_detail_id=#{patient_detail.PID}")
      end
    end

    context 'with invalid parameters and child detail with given PID already exists' do
      it 'does not create a new child level detail' do
        PatientDetail.create(patient_detail_params)
        post :create, params: { child_level_detail: child_level_detail_params }

        expect do
          post :create, params: { child_level_detail: invalid_child_level_detail_params }
        end.to change(ChildLevelDetail, :count).by(0)
      end

      it 'redirects to the child_data path' do
        patient_detail = PatientDetail.create(patient_detail_params)
        post :create, params: { child_level_detail: child_level_detail_params }
        expect(response).to redirect_to("/child_data?patient_detail_id=#{patient_detail.PID}")
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      PatientDetail.create(patient_detail_params)
      child_detail = ChildLevelDetail.create(child_level_detail_params)
      get :edit, params: { PID: child_detail.PID }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the child level detail' do
        PatientDetail.create(patient_detail_params)
        child_detail = ChildLevelDetail.create(child_level_detail_params)
        patch :update, params: { PID: child_detail.PID, child_level_detail: other_child_level_detail_params }
        expect(child_detail.reload.TeethScreening).to eq('false')
      end
    end

    context 'with invalid parameters' do
      it 'renders the edit template' do
        PatientDetail.create(patient_detail_params)
        child_detail = ChildLevelDetail.create(child_level_detail_params)
        patch :update, params: { PID: child_detail.PID, child_level_detail: invalid_child_level_detail_params }
        expect(response).to render_template(:edit)
      end
    end
  end

  # describe 'DELETE #destroy' do
  #   # it 'destroys the child level detail' do
  #   #   child_detail = ChildLevelDetail.create(child_level_detail_params)
  #   #   expect do
  #   #     delete :destroy, params: { PID: child_detail.PID, child_level_detail: child_level_detail_params }
  #   #   end.to change(ChildLevelDetail, :count).by(-1)
  #   # end
  #
  #   it 'redirects to child_level_details_url' do
  #     child_detail = ChildLevelDetail.create(child_level_detail_params)
  #     delete :destroy, params: { PID: child_detail.PID }
  #     expect(response).to redirect_to(child_level_details_url)
  #   end
  # end

  describe 'GET #child_data' do
    it 'returns a successful response' do
      patient_detail = PatientDetail.create(patient_detail_params)
      get :child_data, params: { patient_detail_id: patient_detail.id }
      expect(response).to be_successful
    end
  end

  private

  def child_level_detail_params
    {
      PID: '12-elementary',
      TeethScreening: true,
      TeethPreventative: true,
      TeethFollowup: true,
      PrescriberName: 'Sample Prescriber',
      ScreenDate: '2023-10-23',
      ScreenComment: 'Sample Comment',
      UntreatedCavities: 2,
      CarriesExperience: true,
      Sealants: false,
      ReferralS: 'Sample Referral',
      ProviderName: 'Sample Provider',
      ProviderDate: '2023-10-24',
      PreventComment: 'Sample Prevent Comment',
      FirstSealedNum: 1,
      SecondSealedNum: 2,
      OtherPermNum: 3,
      PrimarySealed: true,
      FluorideVarnish: false,
      EvaluatorsName: 'Sample Evaluator',
      EvaluatorDate: '2023-10-25',
      EvaluatorComment: 'Sample Evaluator Comment',
      RetainedSealant: false,
      ReferredDT: 'Sample ReferredDT',
      ReferredUDT: 'Sample ReferredUDT',
      SealantsRecd: true,
      SealnatsNeeded: false,
      Experienced: true,
      UntreatedDecayFollow: 'Sample Untreated Decay Follow',
      Services: 'Sample Services',
      ORHealthStatus: 'Sample Health Status'
    }
  end

  def other_child_level_detail_params
    {
      PID: '12-elementary',
      TeethScreening: false,
      TeethPreventative: false,
      TeethFollowup: false,
      PrescriberName: 'Sample Prescriber',
      ScreenDate: '2023-10-23',
      ScreenComment: 'Sample Comment',
      UntreatedCavities: 2,
      CarriesExperience: true,
      Sealants: false,
      ReferralS: 'Sample Referral',
      ProviderName: 'Sample Provider',
      ProviderDate: '2023-10-24',
      PreventComment: 'Sample Prevent Comment',
      FirstSealedNum: 1,
      SecondSealedNum: 2,
      OtherPermNum: 3,
      PrimarySealed: true,
      FluorideVarnish: false,
      EvaluatorsName: 'Sample Evaluator',
      EvaluatorDate: '2023-10-25',
      EvaluatorComment: 'Sample Evaluator Comment',
      RetainedSealant: false,
      ReferredDT: 'Sample ReferredDT',
      ReferredUDT: 'Sample ReferredUDT',
      SealantsRecd: true,
      SealnatsNeeded: false,
      Experienced: true,
      UntreatedDecayFollow: 'Sample Untreated Decay Follow',
      Services: 'Sample Services',
      ORHealthStatus: 'Sample Health Status'
    }
  end

  def invalid_child_level_detail_params
    {
      nonsens: 34_567,
      PID: '55-school'
    }
  end

  def patient_detail_params
    {
      PatientId: 12,
      ProgramName: 'Sample Program',
      SchoolName: 'elementary',
      Age: 10,
      Date: '2023-10-23',
      Insurance: 'Sample Insurance',
      Grade: 'Sample Grade',
      PID: '12-elementary',
      Gender: 'Sample Gender',
      Race: 'Sample Race',
      Ethnicity: 'Sample Ethnicity'
    }
  end
end
