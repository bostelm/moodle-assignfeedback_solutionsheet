@assignfeedback @assignfeedback_solutionsheet @_file_upload
Feature: In an assignment, teachers can not upload solution sheets without capability
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
  Scenario: A teacher can not show and hide the solution sheet if they do not have the capability.
    Given I log in as "admin"
    And I set the following system permissions of "Teacher" role:
      | capability                                                | permission |
      | assignfeedback/solutionsheet:releasesolution              | Prevent    |
    And I log out

    When I am on the "Test assignment name" Activity page logged in as teacher1
    Then I should see "Solution sheets"
    And I should see "solutionsheet.txt"
    And I should see "Students can not currently access the solutions"
    And I should not see "Click to show the solutions"
    And I log out
