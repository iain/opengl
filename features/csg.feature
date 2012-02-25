Feature: CSG Object cutting
  In order to be creative in every way
  As a user
  I want to be able to cut objects and put them together

  Scenario: Find functions for a plane
    Given I have the following vertices:
      | 0 | 0 | 0 |
      | 1 | 1 | 0 |
      | 2 | 0 | 0 |
    Then the functions should be:
      | 0 | 1  | 0 |
      | 0 | 0  | 0 |
      | 2 | -1 | 0 |

  Scenario: Find points between vertices function where the cut hits
    Given I have the following vertices:
      | 0 | 0 | 0 |
      | 1 | 1 | 0 |
      | 2 | 0 | 0 |
    When I cut with -1 + 1x
    Then I find the following points:
      | 1   | 0  | 0 |
      | 1.5 | .5 | 0 |

  Scenario: Find the to be deleted vertices at the right side of the cut line
    Given I have the following vertices:
      | 0 | 0 | 0 |
      | 1 | 1 | 0 |
      | 2 | 0 | 0 |
    When I cut with -1 + 1x
    Then I should have the following vertices to be removed:
      | 2 | 0 | 0 |

  Scenario: Find if the vertex is at the right side of the cut line
    Given I have the following vertices:
      | 0 | 0 | 0 |
      | 1 | 1 | 0 |
      | 2 | 0 | 0 |
    When I cut with -0.5 + 2x
    Then I should have the following vertices to be removed:
      | 1 | 1 | 0 |
      | 2 | 0 | 0 |

  @wip
  Scenario: Cut plane through half
    Given I have the following vertices:
      | 0 | 0 | 0 |
      | 1 | 1 | 0 |
      | 2 | 0 | 0 |
    When I cut with -1 + 1x
    Then I should see the following vertices:
      | 0   | 0  | 0 |
      | 1   | 1  | 0 |
      | 1.5 | .5 | 0 |
      | 1   | 0  | 0 |
