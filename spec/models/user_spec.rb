require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

  before(:each) do
     @user = User.new()
     @user.first_name = "Erica"
     @user.last_name = "Little"
     @user.email = "erica@gmail.com"
     @user.password = "hello"
     @user.password_confirmation = "hello"
  end

  it "user password must be presented" do
    @user.password = nil
    @user.save
    expect(@user.errors.full_messages).to include("Password can't be blank")
  end

  it "user password and password_confirmation must match" do
    @user.password = "hi"
    @user.password == @user.password_confirmation
    @user.save
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end

  it "user password_confirmation must be presented" do
    @user.password_confirmation = nil
    @user.save
    expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
  end


  it "user email must be presented" do
    @user.email = nil
    @user.save
    expect(@user.errors.full_messages).to include("Email can't be blank")
  end

  it "user email must be unique" do
    @user.save
    @newUser = User.create({ first_name: "Joe",
      last_name: "Joeseph",
      email: "ERICA@gmail.com",
      password: "erica",
      password_confirmation: "erica"
     })
    expect(@newUser.errors.full_messages).to include("Email has already been taken")
  end

  it "user password must be minimum 5 character length" do
    @user.password = "hi"
    @user.password_confirmation = "hi"
    @user.save
    expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
  end

  end


  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new()
      @user.first_name = "Erica"
      @user.last_name = "Little"
      @user.email = "erica@gmail.com"
      @user.password = "hello"
      @user.password_confirmation = "hello"
      @user.save
    end

  it "allow user to login with valid email" do
    user = User.authenticate_with_credentials("erica@gmail.com", "hello")
    expect(user).to be_instance_of(User)
  end

  it "allow user to login with whitespace" do
    user = User.authenticate_with_credentials("  erica@gmail.com  ", "hello")
    expect(user).to be_instance_of(User)
  end

  it "not case sensititve" do
    user = User.authenticate_with_credentials("EricA@gmail.com", "hello")
    expect(user).to be_instance_of(User)
  end


 end

end
