require 'spec_helper'

describe "Prepare Search methods" do

  describe "PrepareSearch#start_date" do

    subject { PrepareSearch.start_date('2000') }
    it { should == DateTime.new(2000,1,1) }

  end

  describe "PrepareSearch#end_date" do

    subject { PrepareSearch.end_date('2009') }
    it { should == DateTime.new(2009,12,31) }

  end

  describe "PrepareSearch#groups" do

    subject { PrepareSearch.groups(['1','2','3']) }
    it { should == " and group_id in (-1,1,2,3)" }

  end

  describe "PrepareSearch#versions" do

    before(:each) do 
      @versions= {:version => 0, :version_comparison => '>=', :include_blank_version => true}
    end
    subject { PrepareSearch.versions(@versions) } 
    it { should == " and (version_number >= 0.0 or version_number is NULL or version_number = '' )" }

  end

  describe "PrepareSearch#dates" do

    subject { PrepareSearch.dates(Date.new(2009), Date.new(2012) ) }
    it { should == " and ((content_date is NULL) or( (content_date >= \"2009-01-01\") and (content_date <= \"2012-01-01\") ) )" }

  end

  describe "PrepareSearch#basic_search" do

    subject { PrepareSearch.basic_search("test") }
    it { should == ["(url_address LIKE ? or alt_text LIKE ? or version_number LIKE ?)","%test%","%test%","%test%"] }

  end

  describe "PrepareSearch#text_search" do

    subject { PrepareSearch.text_search("tests","or","rs") }
    it { should == " and ( (url_address LIKE \"%tests%\" or alt_text LIKE \"%tests%\" or version_number LIKE \"%tests%\") or (url_address LIKE \"%rs%\" or alt_text LIKE \"%rs%\" or version_number LIKE \"%rs%\") )" }

  end

end
