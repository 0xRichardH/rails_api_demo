require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create name: "Richard", email: "test@email.com", password: "password"
    @auth_tokens = @user.create_new_auth_token
    @post = posts(:one)
    @post.update(author: @user)
  end

  context "GET #index" do
    setup do
      get posts_path, headers: @auth_tokens
    end

    should "response successfully" do
      body = JSON.parse response.body
      posts = JSON.parse(body["posts"])

      assert_response :success
      assert_equal ["pagination", "posts"], body.keys
      assert_includes posts.first.keys, "title"
      assert_includes posts.last.keys, "body"
      assert_includes posts.last.keys, "author"
    end
  end

  context "GET #show" do
    setup do
      get post_path(id: @post.id), headers: @auth_tokens
    end

    should "response successfully" do
      assert_response :success
    end
  end

  context "POST #create" do
    should "created successfully" do
      assert_difference "Post.count", 1 do
        post posts_path, params: { post: { title: "test", body: "test" } }, headers: @auth_tokens
      end

      body = JSON.parse response.body
      post = JSON.parse(body["post"])

      assert_response :success
      assert_equal ["success", "post"], body.keys
      assert_equal true, body["success"]
      assert_equal "test", post["title"]
    end

    should "created failed" do
      assert_no_difference "Post.count" do
        post posts_path, params: { post: { title: "test", body: nil } }, headers: @auth_tokens
      end

      body = JSON.parse(response.body)

      assert_response :unprocessable_entity
      assert_equal ["success", "errors"], body.keys
      assert_equal false, body["success"]
      assert_equal ["Body can't be blank"], body["errors"]
    end
  end

  context "PUT #update" do
    should "update successfully" do
      assert_no_difference "Post.count" do
        put post_path(id: posts(:one)), params: { post: { title: "abc", body: "abcdef" } }, headers: @auth_tokens
      end

      body = JSON.parse response.body
      post = JSON.parse(body["post"])

      assert_response :success
      assert_equal ["success", "post"], body.keys
      assert_equal true, body["success"]
      assert_equal "abc", post["title"]
    end

    should "update failed" do
      assert_no_difference "Post.count" do
        put post_path(id: @post.id), params: { post: { title: "abc", body: nil } }, headers: @auth_tokens
      end

      body = JSON.parse response.body

      assert_response :unprocessable_entity
      assert_equal ["success", "errors"], body.keys
      assert_equal false, body["success"]
      assert_equal ["Body can't be blank"], body["errors"]
    end
  end

  context "DELETE #destroy" do
    should "destroyed successfully" do
      assert_difference "Post.count", -1 do
        delete post_path(id: @post.id), headers: @auth_tokens
      end

      assert_response :success
      assert_equal({ success: true }.to_json, response.body)
    end
  end
end
