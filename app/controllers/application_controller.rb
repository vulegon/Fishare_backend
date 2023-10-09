class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from Exception, with: :render_500

  def render_500(error)
    message = "システムエラーが発生しました。管理者にお問い合わせください"
    json = { message: message }
    render status: :internal_server_error, json: json
  end

  # パラメーターに誤りがあった場合、クライアントに整形してエラーメッセージを返します
  # @return
  # {
  #   messages: [Array<String>],
  #   details: {
  #     errors_key1: [Array<String>],
  #     errors_key2: [Array<String>],
  #   }
  # }
  def render_parameter_error(params)
    messages = params.errors.full_messages || ["不正なパラメーターです"]

    details = {}
    params.errors.attribute_names.each do |erros_key|
      details[erros_key] = params.errors[erros_key]
    end

    json = {
      messages: messages,
      details: details,
    }

    render status: :bad_request, json: json
  end
end
