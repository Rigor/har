require File.expand_path("../../spec_helper", __FILE__)

module HAR
  describe Page do

    context "data" do
      let(:page) { Archive.from_file(google_path).pages.first }

      it "has entries" do
        page.entries.size.should == 5
        page.entries.each { |e| e.pageref.should == page.id }
      end

      it "has a title" do
        page.title.should == 'Google'
      end

      it "has a PageTimings instance" do
        page.timings.should be_kind_of(PageTimings)
      end
    end

    describe '#aborted?' do
      context 'content load and onload times are -1' do
        let(:page) { Archive.from_file(har_path("aborted")).pages.first }
        let(:not_aborted) { Archive.from_file(har_path("google_nonzero")).pages.first }
        context "has request body" do
          it "is false" do
            expect(not_aborted.aborted?).to be_falsy
          end
        end
        context "does not have request body" do
          it "is true" do
            expect(page.aborted?).to be_truthy
          end
        end

      end

      context "content load and onload times are not -1" do
        let(:page) { Archive.from_file(google_path).pages.first }
        it "is true" do
          expect(page.aborted?).to be_falsy
        end
      end
    end

  end # Page
end # HAR
