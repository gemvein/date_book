shared_examples_for 'a successful page' do |options = {}|
  describe 'responds successfully' do
    subject { response }
    it { should be_success }
  end
  if options[:which_renders].present?
    it_behaves_like 'a page rendering a template', options[:which_renders]
  end
  if options[:with_layout].present?
    it_behaves_like 'a page rendering with a layout', options[:with_layout]
  end
end
shared_examples_for 'a page rendering a template' do |template|
  describe "renders the #{template} template" do
    subject { response }
    it { should render_template(template) }
  end
end
shared_examples_for 'a page rendering with a layout' do |layout|
  describe "renders the #{layout} layout" do
    subject { response }
    it { should render_template("layouts/#{layout}") }
  end
end
shared_examples_for 'an error response' do |http_status|
  describe "issues error response code #{http_status}" do
    subject { response }
    it { should have_http_status(http_status) }
  end
end
shared_examples_for 'a redirect to' do |path|
  describe "redirects to #{path}" do
    subject { response }
    it { should redirect_to path_to_url(path) }
  end
end
shared_examples_for 'a redirect matching' do |path_expression|
  describe "redirects matching #{path_expression}" do
    subject { response.location }
    it { should match path_expression }
  end
end
shared_examples_for 'a redirect to the home page' do
  it_behaves_like 'a redirect to', '/'
end
shared_examples_for 'an error response with message' do |status, message|
  it_behaves_like 'an error response', status
  it_behaves_like 'a page with message', :error, message
end
shared_examples_for 'a page with message' do |flash_key, error|
  describe 'sets message' do
    subject { flash[flash_key] }
    it { should eq error }
  end
end
shared_examples_for 'a page without error' do
  describe 'sets no error message' do
    subject { flash[:error] }
    it { should be nil }
  end
end
shared_examples_for 'a 403 Forbidden error' do
  it_should_behave_like(
    'an error response with message',
    :forbidden,
    'You are not authorized to access this page.'
  )
end
shared_examples_for 'a 404 Not Found error' do
  it_should_behave_like(
    'an error response with message',
    :not_found,
    'The page you requested does not exist.'
  )
end
shared_examples_for 'a redirect with notice' do |path, message|
  it_behaves_like 'a redirect to', path
  describe 'sets notice' do
    subject { flash[:notice] }
    it { should eq message }
  end
end
shared_examples_for 'a redirect with alert' do |path, message|
  it_behaves_like 'a redirect to', path
  describe 'sets alert' do
    subject { flash[:alert] }
    it { should eq message }
  end
end
shared_examples_for 'a download' do
  subject { response.headers['Content-Disposition'] }
  it { should include 'attachment' }
end
shared_examples_for 'a variable assignment' do |options = {}|
  options.each do |key, value|
    describe "@#{key}" do
      subject { assigns(key) }
      it { should eq value }
    end
  end
end
