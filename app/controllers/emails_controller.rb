class EmailsController < ApplicationController
  before_action :authenticate_user!

  def new
    @email = Email.new
  end

  def create
    5.times do |num|
      strNum = num.to_s
      val = email_params[strNum]
      binding.pry
      if val.include?("@") && hankaku?(val)
        binding.pry
        @email = Email.create(user_id: current_user.id, email: val)
        binding.pry
      else
        @email = Email.new(email: val)
        redirect_to new_email_path and return
      end
    end
    redirect_to root_path, notice: '完了'
  end

  private
  def email_params
    params.require(:email)
  end

  def hankaku?(str)
    unless str.to_s =~ /^[ -~｡-ﾟ]*$/
      return false
    end
    return true
  end
 
end
