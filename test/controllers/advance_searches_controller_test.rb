require 'test_helper'

class AdvanceSearchesControllerTest < ActionController::TestCase
  setup do
    @advance_search = advance_searches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:advance_searches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create advance_search" do
    assert_difference('AdvanceSearch.count') do
      post :create, advance_search: { end_date: @advance_search.end_date, keyword: @advance_search.keyword, maximum_price: @advance_search.maximum_price, minimum_price: @advance_search.minimum_price, start_date: @advance_search.start_date }
    end

    assert_redirected_to advance_search_path(assigns(:advance_search))
  end

  test "should show advance_search" do
    get :show, id: @advance_search
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @advance_search
    assert_response :success
  end

  test "should update advance_search" do
    patch :update, id: @advance_search, advance_search: { end_date: @advance_search.end_date, keyword: @advance_search.keyword, maximum_price: @advance_search.maximum_price, minimum_price: @advance_search.minimum_price, start_date: @advance_search.start_date }
    assert_redirected_to advance_search_path(assigns(:advance_search))
  end

  test "should destroy advance_search" do
    assert_difference('AdvanceSearch.count', -1) do
      delete :destroy, id: @advance_search
    end

    assert_redirected_to advance_searches_path
  end
end
