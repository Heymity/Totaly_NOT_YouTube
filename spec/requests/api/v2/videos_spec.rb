require 'rails_helper'

RSpec.describe 'Videos API', type: :request do
    let!(:user) { create(:user) }
    let!(:auth_data) { user.create_new_auth_token }
    let(:id) { video.id }
    let(:user_id) { user.id }
    let!(:video) { create(:video, user_id: user_id) }
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
    describe "Videos tests" do

        describe "GET videos/:id" do
            
            
            before do             
                #headers = { "Accept" => "application/vnd.projetofase8.v1" }
                get "/videos/#{id}", params: {}, headers: headers
            end

            context "when the video exists" do
                it "returns the video" do
                    #user_response = JSON.parse(response.body)
                    expect(json_body["data"]["id"]).to eq(String(id))
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

        describe "POST /videos" do
        
            before do
                #headers = { "Accept" => "application/vnd.projetofase8.v1" }
                post "/videos", params: { video: video_params }, headers: headers
            end
            
            context "when the request params are valid" do
                let(:video_params){ attributes_for(:video) }
                
                it "returns status code 201" do
                    expect(response).to have_http_status(201)
                end

                it "saves the video in the database" do
                    expect( Video.find_by(video_text: video_params[:video_text]) ).not_to be_nil
                end
                
                it "returns json data of video_text for the created video" do
                    #user_response = JSON.parse(response.body)
                    expect(json_body['data']['attributes']['video-text']).to eq(video_params[:video_text])
                end

                it "returns json data of description for the created video" do
                    #user_response = JSON.parse(response.body)
                    expect(json_body['data']['attributes']['description']).to eq(video_params[:description])
                end

                it "returns json data of user_id for the created video" do
                    #user_response = JSON.parse(response.body)
                    expect(json_body['data']['relationships']['user_id']).to eq(video_params[:user_id])
                end
            end
            
            context "when the request params are invalid" do
                let(:video_params){ attributes_for(:video, video_text: nil) }
                
                it "returns status code 422" do
                    expect(response).to have_http_status(422)
                end
                
                it "returns the json data for the erros" do
                    #user_response = JSON.parse(response.body)
                    expect(json_body).to have_key('errors')
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