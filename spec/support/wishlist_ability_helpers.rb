RSpec.shared_examples_for 'allow CRUD' do
  it { is_expected.to be_able_to(:read,    resource, token) }
  it { is_expected.to be_able_to(:create,  resource, token) }
  it { is_expected.to be_able_to(:update,  resource, token) }
  it { is_expected.to be_able_to(:destroy, resource, token) }
end

RSpec.shared_examples_for 'access denied' do
  it { is_expected.not_to be_able_to(:read,   resource) }
  it { is_expected.not_to be_able_to(:create, resource) }
  it { is_expected.not_to be_able_to(:update, resource) }
end

RSpec.shared_examples_for 'no index allowed' do
  it { is_expected.not_to be_able_to(:index, resource) }
end

RSpec.shared_examples_for 'create only' do
  it { is_expected.not_to be_able_to(:read,   resource) }
  it { is_expected.not_to be_able_to(:index,  resource) }
  it { is_expected.to     be_able_to(:create, resource) }
  it { is_expected.not_to be_able_to(:update, resource) }
end

RSpec.shared_examples_for 'read only' do
  it { is_expected.to     be_able_to(:read,   resource) }
  it { is_expected.to     be_able_to(:index,  resource) }
  it { is_expected.not_to be_able_to(:create, resource) }
  it { is_expected.not_to be_able_to(:update, resource) }
end
