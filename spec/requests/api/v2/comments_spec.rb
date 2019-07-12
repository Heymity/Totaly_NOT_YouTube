require 'rails_helper'

RSpec.describe 'Videos API', type: :request do
    let!(:user) { create(:user) }
    let!(:auth_data) { user.create_new_auth_token }
    let(:video_id) { video.id }
    let(:user_id) { user.id }
    let(:id) { comment.id }
    let!(:video) { create(:video, user_id: user_id) }
    let!(:comment) { create(:comment, user_id: user_id, video_id: video_id)}
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
    describe "Comments tests" do

        describe "GET comments/:id" do
            
            
            before do             
                #headers = { "Accept" => "application/vnd.projetofase8.v1" }
                get "/videos/#{video_id}/comments/#{id}", params: {}, headers: headers
            end

            context "when the comment exists" do
                it "returns the comment" do
                    #user_response = JSON.parse(response.body)
                    expect(json_body["data"]["id"]).to eq(String(id))
                end
                it "return status code 200" do
                    expect(response).to have_http_status(200)
                end
            end

            context "when the comment doesn`t exists" do
                let(:id){ 9999999 }

                it "returns status code 404" do
                    expect(response).to have_http_status(404)
                end
            end
        end

        describe "POST /comments" do
        
            before do
                #headers = { "Accept" => "application/vnd.projetofase8.v1" }
                post "/videos/#{video_id}/comments", params: { comment: comment_params }, headers: headers
            end
            
            context "when the request params are valid" do
                let(:comment_params){ attributes_for(:comment) }
                
                it "returns status code 201" do
                    expect(response).to have_http_status(201)
                end
                
                it "returns json data for the created comment" do
                    #user_response = JSON.parse(response.body)
                    expect(json_body['data']['attributes']['description']).to eq(comment_params[:description])
                end
            end
            
            context "when the request params are invalid" do
                let(:comment_params){ attributes_for(:comment, description: nil) }
                
                it "returns status code 422" do
                    expect(response).to have_http_status(422)
                end
                
                it "returns the json data for the erros" do
                    #user_response = JSON.parse(response.body)
                    expect(json_body).to have_key('errors')
                end
            end 
            
        end

        describe "DELETE comment/:id" do

            before do
                #headers = { "Accept" => "application/vnd.projetofase8.v1" }
                delete "/videos/#{video_id}/comments/#{id}", params: {}, headers: headers
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