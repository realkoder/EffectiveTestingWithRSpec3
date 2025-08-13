def current_toaster
  @current_toaster ||= Toaster.find_by_serial('HHGG42')
end

@current_toaster = nil || Toaster.find_by_serial('HHGG42')