require_relative 'asn_cleaner'
require_relative 'asn_flattener'
require_relative 'asn_munger'

class ASNManifest
  include ASNCleaner
  include ASNFlattener
  include ASNMunger

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


  
end
