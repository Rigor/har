module HAR
  class Entry < SchemaType
    def initialize(input)
      super(input)
    end

    def aborted?
      response.aborted?
    end

  end
end
