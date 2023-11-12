module Scrappers
  class PlayerTeam < Base
    def collate_data
      @driver.find_elements(:css, ".card-themed-hero__content dl")
    end
  end
end