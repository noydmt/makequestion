class QuestionMailer < ApplicationMailer
  default from: 'from@example.com'

  def questions_send(from_user,to_user)
    @fromUser = from_user
    @toUser = to_user
    mail from: 'noreply@gmail.com',
         to: to_user.email,
         cc: from_user.email,
         subject: "please answer the question."
  end
end
