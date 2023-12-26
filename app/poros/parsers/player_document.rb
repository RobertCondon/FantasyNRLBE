module Parsers
  class PlayerDocument
    attr :driver, :rounds
    def initialize(driver)
      @driver = driver
      @rounds = []
    end

    def set_player
      name = @driver.find_element(:css, ".pp-player_name").text.strip
      @player = ::Player.find_by(name: name)
    end

    def datarize(round)
      {
        player: @player
      }.merge!(round)
    end

    def parse_rounds
      round_rows = @driver.find_elements(:css, "table tbody tr")
      round_rows.each do |round_row|
        round_object = {}
        round_columns = round_row.find_elements(:css, "td")
        next if does_column_have_player?(round_columns)
        round_object["year"] = round_columns[1].text.strip
        round_object["round"] = round_columns[2].text.strip
        round_object["position"] = round_columns[7].text.strip
        round_object["mins_played"] = round_columns[8].text.strip
        round_object["tries"] = round_columns[9].text.strip
        round_object["try_saves"] = round_columns[10].text.strip
        round_object["goals"] = round_columns[11].text.strip
        round_object["field_goals"] = round_columns[12].text.strip
        round_object["try_assists"] = round_columns[13].text.strip
        round_object["line_break"] = round_columns[14].text.strip
        round_object["line_break_assists"] = round_columns[15].text.strip
        round_object["tackles"] = round_columns[16].text.strip
        round_object["tackle_breaks"] = round_columns[17].text.strip
        round_object["missed_tackles"] = round_columns[18].text.strip
        round_object["off_loads"] = round_columns[19].text.strip
        round_object["ground_off_loads"] = round_columns[20].text.strip
        round_object["hand_offloads"] = round_columns[21].text.strip
        round_object["errors"] = round_columns[22].text.strip
        round_object["forty_twentys"] = round_columns[23].text.strip
        round_object["turn_overs"] = round_columns[24].text.strip
        round_object["meters_gained"] = round_columns[25].text.strip
        round_object["kick_meters"] = round_columns[26].text.strip
        round_object["kicks_defused"] = round_columns[27].text.strip
        round_object["penalties_conceded"] = round_columns[28].text.strip
        round_object["sin_bins"] = round_columns[29].text.strip
        round_object["send_offs"] = round_columns[30].text.strip
        round_object["forced_drop_outs"] = round_columns[31].text.strip
        round_object["six_again_infringments"] = round_columns[32]&.text&.strip
        round_object["escapes_from_in_goal"] = round_columns[33]&.text&.strip
        # p "Round: #{round}, played position #{position} for #{mins_played} mins. And tackled this many times #{tackles}, #{tackle_breaks}, #{missed_tackles}, #{line_break_assists}"
        @rounds.push(round_object)
      end
      nil
    end

    def does_column_have_player?(round_columns)
      round_columns[1].find_element(tag_name: 'span').text == ""
    end
  end
end