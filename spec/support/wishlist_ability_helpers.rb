shared_examples_for 'allow CRUD' do
  it { should be_able_to(:read,    resource, token) }
  it { should be_able_to(:create,  resource, token) }
  it { should be_able_to(:update,  resource, token) }
  it { should be_able_to(:destroy, resource, token) }
end

shared_examples_for 'access denied' do
  it { should_not be_able_to(:read,   resource) }
  it { should_not be_able_to(:create, resource) }
  it { should_not be_able_to(:update, resource) }
end

shared_examples_for 'no index allowed' do
  it { should_not be_able_to(:index, resource) }
end

shared_examples_for 'create only' do
  it { should_not be_able_to(:read,   resource) }
  it { should_not be_able_to(:index,  resource) }
  it { should     be_able_to(:create, resource) }
  it { should_not be_able_to(:update, resource) }
end

shared_examples_for 'read only' do
  it { should     be_able_to(:read,   resource) }
  it { should     be_able_to(:index,  resource) }
  it { should_not be_able_to(:create, resource) }
  it { should_not be_able_to(:update, resource) }
end