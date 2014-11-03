class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # if user.is? :admin
    #   can :manage, :all
    # elsif user.is? :seller
    # can :manage, Store, :user_id => user.id
      # can :manage, Store do |store|
      #   store.try(:potato) == user.id
      # end
      # can :manage, Store do |store|
      #   store.try(:user) == store
      # end
      #cannot :create, Store
    # else
    #   can :read, :all
    # end
  end
end
