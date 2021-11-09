require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @result ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    @result.first.map(&:to_sym) # only the column names
  end

  def self.finalize!
    columns.each do |attribute|
      # create getter and setter for each column using @attributes
      define_method(attribute) do # getter -- gets column name
        @attributes[attribute]
      end
      define_method(attribute) do # setter -- sets column values to an array of values
          @attributes[attribute] = []
        attribute.each do |value|
          @attributes[attribute] << value
        end
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    if !@table_name.nil?
      @table_name
    else
      self.to_s.tableize
    end
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    @attributes.values
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
