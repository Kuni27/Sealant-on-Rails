Feature: Display Table of Patients
    
    Scenario: Going to Patient Details Form
        Given I am on the Patient Display page
        When I click the "New patient detail" button
        Then I should be taken to the patient details form
    
    Scenario: Display created entry 
        Given I am on the Patient Details Form page
        And I enter the Patientid field with 23
        And I enter the School Name field with "my school"
        And I enter the Age field with 7
        And I enter the Insurance field with "Blue Cross"
        And I enter the Grade field with "5"
        And I enter the date with "04/04/2023"
        And I click the "Create Patient detail" button
        When I go to the patient display page
        Then I should see an entry with Patientid 23
        And its school name should be "my school"
    

    Scenario: Editing a Patient's Details
        Given I am on the Patient Details Form page
        And I enter the Patientid field with 23
        And I enter the School Name field with "my school"
        And I enter the Age field with 7
        And I enter the Insurance field with "Blue Cross"
        And I enter the Grade field with "5"
        And I enter the date with "04/04/2023"
        And I click the "Create Patient detail" button
        Given I am on the Patient Display page
        When I click Show This Patient's Details
        And I click the "Edit this patient detail" button
        And I change the Age to 8
        And I click the "Update Patient detail" button
        Then I should see a message confirming the update
        And the patient's age should be 8

    Scenario: Deleting a Patient's details
        Given I am on the Patient Details Form page
        And I enter the Patientid field with 23
        And I enter the School Name field with "my school"
        And I enter the Age field with 7
        And I enter the Insurance field with "Blue Cross"
        And I enter the Grade field with "5"
        And I enter the date with "04/04/2023"
        And I click the "Create Patient detail" button
        Given I am on the Patient Display page
        When I click Show This Patient's Details
        And I click the "Destroy this patient detail" button
        Then I should see a message confirming the deletion
    
   
