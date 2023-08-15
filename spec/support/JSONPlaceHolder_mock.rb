require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    # Stub GET request to JSONPlaceholder API
    stub_request(:get, 'https://jsonplaceholder.typicode.com/posts')
      .to_return(status: 200, body: '[{"id": 1, "title": "New Post1", "body": "Content", "userId": 1}, {"id": 2, "title": "New Post2", "body": "Content", "userId": 1}]', headers: {})

    # Stub GET request to JSONPlaceholder API for a single resource
    stub_request(:get, 'https://jsonplaceholder.typicode.com/posts/1')
      .to_return(status: 200, body: '{"id": 1, "title": "New Post1", "body": "Content", "userId": 1}', headers: {})

    # Stub POST request to JSONPlaceholder API
    stub_request(:post, 'https://jsonplaceholder.typicode.com/posts')
      .to_return(status: 201, body: '{"id": 1, "title": "New Post", "body": "Content", "userId": 1}', headers: {})

    # Stub PUT request to JSONPlaceholder API for post with ID 1
    stub_request(:put, 'https://jsonplaceholder.typicode.com/posts/1')
      .to_return(status: 200, body: '{"id": 1, "title": "Updated Post", "body": "Updated Content"}', headers: {})

    # Stub DELETE request to JSONPlaceholder API for post with ID 1
    stub_request(:delete, 'https://jsonplaceholder.typicode.com/posts/1')
      .to_return(status: 204, body: '', headers: {})
  end
end
