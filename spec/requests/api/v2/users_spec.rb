require 'rails_helper'

RSpec.describe 'Users API', type: :request do
    let!(:user) { create(:user) }
    let!(:auth_data) { user.create_new_auth_token }
    let(:headers) do
        { 
            "Accept" => "application/vnd.projetofase8.v2", 
            "Authorization" => user.auth_token,
            "access-token" => auth_data['access-token'],
            "uid" => auth_data['uid'],
            "client" => auth_data['client']
        }
    end
    
    before { host! "localhost:3000/api" }
    
    describe "GET /auth/validate_token" do
        
        context "when the request headers are valid" do
            before do
                #headers = { "Accept" => "application/vnd.projetofase8.v1" }
                get "/auth/validate_token", params: {}, headers: headers
            end
            it "returns the user" do
                #user_response = JSON.parse(response.body)
                expect(json_body["data"]["id"].to_i).to eq(user.id)
            end
            it "returns status code 200" do
                expect(response).to have_http_status(200)
            end
        end
        
        context "when the request headers are not valid" do
            before do
                headers["access-token"] = "invalid_token"
                #headers = { "Accept" => "application/vnd.projetofase8.v1" }
                get "/auth/validate_token", params: {}, headers: headers
            end
                        
            it "returns status code 401" do
                expect(response).to have_http_status(401)
            end
        end
    
    end
    
    describe "POST /auth" do
        
        before do
            #headers = { "Accept" => "application/vnd.projetofase8.v1" }
            post "/auth", params: user_params, headers: headers
        end
        
        context "when the request params are valid" do
            let(:user_params){ attributes_for(:user) }
            
            it "returns status code 200" do
                expect(response).to have_http_status(200)
            end
            
            it "returns json data for the created user" do
                #user_response = JSON.parse(response.body)
                expect(json_body['data']['email']).to eq(user_params[:email])
            end
        end
        
        context "when the request params are invalid" do
            let(:user_params){ attributes_for(:user, email: "email_invalido@") }
            
            it "returns status code 422" do
                expect(response).to have_http_status(422)
            end
            
            it "returns the json data for the erros" do
                #user_response = JSON.parse(response.body)
                expect(json_body).to have_key('errors')
            end
        end 
        
    end
    
    describe "PUT /auth" do
        
        before do
            #headers = { "Accept" => "application/vnd.projetofase8.v1" }
            put "/auth", params: user_params, headers: headers
        end
        
        context "when the request params are valid" do
            let(:user_params){ { email: 'novo@email.com' } }
            
            it "returns status code 200" do
                expect(response).to have_http_status(200)
            end
            
            it "returns json data for the update user" do
                #user_response = JSON.parse(response.body)
                expect(json_body['data']['email']).to eq(user_params[:email])
            end
        end
        
        context "when the request params are invalid" do
            let(:user_params){ { email: 'email_invalido@' } }
            
            it "returns status code 422" do
                expect(response).to have_http_status(422)
            end
            
            it "returns the json data for the erros" do
                #user_response = JSON.parse(response.body)
                expect(json_body).to have_key('errors')
            end
        end
    
    end
    
    describe "DELETE /auth" do
        
        before do
            #headers = { "Accept" => "application/vnd.projetofase8.v1" }
            delete "/auth", params: {}, headers: headers
        end
        
        it "returns status code 200" do
            expect(response).to have_http_status(200)
        end
        
        it "removes the user from database" do
            expect( User.find_by(id: user.id) ).to be_nil
        end
        
    end
    
end
