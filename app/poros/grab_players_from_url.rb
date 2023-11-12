class GrabPlayersFromUrl
  attr :url

  def initialize(url)
    @url = url
  end

  def just_grab_em_all(teams=Team.all)
    names = teams.pluck :name
    names.each do |name|
      if name == "Warriors"
        @url = "https://www.warriors.kiwi/teams"
      else
        @url = "https://www.#{name.delete(' ')}.com.au/teams/"
      end
      p go!
    end
    scrapper.driver.quit
  end

  def scrapper
    @scrapper ||= Scrappers::PlayerTeam.new(url)
    @scrapper.set_url(url)
    @scrapper
  end

  def go!
    scrapper.send_request
    p "sent request to #{url}"
    players = scrapper.collate_data
    PlayerParser.new(players).parse
    return "got through"
  end
end
