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
      |--chatty|
      |-c|
      |--output-file|
      |-o|
      |--force|
      |--log-level|
    And the banner should document that this app's arguments are:
      | file_dir | which is required |

  Scenario: tags untagged text file
    Given a file named "tmp/sge.txt" with:
    """
    owned by SGE .txt file
    """
    When I successfully run `sge_tagger tmp`
    Then the file "tmp/sge.txt" should be text-tagged

  Scenario: tags untagged ruby file
    Given a file named "tmp/sge.rb" with:
    """
    owned by SGE .rb file
    """
    When I successfully run `sge_tagger tmp`
    Then the file "tmp/sge.rb" should be ruby-tagged

  Scenario: does not tag already tagged text file
    Given a file named "tmp/sge.txt" with:
    """
    Confidential information of Sleepy Giant Entertainment, Inc.
    © Sleepy Giant Entertainment, Inc.
    """
    When I successfully run `sge_tagger tmp`
    Then the file "tmp/sge.txt" should only be tagged once

  Scenario: show report after successful run
    Given a file named "tmp/sge.txt" with:
    """
    SGE owned .txt file
    """
    When I successfully run `sge_tagger tmp`
    Then the output should contain "newly"
    And the output should contain "previously"
    And the output should contain "3rd party"

  Scenario: show newly tagged count after successful run
    Given a file named "tmp/sge.txt" with:
    """
    SGE owned .txt file
    """
    When I successfully run `sge_tagger tmp`
    Then the output should contain "1 newly"
    And the output should contain "0 previously"

  Scenario: show previously tagged count after successful run
    Given a file named "tmp/sge.txt" with:
    """
    Confidential information of Sleepy Giant Entertainment, Inc.
    © Sleepy Giant Entertainment, Inc.
    """
    When I successfully run `sge_tagger tmp`
    Then the output should contain "0 newly"
    And the output should contain "1 previously"

  Scenario: tag files and ignore directories
    Given a directory named "tmp/level_one"
    And a file named "tmp/sge.txt" with:
    """
    SGE owned .txt file
    """
    When I successfully run `sge_tagger tmp`
    Then the file "tmp/sge.txt" should be text-tagged

  Scenario: show output when run with --chatty option
    Given a file named "tmp/sge.txt" with:
    """
    SGE owned .txt file
    """
    When I successfully run `sge_tagger --chatty tmp`
    Then the output should contain "sge.txt - newly tagged"

  Scenario: do not make any changes when run with --dry-run option
    Given a file named "tmp/sge.txt" with:
    """
    SGE owned .txt file
    """
    When I successfully run `sge_tagger --dry-run tmp`
    Then the file "tmp/sge.txt" should be unchanged

  Scenario: output messages to file when run with --output-file FILE option
    Given a file named "tmp/sge.txt" with:
    """
    SGE owned .txt file
    """
    When I successfully run `sge_tagger --output-file sge-out.txt tmp`
    Then the file "sge-out.txt" should contain "sge.txt - newly tagged"

  Scenario: do not clobber existing output file when run with --output-file FILE option
    Given a file named "tmp/sge.txt" with:
    """
    SGE owned .txt file
    """
    And a file named "sge-out.txt" with:
    """
    existing output file
    """
    When I successfully run `sge_tagger --output-file sge-out.txt tmp`
    Then the file "sge-out.txt" should contain "existing output file"

  Scenario: clobber existing output file when run with --output-file FILE --force options
    Given a file named "tmp/sge.txt" with:
    """
    SGE owned .txt file
    """
    And a file named "sge-out.txt" with:
    """
    existing output file
    """
    When I successfully run `sge_tagger --output-file sge-out.txt --force tmp`
    Then the file "sge-out.txt" should contain "newly tagged"
