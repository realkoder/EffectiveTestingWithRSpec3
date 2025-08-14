class BerlinTransitTicket
  attr_accessor :starting_station, :ending_station

  def fare
    if starting_station == 'BundesTag' && ending_station == 'Leopoldplatz'
      2.7
    else
      3.3
    end
  end
end