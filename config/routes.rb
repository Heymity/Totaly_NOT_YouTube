require 'api_version_constraint'

Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	namespace :api, defaults: {format: :json} do
		namespace :v1, path: "/", constrains: ApiVersionConstraint.new(version: 1, default: true) do
			resources :teste
		end
	end
end
