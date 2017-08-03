shared_examples_for 'a restricted page' do
  describe 'redirects to the home page' do
    subject { current_path }
    it { should eq '/users/sign_in' }
  end
  it_behaves_like(
    'a bootstrap page with an alert',
    'danger',
    'You must sign in or sign up to access this content.'
  )
end

shared_examples_for 'an authentication error' do
  describe 'redirects to the home page' do
    subject { current_path }
    it { should eq '/' }
  end
  it_behaves_like(
    'a bootstrap page with an alert',
    'danger',
    'You must sign in or sign up to access this content.'
  )
end

shared_examples_for 'an authorization error' do
  it_behaves_like(
    'a bootstrap page with an alert',
    'danger',
    'You are not authorized to access this page.'
  )
end

shared_examples_for 'an admin page' do
  subject { page }
  it { should have_css 'body.rails_admin' }
end

shared_examples_for 'a bootstrap page' do |options = {}|
  include ERB::Util
  describe 'displays a page with bootstrap elements' do
    subject { page }
    if options[:title].present?
      it { should have_title options[:title] }
      it { should have_xpath '//h1', text: options[:title] }
    end
    it do
      should have_selector(
        '.navbar .navbar-header .navbar-brand',
        text: BootstrapLeather.configuration.application_title
      )
    end
  end
end

shared_examples_for 'a bootstrap page '\
                    'with a dropdown navigation list' do |options|
  if options[:text]
    context "has a #{options[:text]} link" do
      before do
        click_button 'Menu'
      end
      it do
        should(
          have_selector('li.dropdown a.dropdown-toggle', text: options[:text])
        )
      end
    end
    if options[:links]
      options[:links].each do |link_text|
        it "has a #{link_text} link" do
          click_link_or_button 'Menu'
          within find('.navbar', text: options[:text]) do
            click_link_or_button options[:text]
            within first('li.dropdown', text: options[:text]) do
              expect(page).to have_link(link_text)
            end
          end
        end
      end
    end
  else
    it { should have_selector 'li.dropdown a.dropdown-toggle' }
  end
end

shared_examples_for 'a bootstrap page with an alert' do |type, text|
  before do
    wait_until { page.has_css? '.alert' }
  end
  subject { page }
  it { should have_selector ".alert.alert-#{type}", text: text }
end

shared_examples_for 'a bootstrap page '\
                    'listing a collection of items' do |object, options = {}|
  options[:minimum] ||= 1
  options[:plural_title] ||= object.model_name.human.pluralize(2).titlecase
  options[:plural_name] ||= object.table_name
  collection_css_class = options[:plural_name]
  member_css_class = options[:plural_name].singularize
  it_behaves_like 'a bootstrap page', title: options[:plural_title]
  describe "displays a list of .#{collection_css_class} in "\
           ".#{member_css_class}" do
    subject { page }
    it do
      should have_css(
        ".#{collection_css_class} .#{member_css_class}",
        minimum: options[:minimum]
      )
    end
  end
end

shared_examples_for 'a bootstrap page '\
                    'showing an item' do |object, title, options = {}|
  options[:css_class] ||= object.table_name.singularize
  it_behaves_like 'a bootstrap page', title: title
  describe "displays an item at .#{options[:css_class]}" do
    subject { page }
    it { should have_css(".#{options[:css_class]}") }
  end
end

shared_examples_for 'a bootstrap page with a gallery' do |options = {}|
  css = ''
  test_name = 'displays a gallery'
  if options[:inside]
    test_name += " inside #{options[:inside]}"
    css += "#{options[:inside]} "
  end
  css += '.gallery'
  describe test_name do
    subject { page }
    it { should have_css(css) }
  end
end

shared_examples_for 'a bootstrap form with errors' do |error_fields|
  subject { page }
  error_fields.each do |field|
    it_behaves_like(
      'a bootstrap page with an alert',
      'danger',
      "#{field.to_s.humanize} can't be blank"
    )
    it "shows errors on #{field}" do
      expect(page.has_css?("[id$=#{field}]")).to be true
    end
  end
end
