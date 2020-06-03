class EmailsController < ApplicationController
  before_action :authenticate_user!

  def new
    @emails = Form::EmailCollection.new
  end

  def create
    @emails = Form::EmailCollection.new(email_params)
    @emails.collection.each do |email|

      if hankaku?(email[:email]) && email[:email].include?("@")
        @emails.collection = email
      end

    end

    if @emails.save
      redirect_to root_path, notice: '#{}件に送信完了'
    else
      flash.now[:notice] = 'メールアドレスが不正です。'
      render :new
    end
  end

  private
  def email_params
    params.require(:emails)
  end

  def hankaku?(str)
    unless str.to_s =~ /^[ -~｡-ﾟ]*$/
      return false
    end
    return true
  end
 
end
