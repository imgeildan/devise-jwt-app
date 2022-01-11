RSpec.describe KeyResult, type: :model do
  describe 'validations', type: :model do
    before do
      @user = create(:user)
      @goal = create(:goal, user_id: @user.id)
    end

    subject { KeyResult.new(title: 'key_result', user_id: @user.id, goal_id: @goal.id )}

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
end