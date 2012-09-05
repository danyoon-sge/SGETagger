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

  Scenario: tags untagged text file
    Given a file named "tmp/sge_owned.txt" with:
    """
    owned by SGE .txt file
    """
    When I successfully run `sge_tagger tmp`
    Then the file "tmp/sge_owned.txt" should be text-tagged

  Scenario: tags untagged ruby file
    Given a file named "tmp/sge_owned.rb" with:
    """
    owned by SGE .rb file
    """
    When I successfully run `sge_tagger tmp`
    Then the file "tmp/sge_owned.rb" should be ruby-tagged

  Scenario: does not tag already tagged text file
    Given a file named "tmp/sge_tagged.txt" with:
    """
    Confidential information of Sleepy Giant Entertainment, Inc.
    © Sleepy Giant Entertainment, Inc.
    """
    When I successfully run `sge_tagger tmp`
    Then the file "tmp/sge_tagged.txt" should only be tagged once
