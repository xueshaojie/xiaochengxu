class Article < ApplicationRecord
  validates :title, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :latest, -> { order('articles.created_at DESC') }


  enum_attr :status, in: [
    ['draft', 0, '草稿'],
    ['publish', 1, '发布']
  ]


  enum_attr :category, in: [
    ['life', 0, '生活'],
    ['job', 1, '工作'],
    ['jotting', 2, '随笔'],
    ['other', 3, '其他']
  ]
end
