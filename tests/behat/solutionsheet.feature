@assignfeedback @assignfeedback_solutionsheet @_file_upload @wip
Feature: In an assignment, teachers can upload solution sheets
  In order to provide solutions
  As a teacher
  I need to upload the solution sheet.

  Background:
    Given the following "courses" exist:
      | fullname | shortname | category | groupmode |
      | Course 1 | C1 | 0 | 1 |
    And the following "activity" exists:
      | activity                            | assign                  |
      | course                              | C1                      |
      | name                                | Test assignment name    |
      | intro                               | Questions here          |
      | duedate                             | 1896130800              |
      | assignsubmission_onlinetext_enabled | 1                       |
      | assignsubmission_file_enabled       | 0                       |
      | attemptreopenmethod                 | manual                  |
      | hidegrader                          | 1                       |
      | submissiondrafts                    | 0                       |
    And the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
      | student1 | Student | 1 | student1@example.com |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
      | student1 | C1 | student |
    
    And I am on the "Test assignment name" Activity page logged in as teacher1
    And I navigate to "Settings" in current page administration
    And I follow "Expand all"
    And I set the field "assignfeedback_solutionsheet_enabled" to "1"
    And I upload "mod/assign/feedback/solutionsheet/tests/fixtures/solutionsheet.txt" file to "Upload solution sheets" filemanager
    And I press "Save and display"
    And I log out

  @javascript
  Scenario: A teacher can show and hide the solution sheet.
    When I am on the "Test assignment name" Activity page logged in as student1
    Then I should see "The solutions are not yet available"
    And I should not see "Only students who made a submission will"
    And I should not see "solutionsheet.txt"
    And I log out

    When I am on the "Test assignment name" Activity page logged in as teacher1
    Then I should see "Solution sheets"
    And I should see "solutionsheet.txt"
    And I should see "Students can not currently access the solutions"
    And I should not see "Only students who made a submission will"
    And I should see "Click to show the solutions"

    When I follow "Click to show the solutions"
    Then I should see "Are you sure you want to show the solutions"
    When I press "Yes"
    Then I should see "Changes saved"
    And I should see "Solution sheets"
    And I should see "solutionsheet.txt"
    And I should see "Click to hide the solutions"
    And I log out

    When I am on the "Test assignment name" Activity page logged in as student1
    Then I should see "solutionsheet.txt"
    And I log out

    When I am on the "Test assignment name" Activity page logged in as teacher1
    And I follow "Click to hide the solutions"
    Then I should see "Are you sure you want to hide the solutions"
    When I press "Yes"
    Then I should see "Changes saved"
    And I should see "Students can not currently access the solutions"
    And I should see "Click to show the solutions"
    And I log out

    When I am on the "Test assignment name" Activity page logged in as student1
    Then I should see "The solutions are not yet available"
    And I should not see "Only students who made a submission will"
    And I should not see "solutionsheet.txt"
    And I log out

  @javascript
  Scenario: A teacher can set the solutions to be available after the deadline.
    When I am on the "Test assignment name" Activity page logged in as teacher1
    And I navigate to "Settings" in current page administration
    And I follow "Expand all"
    And I click on "id_assignfeedback_solutionsheet_showattype_2" "field"
    And I set the following fields to these values:
      | assignfeedback_solutionsheet_showattime[number]   | 10   |
      | assignfeedback_solutionsheet_showattime[timeunit] | days |
    And I press "Save and display"
    Then I should see "Students can not currently access the solutions"
    And I should see "The solutions will be available from Monday, 11 February 2030"
    And I log out

    When I am on the "Test assignment name" Activity page logged in as student1
    And I am on "Course 1" course homepage
    And I follow "Test assignment name"
    Then I should see "The solutions will be available from Monday, 11 February 2030"
    And I should not see "solutionsheet.txt"
    And I log out

    When I am on the "Test assignment name" Activity page logged in as teacher1
    And I navigate to "Settings" in current page administration
    And I follow "Expand all"
    And I set the following fields to these values:
      | duedate[year]  | 2010 |
    And I press "Save and display"
    Then I should see "Click to hide the solutions"
    And I log out

    When I am on the "Test assignment name" Activity page logged in as student1
    Then I should see "solutionsheet.txt"
    And I log out

    When I am on the "Test assignment name" Activity page logged in as teacher1
    And I follow "Click to hide the solutions"
    Then I should see "Are you sure you want to hide the solutions"
    When I press "Yes"
    Then I should see "Changes saved"
    And I should see "Students can not currently access the solutions"
    And I log out

    When I am on the "Test assignment name" Activity page logged in as student1
    And I am on "Course 1" course homepage
    And I follow "Test assignment name"
    Then I should see "The solutions are not yet available"
    And I should not see "solutionsheet.txt"
    And I log out

  @javascript
  Scenario: A teacher can hide the solution sheets after a defined date.
    When I am on the "Test assignment name" Activity page logged in as teacher1
    And I navigate to "Settings" in current page administration
    And I follow "Expand all"
    And I click on "Yes, from now on" "radio"
    Then I should see "Are you sure you want to show solutions to students from now on?"
    When I press "Yes"
    And I set the following fields to these values:
      | assignfeedback_solutionsheet_hideafter[enabled] | 1    |
      | assignfeedback_solutionsheet_hideafter[day]     | 1    |
      | assignfeedback_solutionsheet_hideafter[month]   | 1    |
      | assignfeedback_solutionsheet_hideafter[year]    | 2010 |
    And I press "Save and display"
    Then I should see "The solutions are no longer available"
    And I should not see "Click to hide the solutions"
    And I log out

    When I am on the "Test assignment name" Activity page logged in as student1
    Then I should see "The solutions are no longer available"
    And I should not see "solutionsheet.txt"
    And I log out

    When I am on the "Test assignment name" Activity page logged in as teacher1
    And I navigate to "Settings" in current page administration
    And I follow "Expand all"
    And I set the following fields to these values:
      | assignfeedback_solutionsheet_hideafter[day]    | 1    |
      | assignfeedback_solutionsheet_hideafter[month]  | 1    |
      | assignfeedback_solutionsheet_hideafter[year]   | 2030 |
    And I press "Save and display"
    Then I should see "Click to hide the solutions"
    And I log out

    When I am on the "Test assignment name" Activity page logged in as student1
    Then I should see "solutionsheet.txt"
    And I log out
