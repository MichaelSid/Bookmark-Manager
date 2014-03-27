get '/users/new' do
	# note the view is in views/users/new.erb
	# we need the quotes because otherwise
	# ruby would divide the symbol :users by the variable new (which makes no sense)
	@user = User.new
	erb :"users/new"
end

post '/users' do
	#we just initialize the object with saving it. It may be invalid.
	@user = User.new(:email => params[:email],
		:password => params[:password],
		:password_confirmation => params[:password_confirmation])
	#let's try saving it. If the model is valid, it will be saved.
	if @user.save 
		session[:user_id] = @user.id 
		redirect to('/')
	#if it's not valid, we'll show the same form again.
	else
	#We're using flash[:errors] instead of flash[:notice]. 
	#Given that these errors prevent us from proceeding further, it's more appropriate to call them errors.
	#We're also using flash.now instead of just flash. By default, a flash message is available for 
	#both the current request and the next request. This is very convenient if we're doing a redirect. 
	#However, since we are just re-rendering the page, we just want to show the flash for the current request, not for the next one. If we use flash[:errors], then after the user fixes the mistakes, we'll be redirected to the homepage where we'll see our message again.
		flash.now[:errors] = @user.errors.full_messages
		#The @user.errors object contains all validation errors. It can be used to get errors for a given field (if you want to display the error next to a
		#specific field). The full_messages method just returns an array of all errors as strings.
		erb :"users/new"
	end
end