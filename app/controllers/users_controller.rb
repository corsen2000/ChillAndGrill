class UsersController < ApplicationController
  load_and_authorize_resource

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
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    authorize! :assign_roles, @user if params[:user][:roles]
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end

end
