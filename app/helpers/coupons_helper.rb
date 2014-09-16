module CouponsHelper

  def print_type(type)
    if type == 0
      r = "Inversión"
    elsif type == 1
      r = "SwisGolden"
    else
      r = "Comisión"
    end
  end


end
