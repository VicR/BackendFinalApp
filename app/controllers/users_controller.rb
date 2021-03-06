# +User+ Controller
class UsersController < ApplicationController
  # filters
  before_action :authenticate_user!
  before_action :user, only: %i[show update destroy]

  # Fetch all +User+
  # @return [Array] JSON array of all +User+
  # @example
  #   {
  #     "users": [{
  #       "id":151,
  #       "name":"Terence",
  #       "email":"horace@boganwisozk.net"
  #     }],
  #     "meta":{
  #       "itemsCount":2,
  #       "pagesCount":1
  #     }
  #   }
  def index
    render_json_api_list_resource(
      collection: User.where.not(id: current_user.id),
      search_fields: %i[name email]
    )
  end

  # Fetches a given +User+ element with a given +id+
  # @param id [Integer] +User+ id
  # @param name [String] User first name
  # @param email [String] Email address
  # @param profile [Integer] User profile
  # @return [JSON] JSON serialization of found record
  # @example
  #   {
  #     "user": {
  #       "id":154,
  #       "name":"Orland",
  #       "email":"cornelius_hamill@murazik.biz"
  #     }
  #   }
  def show
    if @user.nil?
      render json: {}, status: :not_found
    else
      render json: @user
    end
  end

  # Create a new instance of +User+ and save it to the database
  # @param id [Integer] +User+ id
  # @param name [String] User first name
  # @param email [String] Email address
  # @param profile [Integer] User profile
  # @return [JSON] JSON with the object and status code if created or error if not created
  # @example
  #   {
  #     "user": {
  #       "id":154,
  #       "name":"Orland",
  #       "email":"cornelius_hamill@murazik.biz"
  #     }
  #   }
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render_error(user)
    end
  end

  # Update an existing instance of +User+ and save it to the database
  # @param id [Integer] +User+ id
  # @param name [String] User first name
  # @param email [String] Email address
  # @param profile [Integer] User profile
  # @return [JSON] JSON with the object and status code if created or error if not created
  # @example
  #   {
  #     "user": {
  #       "id":154,
  #       "name":"Updated name",
  #       "email":"cornelius_hamill@murazik.biz"
  #     }
  #   }
  def update
    if @user.update(user_params)
      render json: @user
    else
      render_error @user
    end
  end

  # Destroy an existing instance of +User+
  # @param id [Integer] +User+ id
  # @return [JSON] Return no content status on success
  # @example
  #   {}
  def destroy
    render json: @user.destroy
  end

  protected

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :profile,
      :password,
      :password_confirmation
    )
  end

  def user
    @user ||= User.find_by(id: params[:id])
  end
end
