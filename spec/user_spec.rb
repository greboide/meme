# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Meme::User" do
  before :each do
#    query = "SELECT * FROM meme.info WHERE name='greboide'"
#    fake_web(query, 'meme_user.json')
    @user = Meme::User.new('greboide')
  end

  describe "::initialize"
    it "should return the correct number of posts" do
    @user.posts.size.should == 4
  end

end
