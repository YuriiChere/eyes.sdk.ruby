# frozen_string_literal: true

require_relative '../lib/eyes_selenium'
require 'logger'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

eyes = Applitools::Selenium::Eyes.new(runner: Applitools::ClassicRunner.new)
# eyes.api_key = ENV['APPLITOOLS_API_KEY']
eyes.log_handler = Logger.new(STDOUT)
eyes.match_level = Applitools::MATCH_LEVEL[:layout]
eyes.stitch_mode = Applitools::Selenium::StitchModes::CSS
# eyes.set_proxy('http://localhost:8000')
# eyes.server_url = 'https://eyesfabric4eyes.applitools.com'

begin
  web_driver = Selenium::WebDriver.for :chrome

  drv = eyes.open(
      app_name: 'Ruby SDK css stitching',
      test_name: 'Applitools example',
      viewport_size: { width: 800, height: 600 },
      driver: web_driver
  )

  drv.get('https://applitools.github.io/demo/TestPages/FramesTestPage/')

  drv.find_element(:id, 'stretched').click
  # eyes.check('Example1', Applitools::Selenium::Target.frame(drv.find_element(:css, 'iframe.modal-content')).fully.send_dom(false).use_dom(false))
  eyes.check('Example1', Applitools::Selenium::Target.frame('frame1').frame('frame1-1').fully.send_dom(false).use_dom(false))
  # eyes.check('Example1', Applitools::Selenium::Target.frame(1).fully.send_dom.use_dom)
  # drv.find_element(:css, '.section.button-section button').click
  # eyes.check('Example2', Applitools::Selenium::Target.window.fully.send_dom.use_dom)
  eyes.close

    # eyes.test(
    #   app_name: 'Ruby SDK',
    #   test_name: 'Applitools website test',
    #   viewport_size: { width: 800, height: 600 },
    #   driver: web_driver
    # ) do |driver|
    #   driver.get 'http://www.applitools.com'
    #   eyes.check_window('initial')
    #   eyes.check_region(:css, 'a.logo', tag: 'Applitools logo')
    # end
ensure
  web_driver.quit
end
