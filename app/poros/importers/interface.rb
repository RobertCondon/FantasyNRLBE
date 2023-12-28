module Importers
  class Interface
    def self.import(data:, processor:)
      new(data: data, processor: processor).import
    end

    def import
      data.each do |record|
        set_attrs_on_processor_from record
        next if skip?
        process
      end
    end

    private
    attr :data, :processor

    def initialize(data:, processor:)
      @data = data
      @processor = processor
    end

    def set_attrs_on_processor_from(record)
      processor.set_attrs(attrs: record)
    end

    def process
      processor.create
    end

    def skip?
      processor.skip?
    end
  end
end
