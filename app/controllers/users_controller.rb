class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # Creating a session/user is a path that anyone can take so we want to
  # skip the authorized action

  skip_before_action :authorized, only: %i[new create]

  def index; end
  def show; end
  def edit; end

  def new
    @user = User.new
  end

  def create
    @user = User.create(params.require(:user).permit(:username,
                                                     :password))
    session[:user_id] = @user.id
    redirect_to '/welcome'
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :username, :password)
  end
end
