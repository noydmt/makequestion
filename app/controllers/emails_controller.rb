class EmailsController < ApplicationController
  before_action :authenticate_user!

  def new
    # 5つ分のform用のオブジェクトを用意
    @emails = Form::EmailCollection.new

    # 過去に送信した送信先を表示
    @past_emails = current_user.emails.select(:email).distinct
  end

  def create
    @emails = Form::EmailCollection.new(email_params)
    @past_emails = current_user.emails.select(:email).distinct

    # emailアドレスが空のオブジェクトを削除
    @emails.collection.delete_if { |email| email[:email].nil? || email[:email].empty? || email[:email].blank? }
    
    # 削除後、要素が0個の場合
    if @emails.collection.length == 0
      flash[:notice] = 'メールアドレスを入力してください'
      redirect_to new_email_path  and return
    end

    if @emails.save
      @emails.collection.each do |email|
        # 送信先にメールを送信
        QuestionMailer.questions_send(current_user,email).deliver_now
      end
      redirect_to root_path, notice: "送信先件数 : #{@emails.collection.length} 件"
    else
      flash.now[:notice] = 'メールアドレスが不正です。'
      render :new
    end
  end

  private
  def email_params
    params.require(:emails)
  end 
end
