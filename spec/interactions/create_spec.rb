require 'rails_helper'

RSpec.describe Users::Create, type: :interactor do
  let(:user_attributes) { attributes_for(:user) }
  let(:skills)          { create_list(:skill, 2).map(&:name) }
  let(:interests)       { create_list(:interest, 2).map(&:name) }

  describe 'user' do
    subject { described_class.run(user_attributes) }

    it 'user is succesfully created' do
      expect(subject.result).to be_persisted
    end

    it 'user has valid attributes' do
      expect(subject.result).to have_attributes(user_attributes)
    end

    it 'user age is within 1 and 90' do
      expect(subject.result.age).to be_between(1, 90)
    end

    it 'user has valid gender' do
      expect(%w[male female]).to include(subject.result.gender)
    end
  end

  describe 'arrays' do
    subject { described_class.run(user_attributes) }

    it 'user interests as an array' do
      expect(subject.result.interests.to_a).to be_an(Array)
    end

    it 'user skills as an array' do
      expect(subject.result.skills.to_a).to be_an(Array)
    end
  end

  describe 'interests and skills' do
    subject { described_class.run(user_attributes.merge(interests: interests, skills: skills)) }

    it 'add interests to user' do
      expect(subject.result.interests.map(&:name)).to match_array(interests)
    end

    it 'add skills to user' do
      expect(subject.result.skills.map(&:name)).to match_array(skills)
    end
   end
end
