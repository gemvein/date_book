module ControllerMacros
  def login_user(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end
end

shared_context 'authentication for routes' do
  let(:warden) do
    instance_double('Warden::Proxy').tap do |warden|
      allow(warden).to receive(:authenticate?).with(scope: :user)
        .and_return(authenticated?)
      allow(warden).to receive(:user).with(:user).and_return(user)
    end
  end
  let(:user) { instance_double(User) }
  let(:authenticated?) { true }
end

def simulate_running_with_devise
  stub_const(
    'Rack::MockRequest::DEFAULT_ENV',
    Rack::MockRequest::DEFAULT_ENV.merge('warden' => warden)
  )
end
