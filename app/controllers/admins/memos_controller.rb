# frozen_string_literal: true

module Admins
  class MemosController < Admins::BaseController
    before_action :set_memo, only: %i[update destroy show]

    def index
      @data = Memo.all.order(updated_at: 'DESC')

      respond_to do |format|
        format.html
        format.json { render json: @data }
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
      respond_to do |_format|
        if @memo.update(memo_params)
          render json: { registration: 'update success' }
        else
          render json: { registration: 'insert failure' }
        end
      end
    end

    def destroy
      respond_to do |_format|
        if @memo.destroy
          render json: { registration: 'delete success' }
        else
          render json: { registration: 'delete failure' }
        end
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
