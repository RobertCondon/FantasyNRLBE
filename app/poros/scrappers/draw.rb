module Scrappers
  class Draw < Base
    def collate_data
      @driver.find_elements(:css, "a div .match-header")
    end
  end
end