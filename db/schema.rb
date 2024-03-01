# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_231_113_175_106) do
  create_table 'child_details', force: :cascade do |t|
    t.string 'PrescriberName'
    t.date 'ScreenDate'
    t.string 'ScreenComment'
    t.boolean 'Sealants'
    t.boolean 'UntreatedDecayScreen'
    t.boolean 'TreatedDecay'
    t.string 'Referral'
    t.integer 'DecayedNum'
    t.string 'ProviderName'
    t.date 'ProviderDate'
    t.integer 'FirstSealedNum'
    t.integer 'SecondSealedNum'
    t.integer 'OtherPermNum'
    t.integer 'PrimarySealed'
    t.boolean 'FluorideVarnish'
    t.boolean 'Prophylaxes'
    t.string 'PreventativeComment'
    t.string 'EvaluatorsName'
    t.date 'EvaluatorDate'
    t.string 'EvaluatorComment'
    t.integer 'RetainedSealant'
    t.boolean 'ReferredDT'
    t.boolean 'ReferredUDT'
    t.integer 'SealantsRecd'
    t.integer 'SealnatsNeeded'
    t.boolean 'Experienced'
    t.boolean 'UntreatedDecayFollow'
    t.string 'Services'
    t.string 'ORHealthStatus'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'child_level_details', id: false, force: :cascade do |t|
    t.string 'PID'
    t.string 'TeethScreening'
    t.string 'TeethPreventative'
    t.string 'TeethFollowup'
    t.string 'PrescriberName'
    t.date 'ScreenDate'
    t.string 'ScreenComment'
    t.integer 'UntreatedCavities'
    t.integer 'CarriesExperience'
    t.integer 'Sealants'
    t.integer 'ReferralS'
    t.string 'ProviderName'
    t.date 'ProviderDate'
    t.string 'PreventComment'
    t.integer 'FirstSealedNum'
    t.integer 'SecondSealedNum'
    t.integer 'OtherPermNum'
    t.integer 'PrimarySealed'
    t.boolean 'FluorideVarnish'
    t.string 'EvaluatorsName'
    t.date 'EvaluatorDate'
    t.string 'EvaluatorComment'
    t.integer 'RetainedSealant'
    t.boolean 'ReferredDT'
    t.boolean 'ReferredUDT'
    t.integer 'SealantsRecd'
    t.integer 'SealnatsNeeded'
    t.boolean 'Experienced'
    t.boolean 'UntreatedDecayFollow'
    t.string 'Services'
    t.string 'ORHealthStatus'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'event_details', force: :cascade do |t|
    t.date 'EventDate'
    t.string 'School'
    t.integer 'ConsentFD'
    t.float 'DenHrs'
    t.float 'DenTravelHrs'
    t.float 'DenTravelMil'
    t.float 'HygHours'
    t.float 'HygTravelMil'
    t.float 'HygTravelHrs'
    t.float 'AssistantTravelMil'
    t.float 'AssistantHrs'
    t.float 'AssistantTravelHrs'
    t.float 'OtherHrs'
    t.float 'OtherTravelHrs'
    t.float 'OtherTravelMiles'
    t.float 'NumberOfSSPDriven'
    t.float 'TotalMilesDriven'
    t.float 'ChildScreened'
    t.float 'ChildReceivingSealant'
    t.float 'NumberOfSealed'
    t.float 'NumberFlourideVarnish'
    t.float 'NumberProphy'
    t.string 'uid'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'patient_details', force: :cascade do |t|
    t.integer 'PatientId'
    t.string 'ProgramName'
    t.string 'SchoolName'
    t.integer 'Age'
    t.date 'Date'
    t.string 'Insurance'
    t.string 'Grade'
    t.string 'PID'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'Gender'
    t.string 'Race'
    t.string 'Ethnicity'
  end

  create_table 'tooths', force: :cascade do |t|
    t.integer 'number'
    t.integer 'screening'
    t.integer 'preventive'
    t.integer 'follow'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'username'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'uid'
    t.string 'provider'
  end

  create_table 'whitelists', force: :cascade do |t|
    t.string 'email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'role'
  end
end
