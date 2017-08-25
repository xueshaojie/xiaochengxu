module ApplicationHelper

    def current_user
      p "##!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      p session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end

end
