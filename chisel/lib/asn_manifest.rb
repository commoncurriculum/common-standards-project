class ASNManifest
  include ASNCleaner
  include ASNFlattener
  

  def initialize(file)
    @file = File.open(file, 'r+').read
  end

  def file
    @file
  end

  def doc=(doc)
    @doc = doc
  end

  def doc
    @doc ||=  MultiJson.decode(file)
  end

  def clean
    remove_asn_prefix
    remove_asn_urls
    capitalize_subjects
  end

end
