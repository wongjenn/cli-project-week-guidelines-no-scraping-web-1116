class NYPDMVAdapter
  attr_reader :query
  URL = "https://data.cityofnewyork.us/resource/qiz3-axqb.json"

  def initialize(query)
    @query = query
  end

  def fetch_data
    working_on_it
    data = getting_MV_data
    list = isolate_borough(data)
    create_collision_instance_array(list)
  end

  def working_on_it
    puts "Fetching all collisions for borough of #{query.capitalize} for the month of December 2016."
  end

  def getting_MV_data
    response = RestClient.get("#{URL}")
    JSON.parse(response)
  end

  def isolate_borough(data)
    data.select {|collision| collision["borough"] == @query }
  end

  def create_collision_instance_array(list)
    list.each do |accident|
      Collisions.new({unique_key: accident["unique_key"], date: accident["date"].slice(0...10), contributing_factor1: accident["contributing_factor_vehicle_1"], contributing_factor2: accident["contributing_factor_vehicle_2"], no_persons_injured: accident["number_of_persons_injured"], no_persons_killed: accident["number_of_persons_killed"]})
    end
  end
end
