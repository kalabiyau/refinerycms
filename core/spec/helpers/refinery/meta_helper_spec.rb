#encoding: utf-8
require "spec_helper"

module Refinery
  describe MetaHelper do

    before(:each) do
      @meta = "Stubbed to avoid warnings"
      @meta.stub(:browser_title => "Лапсердак")
    end

    describe "#browser_title" do

      it "returns a browser title contains localized site name" do
        %w(:ru :cz :piggy).each do |loc|
          ::I18n.stub(:t).with("refinery.core.config.site_name").and_return "#{loc.to_s} Site Name"
          helper.browser_title.should eq "Лапсердак - #{loc.to_s} Site Name"
        end
      end

      context "when choosen locale has not key in locale.yml" do
        it "returns default sitename" do
          ::I18n.locale = :fr
          helper.browser_title.should eq "Лапсердак - Company Name"
        end
      end

    end

  end

end
