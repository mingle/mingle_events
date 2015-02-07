require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'test_helper'))

module MingleEvents
  module Feed

    class AuthorTest < MiniTest::Test

      def test_parse_attributes
        author_xml = %{
          <author xmlns="http://www.w3.org/2005/Atom" xmlns:mingle="http://www.thoughtworks-studios.com/ns/mingle">
            <name>Sammy Soso</name>
            <email>sammy@example.com</email>
            <uri>https://mingle.example.com/api/v2/users/233.xml</uri>
            <mingle:icon>https://mingle.example.com/user/icon/233/profile.jpg</mingle:icon>
          </author>
        }
        author = Author.from_snippet(author_xml)
        assert_equal("Sammy Soso", author.name)
        assert_equal("sammy@example.com", author.email)
        assert_equal("https://mingle.example.com/api/v2/users/233.xml", author.uri)
        assert_equal("https://mingle.example.com/user/icon/233/profile.jpg", author.icon_uri)
      end

      def test_parse_attributes_when_no_optional_fields
        author_xml = %{
          <author xmlns="http://www.w3.org/2005/Atom" xmlns:mingle="http://www.thoughtworks-studios.com/ns/mingle">
            <name>Sammy Soso</name>
          </author>
        }
        author = Author.from_snippet(author_xml)
        assert_equal("Sammy Soso", author.name)
        assert_nil(author.email)
        assert_nil(author.uri)
        assert_nil(author.icon_uri)
      end

    end

  end
end
