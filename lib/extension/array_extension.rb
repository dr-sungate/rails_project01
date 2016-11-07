class Array
  def to_hash_keys(default_value = true)
    self.inject({}) {|hash, key|
      hash[key] = default_value
      hash
    }
  end
end
