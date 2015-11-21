class ProfilesController < ApplicationController

  def new
    # form where a user can fill out their own profile
    @user = User.find(params[:user_id])
    @profile = Profile.new
  end

  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def create
    @user = User.find(params[:user_id])
    @profile = @user.build_profile(profile_params)

    if @profile.save
      flash[:success] = 'Your profile has been successfully created.'
      redirect_to user_path(params[:user_id])
    else
      flash.now[:danger] = 'There was a problem with your profile. Please try again.'
      render :new
    end
  end

  private
   def profile_params
    params.require(:profile).permit(:first_name, :last_name, :job_title, 
                                    :phone_number, :contact_email, :description)
   end

end