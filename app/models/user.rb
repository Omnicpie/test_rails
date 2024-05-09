# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :trackable, :lockable, :jwt_authenticatable, :registerable,
    jwt_revocation_strategy: JwtDenylist

  # Active Storage
  # has_one_attached :image, dependent: :destroy

  # associations
  has_many :events

  # Validations
  validates :name, presence: true
  validates :email, presence: true

  # Methods
  def self.sortable_columns
    %w[email created_at first_name surname job]
  end

  def self.default_sort
    ["created_at", "desc"]
  end
end
