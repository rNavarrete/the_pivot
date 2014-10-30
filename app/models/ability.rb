class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.is? :admin
        can :manage, :all
      # elsif user.is? :seller
      #   can :manage, :store if user.store_id == store.id
      else
        can :read, :all
      end

  end
end
