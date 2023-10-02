class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from Exception, with: :render_500

  def render_500(error)
    message =  'システムエラーが発生しました。管理者にお問い合わせください'
    json = { message: message }
    render status: :internal_server_error, json: json
  end

  def render_parameter_error(params)
    message = params.errors.full_messages || '不正なパラメーターです'
    json = { message: message }
    render status: :bad_request, json: json
  end
end
