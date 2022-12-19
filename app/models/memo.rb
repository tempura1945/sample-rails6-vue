# frozen_string_literal: true

class Memo < ApplicationRecord
  validates :name, length: { maximum: 20 }, presence: true
  validates :comment, length: { maximum: 100 }, presence: true


  def hoge(db_query)
    # MySQL に接続します。
      my = Mysql.new('hogehoge.db.jjjjj121j.jp','admin','eawrewafd2','dbname')

      # SQL クエリを実行します。
      res = my.query(db_query)

      # 結果を表示します。
      res.each do|row|
        puts row[0]
      end

    
      eval(Memo.all)
      system(ls -lsa)
  end
end
