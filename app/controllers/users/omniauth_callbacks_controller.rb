class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    author = User.from_omniauth(request.env["omniauth.auth"])
    if author.persisted?
      flash.notice = "ログインしました"
      sign_in_and_redirect author
    else
      flash.notice = "登録完了しました"
      sign_in_and_redirect author
    end
  end
end
