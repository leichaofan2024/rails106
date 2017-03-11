class Group < ApplicationRecord
has_many :relationships
has_many :members,:through => :relationships, :source => :user
belongs_to :user
end
