module RecurlyLegacyGem
  # The Webhook class handles delegating the webhook request body to the appropriate
  # notification class. Notification classes enapsualte the supplied data, providing
  # access to account details, as well as subscription, invoice, and transaction
  # details where available.
  #
  # @example
  #   Recurly::Webhook.parse(xml_body)  # => #<Recurly::Webhook::NewAccountNotification ...>
  #
  #   notification = Recurly::Webhook.parse(xml_body)
  #   case notification
  #   when Recurly::Webhook::NewAccountNoficiation
  #     # A new account was created
  #     ...
  #   when Recurly::Webhook::NewSubscriptionNotification
  #     # A new subscription was added
  #     ...
  #   when Recurly::Webhook::SubscriptionNotification
  #     # A subscription-related notification was sent
  #     ...
  #   end
  module Webhook
    autoload :Notification,                         'recurly_legacy_gem/webhook/notification'
    autoload :AccountNotification,                  'recurly_legacy_gem/webhook/account_notification'
    autoload :SubscriptionNotification,             'recurly_legacy_gem/webhook/subscription_notification'
    autoload :InvoiceNotification,                  'recurly_legacy_gem/webhook/invoice_notification'
    autoload :TransactionNotification,              'recurly_legacy_gem/webhook/transaction_notification'
    autoload :DunningNotification,                  'recurly_legacy_gem/webhook/dunning_notification'
    autoload :CreditPaymentNotification,            'recurly_legacy_gem/webhook/credit_payment_notification'
    autoload :BillingInfoUpdatedNotification,       'recurly_legacy_gem/webhook/billing_info_updated_notification'
    autoload :CanceledSubscriptionNotification,     'recurly_legacy_gem/webhook/canceled_subscription_notification'
    autoload :CanceledAccountNotification,          'recurly_legacy_gem/webhook/canceled_account_notification'
    autoload :ClosedInvoiceNotification,            'recurly_legacy_gem/webhook/closed_invoice_notification'
    autoload :ClosedCreditInvoiceNotification,      'recurly_legacy_gem/webhook/closed_credit_invoice_notification'
    autoload :NewCreditInvoiceNotification,         'recurly_legacy_gem/webhook/new_credit_invoice_notification'
    autoload :ProcessingCreditInvoiceNotification,  'recurly_legacy_gem/webhook/processing_credit_invoice_notification'
    autoload :ReopenedCreditInvoiceNotification,    'recurly_legacy_gem/webhook/reopened_credit_invoice_notification'
    autoload :VoidedCreditInvoiceNotification,      'recurly_legacy_gem/webhook/voided_credit_invoice_notification'
    autoload :NewCreditPaymentNotification,         'recurly_legacy_gem/webhook/new_credit_payment_notification'
    autoload :VoidedCreditPaymentNotification,      'recurly_legacy_gem/webhook/voided_credit_payment_notification'
    autoload :ExpiredSubscriptionNotification,      'recurly_legacy_gem/webhook/expired_subscription_notification'
    autoload :FailedPaymentNotification,            'recurly_legacy_gem/webhook/failed_payment_notification'
    autoload :NewAccountNotification,               'recurly_legacy_gem/webhook/new_account_notification'
    autoload :UpdatedAccountNotification,           'recurly_legacy_gem/webhook/updated_account_notification'
    autoload :NewInvoiceNotification,               'recurly_legacy_gem/webhook/new_invoice_notification'
    autoload :NewChargeInvoiceNotification,         'recurly_legacy_gem/webhook/new_charge_invoice_notification'
    autoload :ProcessingChargeInvoiceNotification,  'recurly_legacy_gem/webhook/processing_charge_invoice_notification'
    autoload :PastDueChargeInvoiceNotification,     'recurly_legacy_gem/webhook/past_due_charge_invoice_notification'
    autoload :PaidChargeInvoiceNotification,        'recurly_legacy_gem/webhook/paid_charge_invoice_notification'
    autoload :FailedChargeInvoiceNotification,      'recurly_legacy_gem/webhook/failed_charge_invoice_notification'
    autoload :ReopenedChargeInvoiceNotification,    'recurly_legacy_gem/webhook/reopened_charge_invoice_notification'
    autoload :NewSubscriptionNotification,          'recurly_legacy_gem/webhook/new_subscription_notification'
    autoload :PastDueInvoiceNotification,           'recurly_legacy_gem/webhook/past_due_invoice_notification'
    autoload :ReactivatedAccountNotification,       'recurly_legacy_gem/webhook/reactivated_account_notification'
    autoload :RenewedSubscriptionNotification,      'recurly_legacy_gem/webhook/renewed_subscription_notification'
    autoload :SuccessfulPaymentNotification,        'recurly_legacy_gem/webhook/successful_payment_notification'
    autoload :SuccessfulRefundNotification,         'recurly_legacy_gem/webhook/successful_refund_notification'
    autoload :UpdatedSubscriptionNotification,      'recurly_legacy_gem/webhook/updated_subscription_notification'
    autoload :VoidPaymentNotification,              'recurly_legacy_gem/webhook/void_payment_notification'
    autoload :ProcessingPaymentNotification,        'recurly_legacy_gem/webhook/processing_payment_notification'
    autoload :ProcessingInvoiceNotification,        'recurly_legacy_gem/webhook/processing_invoice_notification'
    autoload :ScheduledPaymentNotification,         'recurly_legacy_gem/webhook/scheduled_payment_notification'
    autoload :NewDunningEventNotification,          'recurly_legacy_gem/webhook/new_dunning_event_notification'
    autoload :GiftCardNotification,                 'recurly_legacy_gem/webhook/gift_card_notification'
    autoload :PurchasedGiftCardNotification,        'recurly_legacy_gem/webhook/purchased_gift_card_notification'
    autoload :RedeemedGiftCardNotification,         'recurly_legacy_gem/webhook/redeemed_gift_card_notification'
    autoload :UpdatedBalanceGiftCardNotification,   'recurly_legacy_gem/webhook/updated_balance_gift_card_notification'
    autoload :NewUsageNotification,                 'recurly_legacy_gem/webhook/new_usage_notification'
    autoload :TransactionAuthorizedNotification,    'recurly_legacy_gem/webhook/transaction_authorized_notification'
    # This exception is raised if the Webhook Notification initialization fails
    class NotificationError < Error
    end

    # @return [Resource] A notification.
    # @raise [NotificationError] For unknown or invalid notifications.
    def self.parse xml_body
      xml = XML.new xml_body
      class_name = Helper.classify xml.name

      if Webhook.const_defined?(class_name, false)
        klass = Webhook.const_get class_name
        klass.from_xml xml_body
      else
        raise NotificationError, "'#{class_name}' is not a recognized notification"
      end
    end
  end
end
