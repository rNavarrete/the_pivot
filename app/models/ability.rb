class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.is? :admin
      can :manage, :all
    elsif user.is? :seller
      can :manage, Store, user_id: user.id
      cannot :create, Store
    else
      can :read, :all
    end
  end
end
