require 'test_helper'

class HousingRentalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get housing_rentals_index_url
    assert_response :success
  end

  test "should get new" do
    get housing_rentals_new_url
    assert_response :success
  end

  test "should get create" do
    get housing_rentals_create_url
    assert_response :success
  end

end
