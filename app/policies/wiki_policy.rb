class WikiPolicy < ApplicationPolicy

  
  def show?
    if record.private? == true
      user.premium? || user.admin?
    elsif record.private? == false
      user.present?
    end
  end



  def new?
    create?
  end

  def create?
    user.present?
  end

  def edit?
    user.present?
  end

  def update?
    if record.private? == true
      user.premium? || user.admin?
    elsif record.private? == false
      user.present?
    end
  end

  def destroy?
     record.user.role == "admin" || record.user == user
  end

  class Scope

    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end
  end
end
