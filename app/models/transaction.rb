require 'active_merchant/billing/rails'

class Transaction < ApplicationRecord
  belongs_to :order
  serialize :params
  validate :validate_card, on: :create

  attr_accessor :card_number, :card_verification, :first_name, :last_name

  def transact
    self.save
    response = GATEWAY.purchase(price_in_cents, credit_card, ip: self.ip_address )
    update_attributes(action: "purchase", amount: price_in_cents, response: response)
    order.update_attribute(:purchased_at, Time.now) if response.success?

    response.success?
  end

  def response=(response)
    self.success        = response.success?
    self.authorization  = response.authorization
    self.message        = response.message
    self.params         = response.params
  rescue ActiveMerchant::ActiveMerchantError => e
    self.success        = false
    self.authorization  = nil
    self.message        = e.message
    self.params         = {}
  end

  def price_in_cents
    @order = Order.find(order_id)
    (@order.total_price*100).round
  end

  private

  def credit_card
    @order = Order.find(order_id)
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      brand:                card_type,
      number:               card_number,
      verification_value:   card_verification,
      month:                card_expires_on.month,
      year:                 card_expires_on.year,
      first_name:           @order.first_name,
      last_name:            @order.last_name
    )
  end
  
  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add(:base, message)
      end
    end
  end
end
