require 'spec_helper'
require 'dotenv'
Dotenv.load

describe BikesController do
  describe "POST #create" do
    context "without correct parameters" do
      it "should fail without :api_url" do
        expect{ post(:create, {}) }.to raise_error(ActionController::ParameterMissing)
        expect{ post(:create, {key: ENV['INCOMING_REQUEST_KEY']}) }.to raise_error(ActionController::ParameterMissing)
      end
      it "should fail with incorrect parameters" do
        expect{ post(:create, {name: "seth"}) }.to raise_error(ActionController::ParameterMissing)
      end
      it "should fail with incorrect key" do
        expect{ post(:create, {key: "ery138NmQjttVStbJbWKcX47KffPZJGy"}) }.to raise_error(RuntimeError)
      end
    end

    context "with an :api_url" do
      xit "should return success" do
        post(:create, {api_url: "https://bikeindex.org/api/v1/bikes/3414", key: ENV['INCOMING_REQUEST_KEY']})
        expect(response).to be_success
      end
      xit "should create a tweet on the appropriate twitter" do
        
      end
    end
  end
end
