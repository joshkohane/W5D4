# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
    validates :email, presence: true
    validates :email, uniqueness: true

    has_many :submitted_urls,
        foreign_key: :user_id,
        class_name: :ShortenedURL

    def create_url(url)
        shortened_url = ShortenedURL.random_code(url)
        ShortenedURL.create!(short_url: shortened_url, long_url: url, user_id: self.id)
    end

end
