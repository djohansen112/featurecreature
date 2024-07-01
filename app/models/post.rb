class Post < ApplicationRecord
  has_one_attached :cover_image
  has_rich_text :content
  belongs_to :category
  has_many :comments

  validates :title, presence: true
  validates :content, presence: true

  scope :sorted, -> { order(arel_table[:published_at].desc.nulls_first) }
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where('published_at <= ?', Time.current) }
  scope :scheduled, -> { where('published_at > ?', Time.current) }

  def draft?
    published_at.nil?
  end

  def scheduled?
    published_at? && published_at > Time.current
  end

  def published?
    published_at? && published_at <= Time.current
  end
end
