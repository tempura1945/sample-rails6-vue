# frozen_string_literal: true

class Memo < ApplicationRecord
  validates :name, length: { maximum: 20 }, presence: true
  validates :comment, length: { maximum: 100 }, presence: true
end
