class User < ActiveRecord::Base
  include Stripe::Callbacks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates_presence_of :name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

		has_one :business, :dependent => :destroy
 
  before_create :create_stripe_customer
  after_customer_updated! do |customer, event|
    user = User.where(stripe_customer_id: customer.id).first
		end

		def admin?
		 	self.admin == true
		end


  def do_subscription_transaction(type, stripe_token)
				amount = Transaction.amount_for_type(type)
    card = save_credit_card(stripe_token) 
    if type == "gold"
					subscribe_gold
					self.mark_gold!
					elsif type == "platinum"
     subscribe_platinum
					self.mark_platinum!
					elsif type == "diamond"
     subscribe_diamond
					self.mark_diamond!
						else
						flash[:danger] = "You did not choose an account type."
	     redirect_to new_payment_path
					end
  end

			def mark_gold!
    update!(status: 1)
   end

			def market_platinum!
    update!(status: 2)
   end

			def mark_diamond!
    update!(status: 3)
   end

  def stripe_customer
    Stripe::Customer.retrieve(stripe_customer_id)
  end


  def deposit(amount, card)
    customer = stripe_customer

    Stripe::Charge.create(
      amount: amount,
      currency: 'usd',
      customer: customer.id,
      card: card.id,
      description: "Charge for #{email}"
    )

    customer.account_balance += amount
    customer.save
  rescue => e
    false
  end

  private

  def subscribe_gold
    stripe_customer.subscriptions.create(plan: "gold")
  end

  def subscribe_platinum
    stripe_customer.subscriptions.create(plan: "platinum")
  end

  def subscribe_diamond
    stripe_customer.subscriptions.create(plan: "diamond")
  end


  def create_coupon(coupon)
    customer = stripe_customer
    already_has_off3_coupon = customer.discount && customer.discount.any? { |type, co| type == :coupon && co.id == 'off3' }

    return true if coupon == 'off3' && already_has_off3_coupon

    customer.coupon = coupon
    customer.save
  end

  def create_stripe_customer
    customer = Stripe::Customer.create(email: email, account_balance: 0)
    self.stripe_customer_id = customer.id
  end

  def save_credit_card(card_token)
    stripe_customer.cards.create(card: card_token)
  end

 end

