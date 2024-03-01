# frozen_string_literal: true

require 'test_helper'

class WhitelistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @whitelist = whitelists(:one)
  end

  test 'should get index' do
    get whitelists_url
    assert_response :success
  end

  test 'should get new' do
    get new_whitelist_url
    assert_response :success
  end

  test 'should create whitelist' do
    assert_difference('Whitelist.count') do
      post whitelists_url, params: { whitelist: {} }
    end

    assert_redirected_to whitelist_url(Whitelist.last)
  end

  test 'should show whitelist' do
    get whitelist_url(@whitelist)
    assert_response :success
  end

  test 'should get edit' do
    get edit_whitelist_url(@whitelist)
    assert_response :success
  end

  test 'should update whitelist' do
    patch whitelist_url(@whitelist), params: { whitelist: {} }
    assert_redirected_to whitelist_url(@whitelist)
  end

  test 'should destroy whitelist' do
    assert_difference('Whitelist.count', -1) do
      delete whitelist_url(@whitelist)
    end

    assert_redirected_to whitelists_url
  end
end
