class EmailsController < ApplicationController
  before_action :authenticate_user!

  def new
    @emails = Form::EmailCollection.new
  end

  def create
    @emails = Form::EmailCollection.new(email_params)

    @emails.collection.delete_if { |email| email[:email].nil? || email[:email].empty? || email[:email].blank? }

    # なぜか一つだけ処理してくれない
    # @emails.collection.each do | email |
    #   binding.pry
    #   if email[:email].nil? || email[:email].empty? || email[:email].blank? || email[:email].exclude?("@")
    #     binding.pry
    #     @emails.collection.delete(email)
    #   end
    # end

    if @emails.save
      @emails.collection.each do |email|
        QuestionMailer.questions_send(current_user,email).deliver_now
      end

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
