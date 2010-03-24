require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Meme::Info" do

  describe "#user not found" do
    it "should return nil" do
      query = "SELECT * FROM meme.info WHERE name='memeusernotfound'"
      fake_web(query, 'meme_info_not_found.json')
      Meme::Info.find('memeusernotfound').should be_nil
    end
  end

  before :each do
    query = "SELECT * FROM meme.info WHERE name='jtadeulopes'"
    fake_web(query, 'meme_info.json')
    @profile = Meme::Info.find('jtadeulopes')
  end

  it "should return name" do
    @profile.name.should == "jtadeulopes"
  end

  it "should return guid" do
    @profile.guid.should == "EMREXCV4R5OTM3CZW3HBD5QAGY"
  end

  it "should return page title" do
    @profile.title.should == "Jésus Lopes"
  end

  it "should return description" do
    @profile.description.should == "software developer"
  end

  it "should return url" do
    @profile.url.should == "http://meme.yahoo.com/jtadeulopes/"
  end

  it "should return avatar" do
    @profile.avatar_url.should == "http://d.yimg.com/gg/jtadeulopes/avatars/44251e70378d4d225f8cda09a6c3aec87301833a.jpeg"
  end

  it "should return language" do
    @profile.language.should == "pt"
  end

  it "should return followers" do
    @profile.followers.should == "34"
  end

end
