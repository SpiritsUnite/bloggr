require 'rails_helper'

RSpec.describe Post, :type => :model do
  
  let(:user) { FactoryGirl.create(:user) }

  before do
    @post = Post.new(title: "title", body: "body", author: user, published: false)
  end

  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:author) }
  it { should respond_to(:published) }

  it { should be_valid }

end
