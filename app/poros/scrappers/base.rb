module Scrappers
  class Base
    include Selenium

    attr :url, :driver

    def initialize(url)
      @url = url
      @driver = create_driver
    end

    def set_url(url)
      @url = url
    end

    def send_request
      driver.navigate.to @url
      @document = driver
    end

    def create_driver
      Selenium::WebDriver.for :chrome, options: options, http_client: client
    end

    def client
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.read_timeout = 600
      client
    end

    def options
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument("--headless")
      options.add_argument('--disable-blink-features=AutomationControlled')
      options.add_argument("--window-size=1920,1080")
      options
    end
  end
end