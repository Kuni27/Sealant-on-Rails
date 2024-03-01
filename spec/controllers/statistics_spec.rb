require 'rails_helper'

RSpec.describe StatisticsController, type: :controller do
  describe 'GET #index' do
    it 'assigns statistics_data' do
      patient_detail = PatientDetail.create!(PID: 456, PatientId: 1, SchoolName: 'Test School', Date: Date.today,
                                             Age: 10, Grade: 5, Insurance: 'bhvyv')

      get :index

      expect(assigns(:statistics_data)).to include(patient_detail)
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template('index')
    end

    it 'handles empty statistics_data' do
      # Test when there is no PatientDetail in the database
      get :index

      expect(assigns(:statistics_data)).to be_empty
    end
  end

  # describe 'GET #schoolStats' do
  #   it 'assigns school_data' do
  #     patient_detail = PatientDetail.create!(PID: 454, PatientId: 1, SchoolName: 'Test School', Date: Date.today,
  #                                            Age: 112, Grade: 7, Insurance: 'fgfgfg')
  #     ChildLevelDetail.create!(patient_detail: patient_detail, FirstSealedNum: 1)

  #     get :schoolStats

  #     expect(assigns(:school_data)).not_to be_empty
  #   end
  # end

  describe 'GET #school' do
    it 'assigns school_data and chart_data1' do
      patient_detail = PatientDetail.create!(PID: 234, PatientId: 7, SchoolName: 'Test Schoolm', Date: Date.today,
                                             Age: 19, Grade: 8, Insurance: 'ffffv')
      ChildLevelDetail.create!(patient_detail: patient_detail, FirstSealedNum: 1)

      get :school

      expect(assigns(:school_data)).not_to be_empty
      expect(assigns(:chart_data1)).not_to be_empty
    end
  end

  describe 'GET #event' do
    it 'assigns event_data and chart_data_con_forms' do
      EventDetail.create!(
        EventDate: Date.today,
        School: 'Test School',
        ConsentFD: 1,
        DenHrs: 2.5,
        DenTravelHrs: 1.5,
        DenTravelMil: 50.0,
        HygHours: 1.0,
        HygTravelMil: 30.0,
        HygTravelHrs: 0.5,
        AssistantTravelMil: 20.0,
        AssistantHrs: 1.0,
        AssistantTravelHrs: 0.3,
        OtherHrs: 0.8,
        OtherTravelHrs: 0.2,
        OtherTravelMiles: 10.0,
        NumberOfSSPDriven: 2,
        TotalMilesDriven: 80.0,
        ChildScreened: 50.0,
        ChildReceivingSealant: 30.0,
        NumberOfSealed: 100.0,
        NumberFlourideVarnish: 40.0,
        NumberProphy: 20.0
      )

      get :event

      expect(assigns(:event_data)).not_to be_empty
      expect(assigns(:chart_data_con_forms)).not_to be_empty
    end
  end

  describe 'GET #impactReport' do
    it 'assigns school_data, age_sealants_chart_data, grade_sealants_chart_data, school_data_grouped, and chart_data1' do
      # Assuming you have some data in the database
      patient_detail = PatientDetail.create!(PID: 486, PatientId: 89, SchoolName: 'Test Schooln', Date: Date.today,
      Age: 19, Grade: 9, Insurance: 'bhvyvbb')

      ChildLevelDetail.create!(
        PID: 486,
        TeethScreening: 'some_screening',
        TeethPreventative: 'some_preventative',
        TeethFollowup: 'some_followup',
        PrescriberName: 'some_prescriber',
        ScreenDate: Date.today,
        ScreenComment: 'some_comment',
        UntreatedCavities: 2,
        CarriesExperience: 1,
        Sealants: 3,
        ReferralS: 4,
        ProviderName: 'some_provider',
        ProviderDate: Date.today,
        PreventComment: 'some_prevent_comment',
        FirstSealedNum: 5,
        SecondSealedNum: 6,
        OtherPermNum: 7,
        PrimarySealed: 8,
        FluorideVarnish: true,
        EvaluatorsName: 'some_evaluator',
        EvaluatorDate: Date.today,
        EvaluatorComment: 'some_evaluator_comment',
        RetainedSealant: 9,
        ReferredDT: false,
        ReferredUDT: true,
        SealantsRecd: 10,
        SealnatsNeeded: 11,
        Experienced: true,
        UntreatedDecayFollow: false,
        Services: 'some_services',
        ORHealthStatus: 'some_health_status'
      )


      get :impactReport

      expect(assigns(:school_data)).not_to be_empty
      expect(assigns(:age_sealants_chart_data)).not_to be_empty
      expect(assigns(:grade_sealants_chart_data)).not_to be_empty
      expect(assigns(:school_data_grouped)).not_to be_empty
      expect(assigns(:chart_data1)).not_to be_empty
    end

    it 'handles empty school_data' do
      # Test when there is no data in the database
      get :impactReport

      expect(assigns(:school_data)).to be_empty
      expect(assigns(:age_sealants_chart_data)[:datasets].first[:data]).to be_empty
      expect(assigns(:age_sealants_chart_data)[:labels]).to be_empty
      expect(assigns(:grade_sealants_chart_data)[:datasets].first[:data]).to be_empty
      expect(assigns(:grade_sealants_chart_data)[:labels]).to be_empty
      expect(assigns(:school_data_grouped)).to be_empty
      expect(assigns(:chart_data1)[:datasets].first[:data]).to be_empty
      expect(assigns(:chart_data1)[:labels]).to be_empty
    end
  end
end
