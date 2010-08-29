# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Meme::User" do
  before :each do
    query = "SELECT * FROM meme.info WHERE name='greboide'"
    fake_web(query, 'meme_users.json')
    query = "SELECT * FROM meme.followers(10) WHERE owner_guid='PA46EGLSM3EKVFXS7RVRFPYJ7U'"
    fake_web(query, 'meme_users_followers.json')
    query = "SELECT * FROM meme.following(10) WHERE owner_guid='PA46EGLSM3EKVFXS7RVRFPYJ7U'"
    fake_web(query, 'meme_users_following.json')
    query = "SELECT * FROM meme.posts WHERE owner_guid='PA46EGLSM3EKVFXS7RVRFPYJ7U'"
    fake_web(query, 'meme_users_posts.json')
    @user = Meme::User.new('greboide')
  end

  describe "::initialize"
    it "should return the correct number of posts" do
    @user.posts.size.should == 4
  end

end
