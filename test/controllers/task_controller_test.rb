require "test_helper"

class TaskControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get task_index_url
    assert_response :success
  end
end

Rspec.describe 'Api requests' do
  describe "GET /" do
    it 'returns name of the github user' do
      get "/"

      expect(response).to be_ok
      expect(response.body) to include(
        <<-STRING
        Daniel
        STRING
      )
    end
  end
end
