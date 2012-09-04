Feature: Tag SGE owned files
  In order to comply with the legal department I
  want all SGE owned files to be tagged with legal
  information

  Scenario: Basic UI
    When I get help for "sge_tagger"
    Then the exit status should be 0
    And the banner should be present
    And there should be a one line summary of what the app does
    And the banner should include the version
    And the banner should document that this app takes options
    And the following options should be documented:
      |--version|
      |--log-level|
    And the banner should document that this app's arguments are:
      | file_dir | which is required |

  Scenario: Happy Path
    Given a directory with some SGE owned files at "tmp"
    When I successfully run `sge_tagger tmp`
    Then SGE owned files at "tmp" should be tagged with legal info
    #And summary info should be displayed