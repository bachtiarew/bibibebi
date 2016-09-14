module BabysitterHelper

  def has_babysitter?
    @babysitter = Babysitter.find_by_user_id(session[:user_id])
    unless @babysitter
      link_to 'Create New Babysitter' , new_babysitter_path
  	else
  	  link_to "Babysitter Profile", babysitters_path(@babysitter.id)
    end

  end

end
