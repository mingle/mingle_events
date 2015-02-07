require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'test_helper'))

module MingleEvents
  module Processors

    class CardTypeFilterTest < MiniTest::Test

      def setup
        @story_event = stub_event(true, {:card_type_name => 'story'})
        @page_event = stub_event(false)
        @bug_event = stub_event(true, {:card_type_name => 'bug'})
        @issue_event = stub_event(true, {:card_type_name => 'issue'})

        @card_data = {}
        def @card_data.for_card_event(card_event)
          card_event.data
        end

        @filter = CardTypeFilter.new(['story', 'issue'], @card_data)
      end

      def test_does_not_match_non_card_events
        assert !@filter.match?(@page_event)
      end

      def test_match_on_card_type
        assert @filter.match?(@story_event)
        assert @filter.match?(@issue_event)
        assert !@filter.match?(@bug_event)
      end

      def test_does_not_match_deleted_cards
        @story_event.data = nil
        assert !@filter.match?(@story_event)
      end

      private

      def stub_event(is_card, data=nil)
        OpenStruct.new(:card? => is_card, :data => data)
      end

    end
  end
end
