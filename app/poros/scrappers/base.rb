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
      options = Selenium::WebDriver::Chrome::Options.new
      # options.add_argument("--headless")
      options.add_argument('--disable-blink-features=AutomationControlled')
      options.add_argument("--window-size=1920,1080")
      Selenium::WebDriver.for :chrome, options: options
    end
  end
end