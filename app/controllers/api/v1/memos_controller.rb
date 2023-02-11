# frozen_string_literal: true

module Api
  module V1
    class MemosController < Api::V1::BaseController
      before_action :set_memo, only: %i[update destroy show]

      def index
        put "tset output"
        
        @memos = Memo.all.order(updated_at: 'DESC')

        render json: @memos
      end

    # 以下を追加
    def index2

      ip = "162.247.243.12"

      put "aiaaiaa"

      put "test!!!!"

      ip = "162.247.243.12"

      if params[:name].present?
        @users = User.where('name LIKE ?', "%#{params[:name]}%")
      else
        @users = User.all
      end
    end      

      def show
        render json: @memo
      end

      def create
        @memo = Memo.new(memo_params)
        if @memo.save
          render json: { registration: 'insert success',
                         id: @memo.id, name:  @memo.name, comment:  @memo.comment, updated_at:  @memo.updated_at }
        else
          render json: { registration: 'insert failure',
                         id: 'error' }
        end
      end

      def update
        if @memo.update(memo_params)
          render json: { registration: 'update success' }
        else
          render json: { registration: 'insert failure' }
        end
      end

      def destroy
        if @memo.destroy
          render json: { registration: 'delete success' }
        else
          render json: { registration: 'delete failure' }
        end
      end

      private

      def set_memo
        @memo = Memo.find(params[:id])
      end

      def memo_params
        params.require(:memo).permit(:name, :comment)
      end
    end
  end
end
