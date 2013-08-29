class UsersController < ApplicationController
  before_filter :require_admin!, :except => [:edit, :update, :change_password]
  before_filter :require_admin_or_owner!, only: [:edit, :update]
  before_filter :find_user, only: [:edit, :update, :destroy, :show, :change_password]

  def index
    @users = User.select("id, first_name, last_name, username, email")
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @user.update_attributes(params[:user].permit(:first_name, :last_name, :username))
      redirect_to edit_user_path(@user), notice: 'User was successfully updated.'
    else
      render "edit"
    end
  end

  def change_password
    if current_user.update_with_password(params[:user].permit(:current_password, :password, :password_confirmation))
      redirect_to "/", notice: 'Password Changed successfully!'
      sign_in current_user, :bypass => true
    else
      render "edit"
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    redirect_to users_url
  end

  def require_admin_or_owner!
    unless current_user.id.to_s == params[:id] || current_user.is_admin
      flash[:alert] = "Access denied"
      respond_to do |format|
        format.html {
          redirect_to "/"
        }
        format.js {
          render js: "window.location='/'"
        }
      end
    end
  end
end
