require "rubygems"
require "bundler/setup"
require 'multi_json'
require 'oj'
require 'bundler'
require 'ostruct'
require 'csv'
require 'json'

# Make hashes easier to call
class Hash
  def method_missing(method, *opts)
    m = method.to_s
    if self.has_key?(m)
      return self[m]
    elsif self.has_key?(m.to_sym)
      return self[m.to_sym]
    end
    super
  end
end


f = File.open('exports/cc-guids.json', "r").read
import = MultiJson.load(f)

import.each_with_index do |el, i|
  dn = el.dot_notation.clone
  dn.gsub!(/Literacy\./, "")
  dn.gsub!(/Math\.HS/, "")
  dn.gsub!(/Math\./, "")
  import[i]["current_url"].gsub!(/wwwcorestandards\.org/, "www.corestandards.org") unless el.current_url.nil?
  import[i]["simplified_dot_notation"] = dn
  #dn.gsub!(/Math\./, "")
  #dn.gsub!(/\.1a/, ".1.a")
  #dn.gsub!(/\.2a/, ".2.a")
  #dn.gsub!(/\.3a/, ".3.a")
  #dn.gsub!(/\.4a/, ".4.a")
  #dn.gsub!(/\.5a/, ".5.a")
  #dn.gsub!(/\.6a/, ".6.a")
  #dn.gsub!(/\.7a/, ".7.a")
  #dn.gsub!(/\.8a/, ".8.a")
  #dn.gsub!(/\.9a/, ".8.a")
  #dn.gsub!(/\.10a/, ".10.a")
  #dn.gsub!(/\.11a/, ".11.a")
  #dn.gsub!(/\.12a/, ".12.a")
  #dn.gsub!(/\.13a/, ".13.a")
  #dn.gsub!(/\.14a/, ".14.a")
  #dn.gsub!(/\.15a/, ".15.a")
  
end


File.open('exports/cc-guids-munged.json', "w+").write(MultiJson.encode(import, :pretty => true))

