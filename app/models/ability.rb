class Ability
  include CanCan::Ability

  def initialize user
    can %i(read), Book

    if user.admin?
      can :manage, :all
    else
      can %i(create update destroy), OrderDetail
      can %i(read update), User, id: user.id
    end
  end
end
