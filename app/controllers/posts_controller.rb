# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post_id, only: %i[edit update destroy]

  def index
    @posts = JSONPlaceHolderService.new(:get, '/posts').fetch_data
  end

  def create
    response = JSONPlaceHolderService.new(:post, '/posts', post_params).send_request

    if response.success?
      flash['alert alert-success'] = 'Post created successfully'
      redirect_to posts_path
    else
      handle_error(response, :new)
    end
  end

  def edit
    @post =  JSONPlaceHolderService.new(:get, "/posts/#{@post_id}").fetch_data
  end

  def update
    response = JSONPlaceHolderService.new(:put, "/posts/#{@post_id}", post_params.merge(id: @post_id)).send_request

    if response.success?
      flash['alert alert-info'] = 'Post updated successfully'
      redirect_to posts_path
    else
      handle_error(response, :edit)
    end
  end

  def destroy
    response = JSONPlaceHolderService.new(:delete, "/posts/#{@post_id}").send_request

    if response.success?
      flash['alert alert-info'] = 'Delete successful'
    else
      handle_error(response)
    end

    redirect_to posts_path
  end

  private

    def fetch_data(url)
      response = Net::HTTP.get(URI(url))
      JSON.parse(response)
    end

    def set_post_id
      @post_id = params[:id]
    end

    def handle_error(response, action = :index)
      flash['alert alert-danger'] = "Error: #{response.code} - #{response.message}"
      render action
    end

    def post_params
      params.permit(:title, :body)
    end
end
