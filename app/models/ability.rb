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

    can :like, Review do |r|
      user != r.user
    end
    cannot :like, Review do |r|
      user == r.user
    end

    can :favourite, Product do |product|
      user != product.user
    end
    cannot :favourite, Product do |product|
      user == product.user
    end

    can :vote, Review do |r|
      user != r.user
    end
    
    cannot :vote, Review do |r|
      user == r.user
    end

  end
end
