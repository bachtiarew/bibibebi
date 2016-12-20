module BabysitterHelper

  def has_babysitter?
    @babysitter = Babysitter.find_by_user_id(session[:user_id])
    unless @babysitter
      link_to 'Create New Babysitter' , new_babysitter_path
  	else
  	  link_to "Babysitter Profile", babysitter_path(@babysitter.id)
    end

  end

  def get_babysitters
  	babysitters = Babysitter.all
	  babysitters.as_json(include: [:user, :role_ratings, :pictures], except: [:password_digest])
  end

end
