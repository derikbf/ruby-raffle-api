class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_reader :current_user

  # rescue_from Pundit::NotAuthorizedError,   with: :permission_denied

  private     

  def authenticate_request
     @current_user = AuthorizeApiRequest.call(request.headers).result
     render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end    

  def ensure_json_request 
    unless  request.headers["Accept"] =~/vnd\.api\+json/
      render :nothing => true, :status => 406 
    else
      unless request.get? 
        return if request.headers["Content-Type"] =~ /vnd\.api\+json/ 
        render :nothing => true, :status => 415 
      end
    end
  end    



  # def permission_denied
  #    head 403
  # end
end
