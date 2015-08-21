require 'spec_helper'

module HAR
  describe Response do
    let(:response) { Response.new json(fixture_path("aborted_response.json")) }
    let(:normal_response) { Response.new json(fixture_path("normal_response.json")) }

    describe '#aborted?' do
      context 'status is aborted' do
        it "is true" do
          expect(response.aborted?).to be_truthy
        end
      end

      context 'status is normal' do
        it "is false" do
          expect(normal_response.aborted?).to be_falsy
        end
      end
    end
  end
end

