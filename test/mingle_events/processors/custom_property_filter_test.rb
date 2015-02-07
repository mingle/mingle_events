require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'test_helper'))

module MingleEvents
  module Processors

    class CustomPropertyFilterTest < MiniTest::Test

      def setup
        @high_priority_event = stub_event(true, :custom_properties => {'Priority' => 'High'})
        @page_event = stub_event(false)
        @low_priority_event = stub_event(true, :custom_properties => {'Priority' => 'Low'})
        @high_severity_event = stub_event(true, :custom_properties => {'Severity' => 'High'})

        @card_data = {}
        def @card_data.for_card_event(card_event)
          card_event.data
        end

        @filter = CustomPropertyFilter.new('Priority', 'High', @card_data)
      end

      def test_match_on_property_value
        assert @filter.match?(@high_priority_event)
        assert !@filter.match?(@low_priority_event)
        assert !@filter.match?(@high_severity_event)
      end

      def test_does_not_match_delete_card
        @high_priority_event.data = nil
        assert !@filter.match?(@high_priority_event)
      end

      private

      def stub_event(is_card, data=nil)
        OpenStruct.new(:card? => is_card, :data => data)
      end

    end
  end
end
