require 'rails_helper'

RSpec.describe "StaticPages", :type => :request do

  subject { page }

  describe "home page" do
  	before { visit root_path }

  	it { should have_content("Bloggr") }

  end
end
