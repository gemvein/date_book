shared_context 'users' do
  let(:admin_user) { User.find_by_name('Admin User') }
  let(:regular_user) { User.find_by_name('Regular User') }
end
