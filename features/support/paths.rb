module NavigationHelpers
    # Maps a name to a path. Used by the
    #
    #   When /^I go to (.+)$/ do |page_name|
    #
    # step definition in web_steps.rb
    #
    def path_to(page_name)
      case page_name
  
      when /^the home\s?page$/
        '/'

      when /^the BiblioCommunity home page/
        '/'
      
      when /^the library page/
        '/library'

      when /^the books page/
        '/books'
  
      when /^the new book page/
        '/books/new'
      
      when /^the log in page/
        '/login'
        
      when /^the sign in page/
        '/users/sign_in'

      when /^the show book with id: 1 page/
        '/books/1'

      when /^the edit book with id: 1 page/
        '/books/1/edit'

      when /^the buy book with isbn: 9788808420206 page/
        '/book_scraper/9788808420206'

      when /^the secondhands page/
        '/secondhands'

      when /^the new secondhand page/
        '/secondhands/new'

      when /^the show secondhand with id: 1 page/
        'secondhands/1'

      when /^the edit secondhand with id: 1 page/
        '/secondhands/1/edit'

    
  
      # Add more mappings here.
      # Here is an example that pulls values out of the Regexp:
      #
      #   when /^(.*)'s profile page$/i
      #     user_profile_path(User.find_by_login($1))
  
      else
        begin
          page_name =~ /^the (.*) page$/
          path_components = $1.split(/\s+/)
          self.send(path_components.push('path').join('_').to_sym)
        rescue NoMethodError, ArgumentError
          raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
            "Now, go and add a mapping in #{__FILE__}"
        end
      end
    end
  end
  
  World(NavigationHelpers)