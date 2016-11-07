module ItemDataStorable

  
  REQUIRED_DATA_COLUMNS = %w( code name url ) unless defined? REQUIRED_DATA_COLUMNS

  STRING_OPTION_DATA_COLUMNS = %w( category image ) unless defined? STRING_OPTION_DATA_COLUMNS
  INTEGER_OPTION_DATA_COLUMNS = %w( price stock ) unless defined? INTEGER_OPTION_DATA_COLUMNS
  DATETIME_OPTION_DATA_COLUMNS = %w( release_date ) unless defined? DATETIME_OPTION_DATA_COLUMNS
  OPTION_DATA_COLUMNS = STRING_OPTION_DATA_COLUMNS + INTEGER_OPTION_DATA_COLUMNS + DATETIME_OPTION_DATA_COLUMNS unless defined? OPTION_DATA_COLUMNS

  DATA_COLUMNS = REQUIRED_DATA_COLUMNS + OPTION_DATA_COLUMNS unless defined? DATA_COLUMNS

  @@data_columns = DATA_COLUMNS.to_hash_keys

  def data(name)
    name = name.to_s
    @@data_columns[name] ? self.send(name) : (self.options || {})[name]
  end

  def to_hash
    (self.options || {}).stringify_keys.merge(@@data_columns.keys.inject({}) {|hash, name|
      hash[name] = self.send(name); hash
    })
  end

  def self.string?(column)
    STRING_OPTION_DATA_COLUMNS.include?(column)
  end

  def self.integer?(column)
    INTEGER_OPTION_DATA_COLUMNS.include?(column)
  end

  def self.datetime?(column)
    DATETIME_OPTION_DATA_COLUMNS.include?(column)
  end

end
