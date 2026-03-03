get "/signup" do
  redirect "/" if session[:username]
  @employee = Employee.new
  erb :signup
end

post "/signup" do
  @error = "Please correct the information below"
  @employee = Employee.new

  if @employee.signup(params)
    @employee.save
    redirect "/"
  end

  erb :signup
end
