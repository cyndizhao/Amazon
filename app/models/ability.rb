class Ability < ApplicationRecord
  include CanCan::Ability
  def initialize(user)

    user ||= User.new

    if user.is_admin?
      can :manage, :all
    end

    can [:edit, :destroy], Product do |product|
      product.user == user
    end
    can [:edit, :destroy], Review do |review|
      review.user == user
    end
  end
end
