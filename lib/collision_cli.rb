class CollisionCLI

  def call
    greeting
    query = choose_borough
    while query != "EXIT"
      fetch_data(query)
      display_info_by_date
      Collisions.reset_all
      query = choose_borough
    end
  end

  def greeting
    puts "Welcome to the NYPD Motor Vehicle Collision website."
  end

  def choose_borough
    puts "Please choose a NYC borough: Manhattan, Brooklyn, Queens,  Bronx or Staten Island? Type 'exit' to end."
    query = gets.strip.upcase
  end

  def fetch_data(query)
    adapter = NYPDMVAdapter.new(query)
    adapter.fetch_data
  end

  def display_info_by_date
    list = Collisions.hash_by_date

    list.each do |data|
      data.each do |date, info|
        puts "------------------------"
        puts "For this date: #{date}"
        info.each do |stat, count|
          status = stat.to_s.downcase.gsub("_", " ")
          puts "There have been #{count} #{status}."
        end
      end
    end
  end

  # def display_info
  #
  #   list.each do |data_set|
  #     puts "Date: #{data_set.date}"
  #     collison_case(data_set)
  #     puts "Injured: #{data_set.no_persons_injured}"
  #     puts "Killed: #{data_set.no_persons_killed}"
  #   end
  # end
  #
  # def collison_case(data_set)
  #   if data_set.contributing_factor2 == "Unspecified"
  #     puts "Cause: #{data_set.contributing_factor1}"
  #   elsif data_set.contributing_factor2 == nil
  #     puts "Cause: #{data_set.contributing_factor1}"
  #   elsif data_set.contributing_factor2 == data_set.contributing_factor1
  #     puts "Cause: #{data_set.contributing_factor1}"
  #   elsif data_set.contributing_factor1 == "Unspecified"
  #     puts "Cause: #{data_set.contributing_factor2}"
  #   elsif data_set.contributing_factor1 == "Other Vehicular"
  #     puts "Cause: #{data_set.contributing_factor2}"
  #   else
  #     puts "Cause1: #{data_set.contributing_factor1}"
  #     puts "Cause2: #{data_set.contributing_factor2}"
  #   end
  # end


end
