class OrderReceipt < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def order_receipt_email(order)
    @order = order
    mail(to: order.email, from:'no-reply@jungle.com', subject: "Receipt for Order ID ##{order.id}")
  end
end
