module FeedsService
  module_function

  # add caching
  def call(url)
    uri = URI.parse(url)
    uri.scheme == "https" && uri.host && Feedbag.find(url) || []
  rescue URI::InvalidURIError
    []
  end
end
