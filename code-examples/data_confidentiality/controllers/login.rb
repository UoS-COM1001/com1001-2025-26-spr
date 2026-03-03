get "/login" do
  redirect "/" if session[:usermame]
  erb :login
end

post "/login" do
  @error = "Username/Password combination incorrect"
  username = params.fetch("username", "").strip
  employee = Employee.first(username: username)

  if !employee.nil? && employee.authenticate(params.fetch("password", ""))
    session[:username] = username
    redirect "/"
  end

  erb :login
end
