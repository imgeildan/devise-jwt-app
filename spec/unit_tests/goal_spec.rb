RSpec.describe Goal, type: :model do
  describe 'goal' do
    before do
      @user = create(:user)
    end

    subject { Goal.new(title: 'goal', user_id: @user.id )}

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

    describe 'calculate_progress' do
      before do
        @goal = create(:goal, user_id: @user.id)
        @key_result = create(:key_result, user_id: @user.id, goal_id: @goal.id )
      end

      it 'returns zero if key results are not completed' do
        expect(@goal.calculate_progress).to eq(0)
      end

      it 'returns fifty, if half of the key results are completed' do
        create(:key_result, user_id: @user.id, goal_id: @goal.id, status: 'completed')  
        expect(@goal.calculate_progress).to eq(50)
        expect(@goal.key_results.count).to eq(2)
      end

      it 'returns 100, if all the key results are completed' do
        @key_result.update_columns(status: 'completed')
        expect(@goal.calculate_progress).to eq(100)
        expect(@goal.key_results.count).to eq(1)
      end
    end
  end
end