# frozen_string_literal: true

module Api
  class ArticlesController < ApplicationController
    def create
      article_payload = article_create_params
      article = Article.new(*article_payload)
      article.user = @user
      article.save
      render status: :created
    end

    def index
      all_articles = map_articles(Article.all.includes(:user))
      render json: all_articles
    end

    def me
      my_articles = @user.articles.includes(:user)
      render json: map_articles(my_articles)
    end

    private

    def article_create_params
      params.permit(:title, :body, :description, tags: [])
    end

    def map_articles(articles)
      articles.map do |article|
        new_article = article.as_json
        new_article.delete('user_id')
        new_article[:user] = article.user.as_json(except: [:password_digest])
        new_article
      end
    end
  end
end
