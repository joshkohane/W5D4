require 'securerandom'
# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedURL < ApplicationRecord
    validates :short_url, :long_url, :user_id, presence: true
    validates :short_url, :long_url, uniqueness: true

    belongs_to :submitter,
        foreign_key: :user_id,
        class_name: :User

    def self.random_code(url)
        while true
            generate = SecureRandom.urlsafe_base64(url.length) 
            return generate unless self.exists?(generate)
        end
    end
end
