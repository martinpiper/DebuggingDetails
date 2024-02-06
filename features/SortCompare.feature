Feature: Compares the sorts for Siv and Terra Cresta
  
  Compares the sorts for Siv and Terra Cresta, using a variety of input data, calls the sort routines for a couple of iterations and compare cycle counts.
  
  SWIV sort is faster for completely inverted data.
  
  
  Scenario: Test Swiv sort in isolation, descending sort expected
    Given I have a simple overclocked 6502 system
    And I enable uninitialised memory read protection with immediate fail
    And I enable trace with indent
    And I load prg "c:\temp\swiv sort 48f1 4958.prg"
    
    When I execute the procedure at $48f1 until return
    When I hex dump memory between $82 and $a2
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "82: 00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f"
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "92: 10 11 12 13 14 15 16 17  18 19 1a 1b 1c 1d 1e 1f"
    
    # Setup data to sort...
    Given I start writing memory at $42
    And I write the following hex bytes
      | 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f |
      | 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f |

    # Result: 10136 cycles
    Given I reset the cycle count
    When I execute the procedure at $4958 until return
    Given set the variable "test.cycles.1" equal to the cycle count
    Then debug print to scenario "${test.cycles.1}"

    When I hex dump memory between $82 and $a2
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "82: 1f 1e 1d 1c 1b 1a 19 18  17 16 15 14 13 12 11 10"
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "92: 0f 0e 0d 0c 0b 0a 09 08  07 06 05 04 03 02 01 00"

    # Result: 650 cycles
    Given I reset the cycle count
    When I execute the procedure at $4958 until return
    Given set the variable "test.cycles.2" equal to the cycle count
    Then debug print to scenario "${test.cycles.2}"

    When I hex dump memory between $82 and $a2
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "82: 1f 1e 1d 1c 1b 1a 19 18  17 16 15 14 13 12 11 10"
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "92: 0f 0e 0d 0c 0b 0a 09 08  07 06 05 04 03 02 01 00"


    # Result: 650 cycles
    Given I reset the cycle count
    When I execute the procedure at $4958 until return
    Given set the variable "test.cycles.3" equal to the cycle count
    Then debug print to scenario "${test.cycles.3}"

    When I hex dump memory between $82 and $a2
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "82: 1f 1e 1d 1c 1b 1a 19 18  17 16 15 14 13 12 11 10"
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "92: 0f 0e 0d 0c 0b 0a 09 08  07 06 05 04 03 02 01 00"


    * if "${test.cycles.1}" is numerically equal to "${test.cycles.2}"
      Then assert that "Sort 1 should not equal sort 2 cycles" is false
    * endif
    
    
    * if "${test.cycles.2}" is numerically not equal to "${test.cycles.3}"
      Then assert that "Sort 2 should equal sort 3 cycles" is false
    * endif




  Scenario: Test Terra Cresta sort in isolation, descending sort expected
    Given I have a simple overclocked 6502 system
    And I enable uninitialised memory read protection with immediate fail
    And I enable trace with indent
    And I load prg "c:\temp\terra cresta sort 499f 4b12.prg"
    
    When I execute the procedure at $499f until return
    When I hex dump memory between $49 and $67
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "49: 00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f"
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "59: 10 11 12 13 14 15 16 17  18 19 1a 1b 1c 1d"
    
    # Setup data to sort...
    Given I start writing memory at $85
    And I write the following hex bytes
      | 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f |
      | 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d |

    # Result: 15006 cycles
    Given I reset the cycle count
    When I execute the procedure at $4b12 until return
    Given set the variable "test.cycles.1" equal to the cycle count
    Then debug print to scenario "${test.cycles.1}"

    When I hex dump memory between $49 and $67
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "49: 1d 1c 1b 1a 19 18 17 16  15 14 13 12 11 10 0f 0e"
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "59: 0d 0c 0b 0a 09 08 07 06  05 04 03 02 01 00"

    # Result: 709 cycles
    Given I reset the cycle count
    When I execute the procedure at $4b12 until return
    Given set the variable "test.cycles.2" equal to the cycle count
    Then debug print to scenario "${test.cycles.2}"

    When I hex dump memory between $49 and $67
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "49: 1d 1c 1b 1a 19 18 17 16  15 14 13 12 11 10 0f 0e"
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "59: 0d 0c 0b 0a 09 08 07 06  05 04 03 02 01 00"


    # Result: 709 cycles
    Given I reset the cycle count
    When I execute the procedure at $4b12 until return
    Given set the variable "test.cycles.3" equal to the cycle count
    Then debug print to scenario "${test.cycles.3}"

    When I hex dump memory between $49 and $67
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "49: 1d 1c 1b 1a 19 18 17 16  15 14 13 12 11 10 0f 0e"
    Then property "test.BDD6502.lastHexDump" must contain string ignoring whitespace "59: 0d 0c 0b 0a 09 08 07 06  05 04 03 02 01 00"


    * if "${test.cycles.1}" is numerically equal to "${test.cycles.2}"
      Then assert that "Sort 1 should not equal sort 2 cycles" is false
    * endif
    
    
    * if "${test.cycles.2}" is numerically not equal to "${test.cycles.3}"
      Then assert that "Sort 2 should equal sort 3 cycles" is false
    * endif
