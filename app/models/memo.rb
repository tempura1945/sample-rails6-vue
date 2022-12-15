# frozen_string_literal: true

class Memo < ApplicationRecord
  validates :name, length: { maximum: 20 }, presence: true
  validates :comment, length: { maximum: 100 }, presence: true


  def hoge
    # MySQL に接続します。
      my = Mysql.new('hogehoge.db.jjjjj121j.jp','admin','eawrewafd2','dbname')

      # SQL クエリを実行します。
      res = my.query('SELECT * from table_heteml')

      # 結果を表示します。
      res.eachdo|row|
      puts row[0]
  end
end
