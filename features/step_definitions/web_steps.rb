require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

# Single-line step scoper
When /^(.*) within (.*[^:])$/ do |step, parent|
  with_scope(parent) { When step }
end

# Multi-line step scoper
When /^(.*) within (.*[^:]):$/ do |step, parent, table_or_string|
  with_scope(parent) { When "#{step}:", table_or_string }
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )click "([^"]*)"$/ do |button|
    find(button)
    click_link(button)
end


When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select or option
# based on naming conventions.
#
When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field)
end

When /^(?:|I )uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end

When /^(?:|I )choose "([^"]*)"$/ do |field|
  choose(field)
end

When /^(?:|I )attach the file "([^"]*)" to "([^"]*)"$/ do |path, field|
  attach_file(field, File.expand_path(path))
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_no_xpath('//*', :text => regexp)
  else
    assert page.has_no_xpath?('//*', :text => regexp)
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should not contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should_not
      field_value.should_not =~ /#{value}/
    else
      assert_no_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" field should have the error "([^"]*)"$/ do |field, error_message|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')

  form_for_input = element.find(:xpath, 'ancestor::form[1]')
  using_formtastic = form_for_input[:class].include?('formtastic')
  error_class = using_formtastic ? 'error' : 'field_with_errors'

  if classes.respond_to? :should
    classes.should include(error_class)
  else
    assert classes.include?(error_class)
  end

  if page.respond_to?(:should)
    if using_formtastic
      error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
      error_paragraph.should have_content(error_message)
    else
      page.should have_content("#{field.titlecase} #{error_message}")
    end
  else
    if using_formtastic
      error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
      assert error_paragraph.has_content?(error_message)
    else
      assert page.has_content?("#{field.titlecase} #{error_message}")
    end
  end
end

Then /^the "([^"]*)" field should have no error$/ do |field|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')
  if classes.respond_to? :should
    classes.should_not include('field_with_errors')
    classes.should_not include('error')
  else
    assert !classes.include?('field_with_errors')
    assert !classes.include?('error')
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_true
    else
      assert field_checked
    end
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should not be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_false
    else
      assert !field_checked
    end
  end
end
 
Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')} 
  
  if actual_params.respond_to? :should
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end

Then /^show me the page$/ do
  save_and_open_page
end

When(/^I wait for the ajax request to finish$/) do
    start_time = Time.now
    page.evaluate_script( 'jQuery.isReady&&jQuery.active==0' ).
      class.should_not eql(String) 

    until page.evaluate_script('jQuery.isReady&&jQuery.active==0') or 
          (start_time + 5.seconds) < Time.now do
            sleep 1
    end
end

def wait_for_ajax
    # See: https://gist.github.com/10c41024510ee9f235e0
    # Linked from: http://techblog.fundinggates.com/blog/2012/08/capybara-2-0-upgrade-guide/
    start = Time.now
    while true
      break if (page.evaluate_script("$.active") == 0)
      if Time.now > start + Capybara.default_max_wait_time.seconds
        fail "AJAX did not register as complete after #{Capybara.default_max_wait_time} seconds!"
      end
      sleep 0.1
    end
  end

  Given /^I (am logged in|login) as (.*)?$/ do |_,who|
    @user = User.create!({
      email: "user@gmail.com",
      id: 1,
      created_at: DateTime.now,
      updated_at: DateTime.now,
      password: "password"
  
    })
    @user.save

    @user = User.create!({
      email: "admin@gmail.com",
      id: 2,
      created_at: DateTime.now,
      updated_at: DateTime.now,
      password: "administrator",
      roles_mask: 2
    })
    @user.save

    case who
      when /administrator/i then @user,@password = User.find(2),'administrator'
      when /student/i then @user,@password = User.find(1),"password" 
    end

    visit('http://localhost:3000/users/sign_in')
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @password
    click_on 'commit'

    page.should have_content("You are succesfully logged in")
    
  end

  

  Given('I am not logged in') do
    delete "/users/sign_out"
  end

  Given /^an existing secondhand with ISBN 9788808420206/ do
    visit("/secondhands/new")
    fill_in("Isbn", :with => "9788808420206")
    attach_file("Image", File.expand_path("db/seeds/fisica_1.jpg"))
    fill_in("Description", :with => "Some description")

    click_on "commit"

    
  end

  Given /^an existing and approved secondhand with title: Lezioni di fisica. Con e-book. Vol. 1: Meccanica, termodinamica./ do
    user = User.find(1)
    book = Book.find(1)

    secondhand = Secondhand.create(
      description: "Some description",
      id: 1,
      approved: true
    )

    secondhand.user_id = 1
    secondhand.book_id = 1
    secondhand.image.attach(io: File.open("db/seeds/fisica_1.jpg"), filename: "fisica_1.jpg")

    secondhand.save
  end

  Given /^an existing and not approved secondhand with title: Lezioni di fisica. Con e-book. Vol. 1: Meccanica, termodinamica./ do
    user = User.find(1)
    book = Book.find(1)

    secondhand = Secondhand.create(
      description: "Some description",
      id: 1,
      approved: false
    )

    secondhand.user_id = 1
    secondhand.book_id = 1
    secondhand.image.attach(io: File.open("db/seeds/fisica_1.jpg"), filename: "fisica_1.jpg")

    secondhand.save
  end

  Given /^an existing secondhand with id: 1 on book with id:1/ do
    user = User.find(1)
    book = Book.find(1)

    secondhand = Secondhand.create(
      description: "Some description",
      id: 1
    )

    secondhand.user_id = 1
    secondhand.book_id = 1
    secondhand.image.attach(io: File.open("db/seeds/fisica_1.jpg"), filename: "fisica_1.jpg")

    secondhand.save
    
  end

  Given /^existing book with id: 1 and on the favorite list of user/ do

  element = Book.create(
    id: 1,
    ISBN: 9788808420206,
    title: "Lezioni di fisica. Con e-book. Vol. 1: Meccanica, termodinamica.",
    stock: 3,
    description: "Libro di Fisica 1"
  )

  element.placeholder.attach(io: File.open("db/seeds/fisica_1.jpg"), filename: "fisica_1.jpg")
      element.author << Author.find_by(name: "Daniele Sette")
      element.author << Author.find_by(name: "Mario Bertolotti")
      element.author << Author.find_by(name: "Adriano Alippi")
      element.course << Course.find_by(name: "Ingegneria Informatica e Automatica")
      element.course << Course.find_by(name: "Fisica")
      element.category << Category.find_by(name: "Fisica")
      element.save 

      user = User.find(1)
      user.book << element
      user.save
  end

  Given /the presence of existing "([^"]*)"$/ do |object|
    case object
    when /Authors/i then elements = Author.create([{
        name: "Daniele Sette"
    },
    {
      name: "Mario Bertolotti"
    },
    {
      name: "Adriano Alippi"
    }])

    when /Courses of study/i then elements = Course.create([{
      name: "Ingegneria Informatica e Automatica"
    },
    {
      name: "Matematica"
    },
    {
      name: "Fisica"
    }])

    when /Categories/i then elements = Category.create([{
        name: "Matematica"
    },
    {
      name: "Fisica"
    },
    {
      name: "Chimica"
    }])

    when /Books/i then element = Book.create(
      id: 1,
      ISBN: 9788808420206,
      title: "Lezioni di fisica. Con e-book. Vol. 1: Meccanica, termodinamica.",
      stock: 3,
      description: "Libro di Fisica 1"
    )
    
  end

  if elements.present?
    elements.each do |element|
      element.save
    end
  else
    
      element.placeholder.attach(io: File.open("db/seeds/fisica_1.jpg"), filename: "fisica_1.jpg")
      element.author << Author.find_by(name: "Daniele Sette")
      element.author << Author.find_by(name: "Mario Bertolotti")
      element.author << Author.find_by(name: "Adriano Alippi")
      element.course << Course.find_by(name: "Ingegneria Informatica e Automatica")
      element.course << Course.find_by(name: "Fisica")
      element.category << Category.find_by(name: "Fisica")
      element.save    
  end

  end

  