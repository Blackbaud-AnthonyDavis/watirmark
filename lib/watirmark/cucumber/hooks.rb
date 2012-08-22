Around('@catch-post-failure') do |scenario, block|
  Watirmark::Session.instance.catch_post_failures(&block)
end

# Initialize post failures so we don't get leakage between scenarios
Before('~@catch-post-failure') do
  Watirmark::Session.instance.post_failure = nil
end

if Watirmark::Configuration.instance.webdriver
  FileUtils.rm_rf('reports')
  FileUtils.mkdir('reports')
  Page.browser.screenshot.base64
  After do |scenario|
    image = "reports/screenshot+#{UUID.new.generate(:compact)}.png"
    Page.browser.screenshot.save image
    embed File.expand_path(image), 'image/png'
  end
end