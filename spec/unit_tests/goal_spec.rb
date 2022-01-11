RSpec.describe Goal, type: :model do
  subject { Goal.new(title: 'goal', user_id: create(:user).id )}

  before { subject.save }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'title should be present' do
    subject.title = nil
    expect(subject).not_to be_valid
  end

  it 'user should be present' do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end
end