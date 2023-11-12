module Scrappers
  class Ladder < Base
    def initialize(url="https://www.nrl.com/ladder")
      super
    end

    def collate_data
      @driver.find_elements(:css, "#ladder-table tbody tr")
    end
  end
end