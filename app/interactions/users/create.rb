class Users::Create < ActiveInteraction::Base
  string  :name, :surname, :patronymic, :email, :nationality, :country, :gender, :full_name
  integer :age
  array   :interests, default: []
  array   :skills, default: []

  validates :name, :surname, :patronymic, :email, :age, :nationality, :country, :gender, :full_name, presence: true
  validates :age, numericality: { greater_than: 0, less_than_or_equal_to: 90 }
  validates :gender, inclusion: { in: %w[male female] }

  set_callback :execute, :after do
    if @user.persisted?
      add_interests(@user)
      add_skills(@user)
    end
  end

  def execute
    @user = create_user
    @user
  end

  def create_user
    user_full_name = "#{surname} #{name} #{patronymic}"
    User.create(
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
    user.interests.concat(Interest.where(name: interests)) if interests.present?
  end

  def add_skills(user)
    user.skills.concat(Skill.where(name: skills)) if skills.present?
  end
end
