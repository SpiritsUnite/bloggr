class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  # GET /register
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(new_params)

    if @user.save
      add_notice(:success, 'You have successfully signed up')
      redirect_to root_path
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(update_params)
      add_notice(:success, 'You have successfully updated your details.')
      redirect_to @user
    else
      render action: 'edit'
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    add_notice(:success, 'User was successfully destroyed.')
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if params[:id] == 'me'
        @user = current_user
      else
        @user = User.find(params[:id])
      end
    end

    # Only allow a trusted parameter "white list" through.
    def new_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def update_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
