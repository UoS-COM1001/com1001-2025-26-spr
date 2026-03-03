get "/" do
  username = session[:username]
  unless username.nil?
    @employee = Employee.first(username: username)
    @logged_in = true unless @employee.nil?
  end

  erb :index
end
