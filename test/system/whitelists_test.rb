# frozen_string_literal: true

require 'application_system_test_case'

class WhitelistsTest < ApplicationSystemTestCase
  setup do
    @whitelist = whitelists(:one)
  end

  test 'visiting the index' do
    visit whitelists_url
    assert_selector 'h1', text: 'Whitelists'
  end

  test 'should create whitelist' do
    visit whitelists_url
    click_on 'New whitelist'

    click_on 'Create Whitelist'

    assert_text 'Whitelist was successfully created'
    click_on 'Back'
  end

  test 'should update Whitelist' do
    visit whitelist_url(@whitelist)
    click_on 'Edit this whitelist', match: :first

    click_on 'Update Whitelist'

    assert_text 'Whitelist was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Whitelist' do
    visit whitelist_url(@whitelist)
    click_on 'Destroy this whitelist', match: :first

    assert_text 'Whitelist was successfully destroyed'
  end
end
