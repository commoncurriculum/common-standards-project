class Array
  def find(*args)
    if args.length == 1
      args.push({})
    end
    ret = self.clone
    args.each do |arg|
      arg.each_pair do |key, value|   

        ret.select! do |hash|
          if hash[key].is_a?(Array)
            hash[key].include?(value)
          elsif value.is_a?(Regexp)
          	hash[key][value]
          else
            hash[key] == value
          end
        end
      end
    end
    return ret
  end
end
