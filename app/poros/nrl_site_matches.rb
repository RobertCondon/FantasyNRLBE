class NrlSiteMatches
  attr :url, :round, :scrapper, :parser

  def initialize(round, season=2023)
    @round = round
    @url = "https://www.nrl.com/draw/?competition=111&round=#{round}&season=#{season}"
  end

  def get_data
    @scrapper = Scrappers::Draw.new(url)
    scrapper.send_request
    data = scrapper.collate_data
    @parser = Parsers::Draw.new(data, round)
    parser.parse
  end
end
