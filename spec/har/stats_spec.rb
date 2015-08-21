require File.expand_path("../../spec_helper", __FILE__)

module HAR
  describe Stats do
    let(:ar) { Archive.from_file(har_path("browser-blocking-time")) }
    let (:stats) { ar.stats }

    context 'metadata' do
      it 'has a creator' do
        stats.creator.should be_a(String)
      end

      it 'has a browser' do
        stats.browser.should be_a(String)
      end

      it 'has a source url' do
        stats.source_url.should be_a(String)
      end

      it 'has a domain' do
        stats.domain.should be_a(String)
      end

      it 'has a start time' do
        stats.started_date_time.should be_a(Time)
      end
    end

    context 'metrics' do
      it 'has page metrics' do
        [:server_time, :dom_load_time, :page_load_time, :page_size].each do |metric|
          stats.send(metric).should be_an(Integer)
        end
      end

      it 'has error metrics' do
        [:errors, :client_errors, :server_errors, :connection_errors].each do |metric|
          stats.send(metric).should be_an(Array)
          stats.send("#{metric}_count").should be_an(Integer)
        end
      end

      it 'has file type metrics' do
        [:image_files, :html_files, :css_files, :javascript_files, :flash_files, :other_files].each do |metric|
          stats.send(metric).should be_an(Array)
          stats.send("#{metric}_count").should be_an(Integer)
        end
      end

      it 'has timing metrics' do
        [:dns_time, :connect_time, :blocked_time, :wait_time, :receive_time, :send_time].each do |metric|
          stats.send(metric).should be_an(Integer)
        end
      end
    end

    describe '#page_load_time' do
      context 'single page' do
        let(:ar)     { Archive.from_file(har_path("google.com")) }
        let(:stats) { ar.stats }

        it 'is the onload of the only page' do
          stats.page_load_time.should == 245
        end
      end

      context 'multiple pages' do
        it 'sums the onload of all pages' do
          stats.page_load_time.should == 14767
        end
      end
    end

    describe '#dom_load_time' do
      context 'single page' do
        let(:ar)     { Archive.from_file(har_path("google.com")) }
        let(:stats) { ar.stats }

        it 'is the onContentLoad of the only page' do
          stats.dom_load_time.should == 90
        end
      end

      context 'multiple pages' do
        it 'sums the onContentLoad of all pages' do
          stats.dom_load_time.should == 1061
        end
      end
    end

    context 'non-zero load times' do
      let(:nonzero_stats) { Archive.from_file(har_path("google_nonzero")).stats }

      it 'returns non-zero page load time' do
        nonzero_stats.page_load_time.should == -1
      end

      it 'provides entry-based page load time' do
        nonzero_stats.safe_page_load_time.should eql(297)
      end

      it 'returns non-zero dom load time' do
        nonzero_stats.dom_load_time.should == -1
      end

      it 'provides safe dom load time' do
        nonzero_stats.safe_dom_load_time.should == 0
      end
    end
  end
end
