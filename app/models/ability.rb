class Ability
 include CanCan::Ability

 def initialize(user)

     user ||= User.new # guest user (not logged in)
     if user.is? :admin
       can :manage, :all
     elsif user.is? :seller
       can :manage, Store #need to check that seller owns the store still
     else
       can :read, :all
     end

   end
 end