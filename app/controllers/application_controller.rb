class ApplicationController < ActionController::Base
	include ActionView::Helpers::UrlHelper
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception
  	before_filter :configure_permitted_parameters, if: :devise_controller?

	protected

  	def configure_permitted_parameters
  		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password) }

  		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password) }
	end

	helper_method :fetch_categories_moods

	def fetch_categories_moods(data, data_type, item, category_mood, show)
		if category_mood == "category" && data_type == "trigger"
			if !Category.where(:id => item.to_i).first.description.blank?
				link_name = Category.where(:id => item.to_i).first.name
				link_url = '/categories/' + item.to_s
				if show
					link_url += '?trigger=' + data.id.to_s
				end 
				return_this = link_to link_name, link_url
			else 
				return_this = Category.where(:id => item.to_i).first.name
			end
			if item != data.category.last
				return_this += ', '
			end
		elsif category_mood == "mood" && data_type == "trigger"
			if !Mood.where(:id => item.to_i).first.description.blank?
				link_name = Mood.where(:id => item.to_i).first.name
				link_url = '/moods/' + item.to_s 
				if show
					link_url += '?trigger=' + data.id.to_s
				end 
				return_this = link_to link_name, link_url
			else 
				return_this = Mood.where(:id => item.to_i).first.name
			end
			if item != data.mood.last
				return_this += ', '
			end
		end

		return return_this
	end

end