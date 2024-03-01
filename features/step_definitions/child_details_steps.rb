# frozen_string_literal: true

Given('I visit the child level details forms for the patient with PID = {string}') do |string|
  visit("/child_data?patient_detail_id=#{string}")
end
  
  
Given('I click the {string} radio button for ScreeningButton {string}') do |string, string2|
    buttonName = 'radio1'+string2
    find("input[name=#{buttonName}][value=#{string}]").click
end
  
Given('I click the Close button in the pop-up for ScreeningButton {string}') do |string|
    popupName = "popup1" + string
    find("button[onclick*=\"closePopup('#{string}','#{popupName}')\"]").click
end


Then('I should see {string} cavities') do |string|
  expect(page).to have_content("Untreated Cavities: #{string}")
end

