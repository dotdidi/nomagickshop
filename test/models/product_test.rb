require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  def setup
    @product = Product.new(title: "Yahoo", desc: "Yahoo Inc. is an American multinational technology company headquartered in Sunnyvale, California. Yahoo was founded by Jerry Yang and David Filo in January 1994 and was incorporated on March 2, 1995.", 
                           img_url: "https://s.yimg.com/dh/ap/default/130909/y_200_a.png", price: "38.92")
  end

  test "Product should be valid" do
    assert @product.valid?, "Saved Product is not valid"
  end

  test "Title should be present" do
    @product.title = "    "
    assert_not @product.valid?, "Saved Title is blank"
  end

  test "Title can not be too long" do
    @product.title = "a" *76
    assert_not @product.valid?, "Saved Title is too long"
  end

  test "Description should be present" do
    @product.desc = "     "
    assert_not @product.valid?, "Saved Description is null"
  end

  test "Description should be not too short" do
    @product.desc = "a" *4
    assert_not @product.valid?, "Saved Description is short"
  end

  test "Image Url validation" do
    valid_urls = %w[https://media.giphy.com/media/9fbYYzdf6BbQA/giphy.gif 
                    http://orig14.deviantart.net/6855/f/2009/148/7/d/lily_allen_dresses_png_objects_by_camiluchiiz.png 
                    http://www.brisbanemarkets.com.au/wp-content/uploads/2013/12/Pineapple-Fruit-200x200.jpg]
    valid_urls.each do |valid_url|
      @product.img_url = valid_url
      assert @product.valid?, "#{valid_url.inspect} should not be valid"
    end
  end

  test "Image Url reject validation" do
    valid_urls = %w[htps://media.giphy.com/media/9fbYYzdf6BbQA/giphy.gif 
                    http://www.movietickets.com/movie/mid/206405/n/Rogue-One-A-Star-Wars-Story
                    http://barkerhost.com/wp-content/uploads/sites/4/2014/08/movie-ticket.bmp
                    ftp://orig14.deviantart.net/6855/f/2009/148/7/d/lily_allen_dresses_png_objects_by_camiluchiiz.png 
                    http:/www.brisbanemarkets.com.au/wp-content/uploads/2013/12/Pineapple-Fruit-200x200.jpg]
    valid_urls.each do |valid_url|
      @product.img_url = valid_url
      assert_not @product.valid?, "#{valid_url.inspect} should not be valid"
    end
  end
end
