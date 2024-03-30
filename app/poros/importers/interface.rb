module Importers
  class Interface
    def self.import(data:, processor:)
      new(data: data, processor: processor).import
    end

    def import
      return p "No data to import" if data.nil?
      data.each do |record|
        set_attrs_on_processor_from record
        next if skip?
        process
      end
      p "Total Skipped: #{@total_skipped}"
      p "Total Processed: #{@total_processed}"
    end

    private
    attr :data, :processor

    def initialize(data:, processor:)
      @data = data
      @processor = processor
      @total_skipped = 0
      @total_processed = 0
    end

    def set_attrs_on_processor_from(record)
      processor.set_attrs(attrs: record)
    end

    def process
      @total_processed += 1
      processor.create
    end

    def skip?
      @total_skipped += 1 if processor.skip?
      processor.skip?
    end
  end
end
