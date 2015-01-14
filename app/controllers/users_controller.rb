class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @users = User.all
    # test_block_proc_lambda
    # @users = User.all
    respond_with(@users)
  end

  def show
    respond_with(@user)
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.name = "touched once!"
    @user.name = "touched twice!"
    @user.save
    # Park.new.save
    respond_with(@user)
  end

  def update
    @user.update(user_params)
    respond_with(@user)
  end

  def destroy
    @user.destroy
    respond_with(@user)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :age)
  end


  def do_something(my_callback, *params)
    # send ("my_callback", params)
    # my_callback
    # logger.debug "somesomesome"
  end

  def my_callback (*params)
    logger.debug "calcalcalcal", params.inspect
  end

  # if you want to send callbacks, it MUST have to be a block
  def my_block(&block)
    block.call "hola!"
    # yield "hola!" #alias for block.call
  end

  def test_block_proc_lambda
    #important!! lambda parameter is with parentheses!!!!!!!!
    hihi = ->(msg) { logger.debug "made by stabby lambda #{msg}" }
    #important!! but proc is inside block!!!! awkward!!!
    hihi2 = Proc.new { |msg| logger.debug "made by proc #{msg}" }
    my_block(&hihi) #convert lambda to block with ampersand
    my_block(&hihi2) #convert proc to block with ampersand
    my_block do |msg| #multiline block
      logger.debug "multiline block#{msg}"
    end
    my_block { logger.debug "singleline block" } #singleline block
  end

end
