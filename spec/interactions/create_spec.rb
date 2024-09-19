require 'rails_helper'

RSpec.describe Users::Create, type: :interactor do
  subject { create :user }

  describe 'user' do
    it 'create new user' do
      expect(subject).to be_persisted
    end

    it 'user has valid attributes' do
      expect(subject).to have_attributes(
        name:        a_kind_of(String),
        surname:     a_kind_of(String),
        patronymic:  a_kind_of(String),
        email:       a_kind_of(String),
        age:         a_kind_of(Integer),
        nationality: a_kind_of(String),
        country:     a_kind_of(String),
        gender:      a_kind_of(String),
        full_name:   a_kind_of(String)
      )
    end

    it 'user age is within 1 and 90' do
      expect(subject.age).to be_between(1, 90)
    end

    it 'user has valid gender' do
      expect(%w[male female]).to include(subject.gender)
    end

    it 'user interests as an array' do
      expect(subject.interests.to_a).to be_an(Array)
    end

    it 'user skills as an array' do
      expect(subject.skills.to_a).to be_an(Array)
    end
  end

  describe 'interest' do
    let(:interests) { create_list(:interest, 2) }

    before do
      subject.interests << interests
    end

    it 'add interests to user' do
      expect(subject.interests).to match_array(interests)
    end
  end

  describe 'skill' do
    let(:skills) { create_list(:skill, 2) }

    before do
      subject.skills << skills
    end

    it 'add skills to user' do
      expect(subject.skills).to match_array(skills)
    end
  end
end
