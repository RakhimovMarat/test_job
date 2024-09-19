class Users::Create < ActiveInteraction::Base
  string  :name, :surname, :patronymic, :email, :nationality, :country, :full_name
  integer :age, :gender
  array   :interests, default: []
  array   :skills, default: []

  validates :name, :surname, :patronymic, :email, :age, :nationality, :country, :gender, :full_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :age, numericality: true, inclusion: { in: 1..90 }

  enum gender: { male: 0, female: 1 }

  def execute
    user = create_user
    add_interests(user)
    add_skills(user)
  end

  def create_user
    user_full_name = "#{surname} #{name} #{patronymic}"
    User.create!(
      name: name,
      surname: surname,
      patronymic: patronymic,
      email: email,
      age: age,
      nationality: nationality,
      country: country,
      gender: gender,
      full_name: user_full_name
    )
  end

  def add_interests(user)
    user.interests << Interest.where(name: interests) if interests.present?
  end

  def add_skills(user)
    user.skills << Skill.where(name: skills) if skills.present?
  end
end
