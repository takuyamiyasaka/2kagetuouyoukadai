class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   attachment :profile_image
   has_many :books, dependent: :destroy
   has_many :favorites, dependent: :destroy
   has_many :post_comments, dependent: :destroy

   has_many :relationships
   has_many :followings, through: :relationships, source: :follow
   has_many :revers_of_relationships, class_name: "Relationship", foreign_key: "follow_id"
   has_many :followers, through: :revers_of_relationships, source: :user
   validates :introduction, length:  {maximum: 50}
   validates :name, length: { in: 2..20}

   def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def User.search(search, user_or_book, how_search)
    if user_or_book == "1"
      if how_search == "1"
        User.where(["name LIKE ?", "#{search}"])
      elsif how_search == "2"
        User.where(["name LIKE ?", "#{search}%"])
      elsif how_search == "3"
        User.where(["name LIKE ?", "%#{search}"])
      elsif how_search == "4"
        User.where(["name LIKE ?", "%#{search}%"])
      else
        User.all
      end
    end
  end
end
