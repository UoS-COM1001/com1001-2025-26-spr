RSpec.describe "signup controller" do
  describe "GET /login" do
    it "displays a blank form" do
      get "/login"
      expect(last_response).to be_ok
      expect(last_response.body).to include("Please enter your username and password")
    end
  end

  describe "POST /login" do
    it "logs in a valid user" do
      employee = Employee.new
      employee.signup({ "username" => "phil", "password" => "password", "ni_number" => "NI number" })
      employee.save
      post "/login", "username" => "phil", "password" => "password"
      expect(last_response).to be_redirect
      expect(last_response.location).to end_with("/")
    end

    it "fails to login with an incorrect password" do
      employee = Employee.new
      employee.signup({ "username" => "phil", "password" => "password", "ni_number" => "NI number" })
      employee.save
      post "/login", "username" => "phil", "password" => "not the right password"
      expect(last_response).to be_ok
      expect(last_response.body).to include("Username/Password combination incorrect")
    end
  end
end
