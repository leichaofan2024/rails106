class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :groups
  has_many :relationships
  has_many :participated_groups,:through => :relationships, :source => :group
  def is_member_of?(group)
    participated_groups.include?(group)
  end
  # def join!(group)
  #   current_user.participated_groups << group
  #   @group.members << current_user
  # end
  # def quit!(group)
  #   current_user.participated_groups.delete(group)
  #   @group.members.delete(current_user)
  # end

end
