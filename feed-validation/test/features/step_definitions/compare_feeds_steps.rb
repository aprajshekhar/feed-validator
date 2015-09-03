feed_comparator = FeedComparator.new('prod')

And(/^Solr feed exists$/) do
  200 == feed_comparator.check_status('solr')
end

When(/^I retrieve UDS feed$/) do
  true == feed_comparator.compare_feeds
end

Given(/^UDS feed exists$/) do
  200 == feed_comparator.check_status('uds')
end

And(/^I retrieve Solr feed$/) do
  feed_comparator.retrieve_solr_feed_names

end

Then(/^All the items in UDS feed should be present in Solr feed$/) do
  feed_comparator.retrieve_uds_feed_names
end


Then(/^All the names in the feed should have corresponding description$/) do
  true == feed_comparator.description_exists_solr?
end