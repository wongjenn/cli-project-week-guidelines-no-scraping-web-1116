class Collisions
  attr_accessor :date, :contributing_factor1, :contributing_factor2, :no_persons_injured, :no_persons_killed, :unique_key, :attributes

  ALL = []
  ALL_BY_DATE = []

  def self.all
    ALL
  end

  def self.all_by_date
    ALL_BY_DATE
  end

  def self.reset_all
    ALL.clear
    ALL_BY_DATE.clear
  end

  def self.count
    ALL.count
  end

  def self.hash_by_date
    by_date = {}
    old_date = ""
    ALL.each do |data_set|
      date = data_set.date
      # binding.pry
      if old_date.empty?
        old_date = date
      elsif date != old_date
        ALL_BY_DATE << by_date
        old_date = date
      end
      # binding.pry

      by_date[date] ||= {}
      by_date[date][:total_accidents] ||= 0
      by_date[date][:total_accidents] += 1
      by_date[date][:total_killed] ||= 0
      by_date[date][:total_killed] += data_set.no_persons_killed.to_i
      by_date[date][:total_injured] ||= 0
      by_date[date][:total_injured] += data_set.no_persons_injured.to_i
      by_date[date][data_set.contributing_factor1] ||= 0
      by_date[date][data_set.contributing_factor1] += 1
      # binding.pry
      # by_date[date][causes2] ||= []
      # by_date[date][causes2] << data_set.contributing_factor2
    end
    ALL_BY_DATE
  end

  def initialize(attributes={})
    attributes.each{|key, value|
      self.send(("#{key}="), value)}
      ALL << self
  end


end
