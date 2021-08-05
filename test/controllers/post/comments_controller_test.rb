require "test_helper"

class Post::CommentsControllerTest < ActionDispatch::IntegrationTest
  context "GET #index" do
    setup do
      get post_comments_path(posts(:one))
    end

    should "response successfully" do
      body = JSON.parse response.body
      posts = JSON.parse(body["comments"])

      assert_response :success
      assert_equal ["pagination", "comments"], body.keys
      assert_includes posts.first.keys, "body"
      assert_includes posts.last.keys, "user"
    end
  end

  context "POST #create" do
    should "created successfully" do
      assert_difference "Comment.count", 1 do
        post post_comments_path(posts(:one)), params: { comment: { body: "test" * 10, user_id: users(:two).id } }
      end

      body = JSON.parse response.body
      comment = JSON.parse(body["comment"])

      assert_response :success
      assert_equal ["success", "comment"], body.keys
      assert_equal true, body["success"]
      assert_equal "test" * 10, comment["body"]
    end

    should "created failed" do
      assert_no_difference "Comment.count" do
        post post_comments_path(posts(:one)), params: { comment: { body: "test", user_id: users(:two).id } }
      end

      body = JSON.parse(response.body)

      assert_response :unprocessable_entity
      assert_equal ["success", "errors"], body.keys
      assert_equal false, body["success"]
      assert_equal ["Body is too short (minimum is 10 characters)"], body["errors"]
    end
  end

  context "DELETE #destroy" do
    should "destroyed successfully" do
      assert_difference "Comment.count", -1 do
        delete post_comment_path(post_id: posts(:one), id: comments(:one))
      end

      assert_response :success
      assert_equal({ success: true }.to_json, response.body)
    end
  end

end
