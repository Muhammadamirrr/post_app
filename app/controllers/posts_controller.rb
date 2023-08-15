# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_base_url
  before_action :set_post_id, only: %i[edit update destroy]

  def index
    @posts = fetch_data("#{@base_url}/posts")
  end

  def create
    response = send_request(:post, '/posts', post_params)

    if response.success?
      flash[:notice] = 'Post created successfully'
      redirect_to posts_path
    else
      handle_error(response, :new)
    end
  end

  def edit
    @post = fetch_data("#{@base_url}/posts/#{@post_id}")
  end

  def update
    response = send_request(:put, "/posts/#{@post_id}", post_params.merge(id: @post_id))

    if response.success?
      flash[:notice] = 'Post updated successfully'
      redirect_to posts_path
    else
      handle_error(response, :edit)
    end
  end

  def destroy
    response = send_request(:delete, "/posts/#{@post_id}")

    if response.success?
      flash[:notice] = 'Delete successful'
    else
      handle_error(response)
    end

    redirect_to posts_path
  end

  private

    def set_base_url
      @base_url = 'https://jsonplaceholder.typicode.com'
    end

    def fetch_data(url)
      response = Net::HTTP.get(URI(url))
      JSON.parse(response)
    end

    def set_post_id
      @post_id = params[:id]
    end

    def send_request(method, path, data = {})
      headers = { 'Content-Type' => 'application/json' }
      data[:userId] = current_user.id if %i[post put].include?(method)

      HTTParty.send(method, "#{@base_url}#{path}", headers:, body: data.to_json)
    end

    def handle_error(response, action = :index)
      flash[:alert] = "Error: #{response.code} - #{response.message}"
      render action
    end

    def post_params
      params.permit(:title, :body)
    end
end
