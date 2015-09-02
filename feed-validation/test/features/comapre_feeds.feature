Feature:
  Scenario: Compare the UDS and Solr feeds
    Given UDS feed exists
    And Solr feed exists
    When I retrieve UDS feed
    And I retrieve Solr feed

    Then All the items in UDS feed should be present in Solr feed
