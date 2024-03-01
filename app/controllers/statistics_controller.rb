# frozen_string_literal: true

class StatisticsController < ApplicationController
  def index
    @statistics_data = PatientDetail.select(
      :PatientId, :SchoolName, :Date, :Age, :Grade, :PID, :Gender, :Race, :Ethnicity,
      '"child_level_details"."ScreenDate" AS "DateOfSealentReceived"',
      '"child_level_details"."SealnatsNeeded" AS "NoOfSealentNeeded"',
      '"child_level_details"."Sealants" AS "NoOfSealentReceived"',
      # 'child_level_details.SealantsReplaced AS NoOfSealentReplaced', Code for Sealent Received
      # code for "Did they have any Sealent?"
      '"child_level_details"."Experienced" AS "CarriesExperience"',
      '"child_level_details"."UntreatedDecayFollow" AS "UntreatedDecay"',
      '"child_level_details"."ReferredDT" AS "ReferredForDT"',
      '"child_level_details"."ReferredUDT" AS "ReferredForUDT"',
      '"child_level_details"."FluorideVarnish" AS "FluorideVarnish"',
      '"child_level_details"."UntreatedCavities" AS "DecayCount"'
      # :Sealants, :Experienced, :Services
    ).left_outer_joins(:child_level_details)

    # You can add more complex logic to calculate statistics here.

    # For example, you can calculate the number of patients with sealants.
    # @patients_with_sealants = @statistics_data.select { |data| data.Sealants == 'yes' }

    # You can add more statistics calculations as needed.

    # Render the view.
  end

  def impactReport
    @school_data = PatientDetail.select(
      :SchoolName,
      'COUNT(DISTINCT "patient_details"."PatientId") AS children_screened',
      '(SUM(COALESCE("child_level_details"."UntreatedCavities", 0)) / COUNT(DISTINCT "patient_details"."PatientId")) * 100 AS "percentage_cavities"',
      '(SUM(COALESCE("child_level_details"."UntreatedCavities", 0) + COALESCE("child_level_details"."CarriesExperience", 0) ) / COUNT(DISTINCT "patient_details"."PatientId")) * 100 AS percentage_total_cavities',
      '(SUM(COALESCE("child_level_details"."Sealants", 0)) / COUNT(DISTINCT "patient_details"."PatientId")) * 100 AS "percentage_Sealant_cavities"',
      '(SUM(CASE WHEN "child_level_details"."ReferredUDT" = true THEN 1 ELSE 0 END) / COUNT(DISTINCT "patient_details"."PatientId")) * 100 AS "percentage_Urgent_Care"',
      '(SUM(CASE WHEN "child_level_details"."ReferredDT" = true THEN 1 ELSE 0 END) / COUNT(DISTINCT "patient_details"."PatientId")) * 100 AS "percentage_Restorative_Care"'
    )
                                .joins(:child_level_details)
                                .group(:SchoolName)

    # To have pie chart grouped by age
    childrenDataGroupedByAge = PatientDetail.select(
      :Age,
      '(SUM(COALESCE("child_level_details"."Sealants", 0))) AS "numberOfSealentRecived"'
    )
                                            .joins(:child_level_details)
                                            .group(:Age)

    # To have pie chart grouped by age
    childrenDataGroupedByGrade = PatientDetail.select(
      :Grade,
      '(SUM(COALESCE("child_level_details"."Sealants", 0))) AS "numberOfSealentRecived"'
    )
                                              .joins(:child_level_details)
                                              .group(:Grade)

    @age_sealants_chart_data = {
      labels: childrenDataGroupedByAge.map { |data| data.Age.to_s },
      datasets: [{
        data: childrenDataGroupedByAge.map { |data| data.numberOfSealentRecived.to_f },
        backgroundColor: generate_random_colors(childrenDataGroupedByAge.size),
        borderColor: generate_random_colors(childrenDataGroupedByAge.size, 1),
        borderWidth: 1
      }]
    }

    @grade_sealants_chart_data = {
      labels: childrenDataGroupedByGrade.map { |data| data.Grade.to_s },
      datasets: [{
        data: childrenDataGroupedByGrade.map { |data| data.numberOfSealentRecived.to_f },
        backgroundColor: generate_random_colors(childrenDataGroupedByGrade.size),
        borderColor: generate_random_colors(childrenDataGroupedByGrade.size, 1),
        borderWidth: 1
      }]
    }

    @school_data_grouped = @school_data.group_by(&:SchoolName)
    @chart_data1 = {
      labels: @school_data_grouped.keys,
      datasets: [
        {
          label: '% of Untreated Decay',
          data: @school_data_grouped.values.map { |school_data| school_data.map(&:percentage_cavities).sum },
          backgroundColor: 'rgba(75, 192, 192, 0.2)',
          borderColor: 'rgba(75, 192, 192, 1)',
          borderWidth: 1
        },
        {
          label: '% of Treated and Untreated Decay',
          data: @school_data_grouped.values.map { |school_data| school_data.map(&:percentage_total_cavities).sum },
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)',
          borderWidth: 1
        },
        {
          label: '% of Sealants present',
          data: @school_data_grouped.values.map { |school_data| school_data.map(&:percentage_Sealant_cavities).sum },
          backgroundColor: 'rgba(255, 206, 86, 0.2)',
          borderColor: 'rgba(255, 206, 86, 1)',
          borderWidth: 1
        },
        {
          label: '% needing Urgent Care',
          data: @school_data_grouped.values.map { |school| school.map(&:percentage_Urgent_Care).sum },
          backgroundColor: 'rgba(54, 162, 235, 0.2)',
          borderColor: 'rgba(54, 162, 235, 1)',
          borderWidth: 1
        },
        {
          label: '% needing Restorative Care',
          data: @school_data_grouped.values.map { |school| school.map(&:percentage_Restorative_Care).sum },
          backgroundColor: 'rgba(0, 0, 0, 0.2)',
          borderColor: 'rgba(0, 0, 0, 1)',
          borderWidth: 1
        }
      ]
    }
  end

  def school
    @school_data = PatientDetail.select(
      :SchoolName,
      :Date,
      'COUNT(DISTINCT "patient_details"."PatientId") AS children_screened',
      'COUNT(DISTINCT CASE WHEN COALESCE("child_level_details"."FirstSealedNum", 0) > 0 OR COALESCE("child_level_details"."SecondSealedNum", 0) > 0 OR COALESCE("child_level_details"."OtherPermNum", 0) > 0 OR COALESCE("child_level_details"."PrimarySealed", 0) > 0 THEN "patient_details"."PatientId" ELSE NULL END) AS children_rec_sealants',
      'SUM(COALESCE("child_level_details"."FirstSealedNum", 0) + COALESCE("child_level_details"."SecondSealedNum", 0) + COALESCE("child_level_details"."OtherPermNum", 0) + COALESCE("child_level_details"."PrimarySealed", 0)) AS teeth_sealed',
      'SUM(CASE WHEN "child_level_details"."FluorideVarnish" = true THEN 1 ELSE 0 END) AS children_with_fluoride'
    )
                                .joins(:child_level_details)
                                .group(:SchoolName, :Date)

    @school_data_grouped = @school_data.group_by(&:SchoolName)

    # Prepare data for the grouped bar chart
    @chart_data1 = {
      labels: @school_data_grouped.keys,
      datasets: [
        {
          label: 'Children Screened',
          data: @school_data_grouped.values.map { |school_data| school_data.map(&:children_screened).sum },
          backgroundColor: 'rgba(75, 192, 192, 0.2)',
          borderColor: 'rgba(75, 192, 192, 1)',
          borderWidth: 1
        },
        {
          label: 'Children Receiving Sealants',
          data: @school_data_grouped.values.map { |school_data| school_data.map(&:children_rec_sealants).sum },
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)',
          borderWidth: 1
        },
        {
          label: 'Teeth Sealed',
          data: @school_data_grouped.values.map { |school_data| school_data.map(&:teeth_sealed).sum },
          backgroundColor: 'rgba(255, 206, 86, 0.2)',
          borderColor: 'rgba(255, 206, 86, 1)',
          borderWidth: 1
        },
        {
          label: 'Children With Flouride',
          data: @school_data_grouped.values.map { |school| school.map(&:children_with_fluoride).sum },
          backgroundColor: 'rgba(54, 162, 235, 0.2)',
          borderColor: 'rgba(54, 162, 235, 1)',
          borderWidth: 1
        }
      ]
    }
  end

  def generate_random_colors(count, alpha = 0.2)
    colors = []
    count.times do
      colors << "rgba(#{rand(0..255)}, #{rand(0..255)}, #{rand(0..255)}, #{alpha})"
    end
    colors
  end

  def event
    @event_data = EventDetail.select(
      :EventDate, :School, :ConsentFD, :DenHrs, :DenTravelHrs, :DenTravelMil,
      :HygHours, :HygTravelHrs, :HygTravelMil, :AssistantHrs, :AssistantTravelHrs,
      :AssistantTravelMil, :OtherHrs, :OtherTravelHrs, :OtherTravelMiles,
      :NumberOfSSPDriven, :TotalMilesDriven
    )

    # Calculate the total hours
    # total_hours = @event_data.pluck(:DenHrs).sum + @event_data.pluck(:HygHours).sum + @event_data.pluck(:AssistantHrs).sum + @event_data.pluck(:OtherHrs).sum

    # Format data for the pie chart - Total hours at School
    @school_hrs_chart_data = {
      labels: ['Dentist Hours', 'Hygenist Hours', 'Assistant Hours', 'Other Hours'],
      datasets: [{
        data: [@event_data.pluck(:DenHrs).compact.sum, @event_data.pluck(:HygHours).compact.sum, @event_data.pluck(:AssistantHrs).compact.sum,
               @event_data.pluck(:OtherHrs).compact.sum],
        backgroundColor: ['rgba(75, 192, 192, 0.2)',
                          'rgba(255, 99, 132, 0.2)',
                          'rgba(255, 206, 86, 0.2)',
                          'rgba(54, 162, 235, 0.2)'],
        borderColor: ['rgba(75, 192, 192, 1)',
                      'rgba(255, 99, 132, 1)',
                      'rgba(255, 206, 86, 1)',
                      'rgba(54, 162, 235, 1)'],
        borderWidth: 1
      }]
    }

    # Format data for the pie chart - Total hours travelling
    @travel_hrs_chart_data = {
      labels: ['Dentist Travel Hours', 'Hygenist Travel Hours', 'Assistant Travel Hours', 'Other Travel Hours'],
      datasets: [{
        data: [@event_data.pluck(:DenTravelHrs).compact.sum, @event_data.pluck(:HygTravelHrs).compact.sum,
               @event_data.pluck(:AssistantHrs).compact.sum, @event_data.pluck(:OtherTravelHrs).compact.sum],
        backgroundColor: ['rgba(75, 192, 192, 0.2)',
                          'rgba(255, 99, 132, 0.2)',
                          'rgba(255, 206, 86, 0.2)',
                          'rgba(54, 162, 235, 0.2)'],
        borderColor: ['rgba(75, 192, 192, 1)',
                      'rgba(255, 99, 132, 1)',
                      'rgba(255, 206, 86, 1)',
                      'rgba(54, 162, 235, 1)'],
        borderWidth: 1
      }]
    }

    # Format data for the pie chart - Total miles travelling
    @travel_mil_chart_data = {
      labels: ['Dentist Travel Miles', 'Hygenist Travel Miles', 'Assistant Travel Miles', 'Other Travel Miles'],
      datasets: [{
        data: [@event_data.pluck(:DenTravelMil).compact.sum, @event_data.pluck(:HygTravelMil).compact.sum,
               @event_data.pluck(:AssistantTravelMil).compact.sum, @event_data.pluck(:OtherTravelMiles).compact.sum],
        backgroundColor: ['rgba(75, 192, 192, 0.2)',
                          'rgba(255, 99, 132, 0.2)',
                          'rgba(255, 206, 86, 0.2)',
                          'rgba(54, 162, 235, 0.2)'],
        borderColor: ['rgba(75, 192, 192, 1)',
                      'rgba(255, 99, 132, 1)',
                      'rgba(255, 206, 86, 1)',
                      'rgba(54, 162, 235, 1)'],
        borderWidth: 1
      }]
    }

    # Group the data by school
    school_data = @event_data.group_by(&:School)

    # Prepare data for the chart for each variable
    @chart_data_con_forms = {
      labels: school_data.keys,
      datasets: [{
        label: 'Consent Forms Distributed',
        data: school_data.values.map { |school| school.map(&:ConsentFD).compact.sum },
        backgroundColor: 'rgba(75, 192, 192, 0.2)',
        borderColor: 'rgba(75, 192, 192, 1)',
        borderWidth: 1
      }]
    }

    # Prepare data for the grouped bar chart
    @chart_data1 = {
      labels: school_data.keys,
      datasets: [
        {
          label: 'Dentist',
          data: school_data.values.map { |school| school.map(&:DenHrs).compact.sum },
          backgroundColor: 'rgba(75, 192, 192, 0.2)',
          borderColor: 'rgba(75, 192, 192, 1)',
          borderWidth: 1
        },
        {
          label: 'Hygienist',
          data: school_data.values.map { |school| school.map(&:HygHours).compact.sum },
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)',
          borderWidth: 1
        },
        {
          label: 'Assistant',
          data: school_data.values.map { |school| school.map(&:AssistantHrs).compact.sum },
          backgroundColor: 'rgba(255, 206, 86, 0.2)',
          borderColor: 'rgba(255, 206, 86, 1)',
          borderWidth: 1
        },
        {
          label: 'Other',
          data: school_data.values.map { |school| school.map(&:OtherHrs).compact.sum },
          backgroundColor: 'rgba(54, 162, 235, 0.2)',
          borderColor: 'rgba(54, 162, 235, 1)',
          borderWidth: 1
        }
      ]
    }

    @chart_data2 = {
      labels: school_data.keys,
      datasets: [
        {
          label: 'Dentist',
          data: school_data.values.map { |school| school.map(&:DenTravelHrs).compact.sum },
          backgroundColor: 'rgba(75, 192, 192, 0.2)',
          borderColor: 'rgba(75, 192, 192, 1)',
          borderWidth: 1
        },
        {
          label: 'Hygienist',
          data: school_data.values.map { |school| school.map(&:HygTravelHrs).compact.sum },
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)',
          borderWidth: 1
        },
        {
          label: 'Assistant',
          data: school_data.values.map { |school| school.map(&:AssistantTravelHrs).compact.sum },
          backgroundColor: 'rgba(255, 206, 86, 0.2)',
          borderColor: 'rgba(255, 206, 86, 1)',
          borderWidth: 1
        },
        {
          label: 'Other',
          data: school_data.values.map { |school| school.map(&:OtherTravelHrs).compact.sum },
          backgroundColor: 'rgba(54, 162, 235, 0.2)',
          borderColor: 'rgba(54, 162, 235, 1)',
          borderWidth: 1
        }
      ]
    }

    @chart_data3 = {
      labels: school_data.keys,
      datasets: [
        {
          label: 'Dentist',
          data: school_data.values.map { |school| school.map(&:DenTravelMil).compact.sum },
          backgroundColor: 'rgba(75, 192, 192, 0.2)',
          borderColor: 'rgba(75, 192, 192, 1)',
          borderWidth: 1
        },
        {
          label: 'Hygienist',
          data: school_data.values.map { |school| school.map(&:HygTravelMil).compact.sum },
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)',
          borderWidth: 1
        },
        {
          label: 'Assistant',
          data: school_data.values.map { |school| school.map(&:AssistantTravelMil).compact.sum },
          backgroundColor: 'rgba(255, 206, 86, 0.2)',
          borderColor: 'rgba(255, 206, 86, 1)',
          borderWidth: 1
        },
        {
          label: 'Other',
          data: school_data.values.map { |school| school.map(&:OtherTravelMiles).compact.sum },
          backgroundColor: 'rgba(54, 162, 235, 0.2)',
          borderColor: 'rgba(54, 162, 235, 1)',
          borderWidth: 1
        }
      ]
    }

    @chart_data4 = {
      labels: school_data.keys,
      datasets: [
        {
          label: 'Number of Vehicles Driven',
          data: school_data.values.map { |school| school.map(&:NumberOfSSPDriven).compact.sum },
          backgroundColor: 'rgba(75, 192, 192, 0.2)',
          borderColor: 'rgba(75, 192, 192, 1)',
          borderWidth: 1
        },
        {
          label: 'Total Miles Driven',
          data: school_data.values.map { |school| school.map(&:TotalMilesDriven).compact.sum },
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)',
          borderWidth: 1
        }
      ]
    }
  end
end
