# frozen_string_literal: true

module Api
  class CommentsController < ApplicationController
    before_action :set_article

    def create
      comment = Comment.new(content: comment_payload)
      comment.article = @article
      comment.user = @user
      comment.save
      render status: :created
    end

    def index
      render json: @article.comments.as_json(except: %i[article_id user_id])
    end

    def destroy
      Comment.find(params[:id]).delete
      render status: :no_content
    end

    private

    def set_article
      @article = Article.includes(:comments).find(params[:article_id])
    end

    def comment_payload
      params.require(:content)
    end
  end
end
