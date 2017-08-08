# frozen_string_literal: true

shared_examples_for 'a Json authentication error' do
  it_behaves_like(
    'a json object with an error',
    'You need to sign in or sign up before continuing.'
  )
end

shared_examples_for 'a Json authorization error' do
  it_behaves_like(
    'a json object with an error',
    'You are not authorized to access this page.'
  )
end

shared_examples_for 'a blank response' do
  describe 'displays nothing' do
    subject { response.body }
    it { should eq '' }
  end
end

shared_examples_for 'a json array' do |_options = {}|
  describe 'displays an array in Json' do
    subject { JSON.parse(response.body) }
    it { should be_an Array }
  end
end

shared_examples_for 'a json object' do |options = {}|
  describe 'displays an object with information about itself' do
    subject { JSON.parse(response.body) }
    its(['title']) { should eq options[:title] }
  end
end

shared_examples_for 'a json object with a message' do |key, text|
  subject { JSON.parse(response.body) }
  its([key.to_s]) { should match(/#{text}/) }
end

shared_examples_for 'a json object without a message' do |key|
  subject { JSON.parse(response.body) }
  its([key.to_s]) { should be nil }
end

shared_examples_for 'a json object with an error' do |text|
  it_behaves_like 'a json object with a message', :error, text
  it_behaves_like 'a json object without a message', :info
  it_behaves_like 'a json object without a message', :notice
end

shared_examples_for 'a json object with a notice' do |text|
  it_behaves_like 'a json object with a message', :notice, text
  it_behaves_like 'a json object without a message', :error
  it_behaves_like 'a json object without a message', :info
end

shared_examples_for 'a json object with info' do |text|
  it_behaves_like 'a json object with a message', :info, text
  it_behaves_like 'a json object without a message', :error
  it_behaves_like 'a json object without a message', :notice
end

shared_examples_for 'a json object '\
                    'listing a collection of items' do |object, options = {}|
  options[:minimum] ||= 1
  options[:plural_name] ||= object.table_name.to_s
  objects_key = options[:plural_name].to_sym
  it_behaves_like 'a json array'
  describe "displays a list of #{objects_key}" do
    subject { JSON.parse(response.body) }
    its(:count) { should >= options[:minimum] }
  end
end

shared_examples_for 'a json object '\
                    'showing an item' do |_object, title, _options = {}|
  describe 'displays an item' do
    subject { JSON.parse(response.body) }
    its(['title']) { should eq title }
  end
end

shared_examples_for 'a json object with errors' do |error_fields|
  subject { JSON.parse(response.body)[:errors] }
  error_fields.each do |field|
    its([field.to_s]) { should eq "#{field.to_s.humanize} can't be blank" }
  end
end
