module HAR
  class Response < SchemaType

    attr_reader :entries

    def initialize(input)
      super(input)
    end

    def is_error?
      status >= 400
    end

    def is_client_error?
      is_error? && status < 500
    end

    def is_server_error?
      status >= 500 && status != 504
    end

    def is_connection_error?
      status == 504 || status == 0
    end

    def is_redirect?
      status == 301 || status == 302
    end

    def is_content_type? type
      !!content.mime_type.include?(type) unless content.mime_type.nil?
    end

    def is_html?
      is_content_type? 'html'
    end

    def is_image?
      is_content_type? 'image'
    end

    def is_javascript?
      is_content_type? 'javascript'
    end

    def is_css?
      is_content_type? 'css'
    end

    def is_flash?
      is_content_type? 'flash'
    end

    def is_font?
      is_content_type? 'font'
    end

    def is_video?
      is_content_type? 'video'
    end

    def is_other?
      @is_other ||= content_types.none? do |content_type|
        is_content_type?(content_type)
      end
    end

    private

    def content_types
      @content_types ||= %w(html image javascript css flash font video)
    end

  end
end
