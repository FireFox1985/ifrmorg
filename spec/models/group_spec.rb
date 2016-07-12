# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#

describe Group do
  it "creates a group" do
    new_group = create(:group, description: 'Test Description')
    expect(Group.count).to eq(1)
  end

  it "does not create a group" do
    new_group = build(:bad_group)
    expect(new_group).to have(1).error_on(:description)
  end

  describe "#led_by?" do
    context "when user is not a leader of the group" do
      it "returns false" do
        user = create :user1
        group = create :group_with_member, userid: user.id, leader: false

        result = group.led_by?(user)

        expect(result).to be false
      end
    end

    context "when user is a leader of the group" do
      it "returns true" do
        user = create :user1
        group = create :group_with_member, userid: user.id, leader: true

        result = group.led_by?(user)

        expect(result).to be true
      end
    end
  end

  describe "#leaders" do
    context "when group has leaders" do
      it "returns the leaders" do
        leader = create :user1
        non_leader = create :user2
        group = create :group_with_member, userid: leader.id, leader: true
        create :group_member, userid: non_leader.id, groupid: group.id,
                              leader: false

        result = group.leaders

        expect(result).to eq [leader]
      end
    end

    context "when group has no leaders" do
      it "returns an empty array" do
        non_leader = create :user1
        group = create :group_with_member, userid: non_leader.id, leader: false

        result = group.leaders

        expect(result).to eq []
      end
    end
  end

  describe "#members" do
    it "returns group members in alphabetical order" do
      group = create :group
      names = ['bryan', 'charlie', 'alex']
      names.each do |name|
        user = create :user1, name: name
        create :group_member, userid: user.id, groupid: group.id
      end

      result = group.members

      expect(result.map(&:name)).to eq ['alex', 'bryan', 'charlie']
    end
  end

  describe '#destroy' do
    before(:each) do
      @group = create :group
      @meeting = create :meeting, groupid: @group.id
    end

    it 'destroys associated meetings' do
      expect { @group.destroy }.to change(Meeting, :count).by(-1)
    end

    it 'destroys associated meeting_members' do
      create :meeting_member, meeting: @meeting

      expect { @group.destroy }.to change(MeetingMember, :count).by(-1)
    end

    it 'destroys associated notifications' do
      group = create :group
      create_notification_for(group)

      expect { group.destroy }.to change(Notification, :count).by(-1)
    end
  end

  describe '#notifications' do
    it 'returns the notifications with a uniqueid contiaining "new_group"' do
      group = build_stubbed :group
      notification = create_notification_for(group)

      result = group.notifications

      expect(result).to eq [notification]
    end
  end

  def create_notification_for(group)
    data = { groupid: group.id }.to_json
    create :notification, uniqueid: 'new_group_1', data: data
  end
end
