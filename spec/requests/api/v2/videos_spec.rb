require 'rails_helper'

RSpec.describe 'Videos API', type: :request do
    let!(:user) { create(:user) }
    let(:user_id) { user.id }
    let!(:video) { create(:video, user_id: user_id) }
    let(:id) { video.id }
    let(:headers) { { "Accept" => "application/vnd.projetofase8.v2", "Authorization" => user.auth_token } }
    
    before { host! "localhost:3000/api" }
    describe "Videos tests" do

        describe "GET videos/:id" do
            
            
            before do             
                #headers = { "Accept" => "application/vnd.projetofase8.v1" }
                get "/videos/#{id}", params: {}, headers: headers
            end

            context "when the video exists" do
                it "returns the video" do
                    #user_response = JSON.parse(response.body)
                    expect(json_body["id"]).to eq(id)
                end
                it "return status code 200" do
                    expect(response).to have_http_status(200)
                end
            end

            context "when the video doesn`t exists" do
                let(:id){ 10000 }

                it "returns status code 404" do
                    expect(response).to have_http_status(404)
                end
            end
        end

        describe "DELETE user/:id" do

            before do
                #headers = { "Accept" => "application/vnd.projetofase8.v1" }
                delete "/videos/#{id}", params: {}, headers: headers
            end

            it "returns status code 204" do
                expect(response).to have_http_status(204)
            end

            it "removes the user from the database" do
                expect( User.find_by(id: id) ).to be_nil
            end
        end
    end 
end     