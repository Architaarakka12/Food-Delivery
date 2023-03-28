class UsersController < ApplicationController
  before_action :redirect_if_authenticated, only: [:create, :new]  
  
  def create
    @user = User.new(create_user_params)
    if @user.save
      @user.send_confirmation_email!
      # redirect_to root_path, notice: "Please check your email for confirmation instructions."
      log_in @user
      flash[:success] = "Welcome #{user_params[:first_name]} to dinner dash!"
      MailerWorker.perform_async(@user.id)
      redirect_to root_path
    else
      flash[:error] = "One or more required fields are missing"
      # render "new"
      render :new, status: :unprocessable_entity
    end
  end
    
  def show
    @user = User.find_by(id: params[:id])
    args = args_params || {}
    if @user
      if !args.nil?
        @orders = @user.orders
        @title = args[:title] || "Profile"
      else
        @orders = @user.orders.order(created_at: :desc).limit(3)
        @title = "Recent Orders"
      end
    else
      flash[:message] = "We're sorry we couldn't find any information for this user."
      redirect_to root_path
    end
  end

  def destroy
    # current_user.destroy
    # reset_session
    # redirect_to root_path, notice: "Your account has been deleted."
    user = User.find(params[:id])
    if user
      user.destroy
      reset_session
      flash[:success] = "#{user.first_name} has been deleted."
      redirect_to dashboard_path
    else
      flash[:error] = "An error occured. Try deleting #{@user.first_name} again."
    end
  end

  def edit
    @user = current_user
    @active_sessions = @user.active_sessions.order(created_at: :desc)
  end

  def update
    @user = current_user
    @active_sessions = @user.active_sessions.order(created_at: :desc)
    if @user.authenticate(params[:user][:current_password])
      if @user.update(update_user_params)
        if params[:user][:unconfirmed_email].present?
          @user.send_confirmation_email!
          redirect_to root_path, notice: "Check your email for confirmation instructions."
        else
          redirect_to root_path, notice: "Account updated."
        end
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:error] = "Incorrect password"
      render :edit, status: :unprocessable_entity
    end
  end

    def new
        @user = User.new
    end
    
    private
    
      def create_user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      end

      def update_user_params
        params.require(:user).permit(:current_password, :password, :password_confirmation, :unconfirmed_email)
      end

      def args_params
        args = params.require(:args).permit(:show_all, :title) if params.has_key? "args"
      end
end
