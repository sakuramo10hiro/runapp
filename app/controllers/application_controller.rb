class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])  # 入力フォームからアカウント名情報をDBに保存するために追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:image])
  end

  def after_sign_in_path_for(resource)
    if current_user
      flash[:notice] = "ログインしました"
      home_path
    else
      flash[:notice] = "新規登録が完了しました"
      home_path
    end
  end
end
