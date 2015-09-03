Feature: Retrieve the feeds and compare them
  Scenario: Compare the UDS and Solr feeds
    Given UDS feed exists
    And Solr feed exists
    When I retrieve UDS feed
    And I retrieve Solr feed
    Then All the items in UDS feed should be present in Solr feed

  Scenario: Verify all the names in the Solr feed has corresponding description
    Given Solr feed exists
    When I retrieve Solr feed
    Then All the names in the feed should have corresponding description
