module Scrappers
  class Match < Base
    def navigate_to_players
      @driver.find_elements(:css, ".tabs-trigger")[4].click
    end

    def navigate_to_team_b
      @driver.find_elements(:css, ".toggle-group button")[1].click
    end

    def team_a_table
      @driver.find_elements(:css, "table tbody")[0]
    end

    def team_b_table
      @driver.find_elements(:css, "table tbody")[2]
    end
  end
end