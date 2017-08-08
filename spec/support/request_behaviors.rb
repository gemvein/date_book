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

shared_examples_for 'a graphql object '\
                    'showing an item' do |object|
  describe 'displays an item' do
    subject { JSON.parse(response.body)['data'][object.table_name.singularize] }
    it { should be_a Hash }
  end
end

shared_examples_for 'a graphql object '\
                    'listing a collection of items' do |object|
  describe 'displays a collection of items' do
    subject { JSON.parse(response.body)['data'][object.table_name] }
    it { should be_an Array }
  end
end
