# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    create?
  end

  def edit?
    create?
  end

  def destroy?
    create?
  end
  
  def update?
    create?
  end

  def create?
    @user.has_any_role? :admin, :moderator
  end
end
