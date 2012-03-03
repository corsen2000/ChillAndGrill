class UsersController < ApplicationController  
  load_and_authorize_resource
  force_ssl

  def index
  end

  def show
  end

  def new
    @title = "Sign Up"    
  end

  def edit
  end

  def create
    authorize! :assign_roles, @user if params[:user][:roles]
    if @user.save
      redirect_to root_url(:protocol => "http"), :notice => 'Account Created.  Plase check your email for instructions.'
    else
      render action: "new"
    end
  end

  def update
    authorize! :assign_roles, @user if params[:user][:roles]
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render action: "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end

  def approve
    User.find(params[:id]).approve
    redirect_to users_path
  end

end
