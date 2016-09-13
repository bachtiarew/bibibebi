module BabysitterHelper

  def has_babysitter?
    @babysitter = Babysitter.find_by("user_id", session[:user_id])

    unless @babysitter
      link_to 'Register to be babysitter now!' , new_babysitter_path
    end

  end

end
