require 'test_helper'

class ContentControllerTest < ActionController::TestCase

  def test_custom_page_route
    assert_recognizes({ :controller => 'content', :action => 'render_page', :language => 'de', :pagepath => ['foo', 'bar'] }, '/de/foo/bar')
    assert_recognizes({ :controller => 'content', :action => 'render_page', :language => 'en', :pagepath => ['home'] }, '/en/home')
  end
  
  def test_render_404_when_no_page_was_found
    get :render_page, :language => 'de', :page_path => ["wrong_path"]
    assert_response 404
  end
  
  def test_rendering_a_page
    assert Node.valid?
    assert_not_nil Node.find_by_slug("my_first_page")
    get :render_page, :language => 'de', :page_path => ["root", "my_first_page"]
    assert_response :success
    assert_equal "layouts/application", @response.layout
  end
end