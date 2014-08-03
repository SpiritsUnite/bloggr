require 'rails_helper'

RSpec.describe "StaticPages", :type => :request do

  subject { page }

  describe "home page" do
  	before { visit root_path }

  	it { should have_content("Bloggr") }
    it { should have_title("Bloggr") }
    it { should_not have_title("| Bloggr") }

    it { should have_selector("nav li.active", text: "Home") }
    it { should have_selector("nav li.active", count: 1) }
  end
end
