module Processors
  module Json
    class PlayerRound
      attr :team, :match, :json_blob, :attrs_block, :player, :player_attrs
      def initialize(team:, match:)
        @team = team
        @match = match
        @attrs_block = {}
        @player_attrs = {}
      end

      def create
        ::PlayerRound.create!({ player: player, team_id: team.id, match_id: match.id }.merge(attrs_block))
        player.update(image_url: player_attrs["image_url"]) unless player_attrs["image_url"].blank?
      end

      def skip?
        return true if player.blank?

        ::PlayerRound.find_by(player: player, match: match)&.destroy

        false
      end

      def set_attrs(attrs:)
        find_player(attrs["playerId"])
        player_attrs["image_url"] = parsed_image_url(attrs["headImage"])

        attrs_block["all_run_meters"] = attrs["allRunMetres"]
        attrs_block["price"] = player&.cost
        attrs_block["position"] = attrs["position"]
        attrs_block["all_runs"] = attrs["allRuns"]
        attrs_block["bomb_kicks"] = attrs["bombKicks"]
        attrs_block["cross_field_kicks"] = attrs["crossFieldKicks"]
        attrs_block["conversions"] = attrs["conversions"]
        attrs_block["conversion_attempts"] = attrs["conversionAttempts"]
        attrs_block["dummy_half_runs"] = attrs["dummyHalfRuns"]
        attrs_block["dummy_half_run_meters"] = attrs["dummyHalfRunMetres"]
        attrs_block["dummy_passes"] = attrs["dummyPasses"]
        attrs_block["handling_errors"] = attrs["handlingErrors"]
        attrs_block["fantasy_points_total"] = attrs["fantasyPointsTotal"]
        attrs_block["field_goals"] = attrs["fieldGoals"]
        attrs_block["forced_drop_out_kicks"] = attrs["forcedDropOutKicks"]
        attrs_block["forty_twenties"] = attrs["fortyTwentyKicks"]
        attrs_block["goals"] = attrs["goals"]
        attrs_block["goal_conversion_rate"] = attrs["goalConversionRate"]
        attrs_block["grubber_kicks"] = attrs["grubberKicks"]
        attrs_block["hit_ups"] = attrs["hitUps"]
        attrs_block["hit_up_run_meters"] = attrs["hitUpRunMetres"]
        attrs_block["ineffective_tackles"] = attrs["ineffectiveTackles"]
        attrs_block["intercepts"] = attrs["intercepts"]
        attrs_block["kicks"] = attrs["kicks"]
        attrs_block["kicks_dead"] = attrs["kicksDead"]
        attrs_block["kicks_defused"] = attrs["kicksDefused"]
        attrs_block["kick_meters"] = attrs["kickMetres"]
        attrs_block["kick_return_meters"] = attrs["kickReturnMetres"]
        attrs_block["line_break_assists"] = attrs["lineBreakAssists"]
        attrs_block["line_breaks"] = attrs["lineBreaks"]
        attrs_block["line_engaged_runs"] = attrs["lineEngagedRuns"]
        attrs_block["minutes_played"] = attrs["minutesPlayed"]
        attrs_block["missed_tackles"] = attrs["missedTackles"]
        attrs_block["offloads"] = attrs["offloads"]
        attrs_block["offside_within_ten_meters"] = attrs["offsideWithinTenMetres"]
        attrs_block["one_on_one_lost"] = attrs["oneOnOneLost"]
        attrs_block["one_on_one_steal"] = attrs["oneOnOneSteal"]
        attrs_block["one_point_field_goals"] = attrs["onePointFieldGoals"]
        attrs_block["on_report"] = attrs["onReport"]
        attrs_block["passes_to_run_ratio"] = attrs["passesToRunRatio"]
        attrs_block["passes"] = attrs["passes"]
        attrs_block["play_the_ball"] = attrs["playTheBallTotal"]
        attrs_block["play_the_ball_average_speed"] = attrs["playTheBallAverageSpeed"]
        attrs_block["penalties"] = attrs["penalties"]
        attrs_block["points"] = attrs["points"]
        attrs_block["penalty_goals"] = attrs["penaltyGoals"]
        attrs_block["post_contact_meters"] = attrs["postContactMetres"]
        attrs_block["receipts"] = attrs["receipts"]
        attrs_block["ruck_infringements"] = attrs["ruckInfringements"]
        attrs_block["send_offs"] = attrs["sendOffs"]
        attrs_block["sin_bins"] = attrs["sinBins"]
        attrs_block["stint_one"] = attrs["stintOne"]
        attrs_block["tackle_breaks"] = attrs["tackleBreaks"]
        attrs_block["tackle_efficiency"] = attrs["tackleEfficiency"]
        attrs_block["tackles_made"] = attrs["tacklesMade"]
        attrs_block["tries"] = attrs["tries"]
        attrs_block["try_assists"] = attrs["tryAssists"]
        attrs_block["twenty_forties"] = attrs["twentyFortyKicks"]
        attrs_block["two_point_field_goals"] = attrs["twoPointFieldGoals"]
      end

      def parsed_image_url(image_url)
        return "https#{split_image_url(image_url, "https")}" unless split_image_url(image_url, "https").blank?
        return "http#{split_image_url(image_url, "http")}" unless split_image_url(image_url, "http").blank?
        image_url
      end

      def split_image_url(image_url, split_string)
        image_url.split(split_string)&.second
      end

      def find_player(nrl_id)
        @player = ::Player.find_by(nrl_id: nrl_id)
      end
    end
  end
end
