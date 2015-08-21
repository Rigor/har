require File.expand_path("../../spec_helper", __FILE__)

module HAR
  describe Entry do
    let(:entry) { Entry.new json(fixture_path("entry1.json"))}

    it "has a request" do
      entry.request.should be_kind_of(Request)
    end

    it "has a response" do
      entry.response.should be_kind_of(Response)
    end

    describe '#aborted?' do
      let(:aborted_entry) { Entry.new json(fixture_path("aborted_entry.json")) }
      let(:entry) { Entry.new json(fixture_path("entry1.json")) }
      it "is true" do
        expect(aborted_entry.aborted?).to be_truthy
      end

      it "is false" do
        expect(entry.aborted?).to be_falsy
      end

    end

  end # Entry
end # HAR
