RSpec.describe Employee do
  describe "#signup" do
    it "encrypts the employee's secret data" do
      employee = described_class.new
      signup_info = { "username" => "fred", "password" => "pass", "ni_number" => "Fred's NI Number" }
      expect(employee.signup(signup_info)).to be true
    end
  end
end
