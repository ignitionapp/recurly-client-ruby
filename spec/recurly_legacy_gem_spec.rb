require 'spec_helper'

describe RecurlyLegacyGem do
  describe "api key" do

    it "must be assignable" do
      RecurlyLegacyGem.api_key = 'new_key'
      RecurlyLegacyGem.api_key.must_equal 'new_key'
    end

    it "must raise an exception when not set" do
      if RecurlyLegacyGem.instance_variable_defined? :@api_key
        RecurlyLegacyGem.send :remove_instance_variable, :@api_key
      end
      proc { RecurlyLegacyGem.api_key }.must_raise ConfigurationError
    end

    it "must raise an exception when set to nil" do
      RecurlyLegacyGem.api_key = nil
      proc { RecurlyLegacyGem.api_key }.must_raise ConfigurationError
    end

    it "must use defaults set if not sent in new thread" do
      RecurlyLegacyGem.api_key = 'old_key'
      RecurlyLegacyGem.subdomain = 'olddomain'
      RecurlyLegacyGem.default_currency = 'US'
      Thread.new {
        RecurlyLegacyGem.api_key.must_equal 'old_key'
        RecurlyLegacyGem.subdomain.must_equal 'olddomain'
        RecurlyLegacyGem.default_currency.must_equal 'US'
      }
    end

    it "must use new values set in thread context" do
      RecurlyLegacyGem.api_key = 'old_key'
      RecurlyLegacyGem.subdomain = 'olddomain'
      RecurlyLegacyGem.default_currency = 'US'
      Thread.new {
          RecurlyLegacyGem.config(api_key: "test", subdomain: "testsub", default_currency: "IR")
          RecurlyLegacyGem.api_key.must_equal 'test'
          RecurlyLegacyGem.subdomain.must_equal 'testsub'
          RecurlyLegacyGem.default_currency.must_equal 'IR'
      }
      RecurlyLegacyGem.api_key.must_equal 'old_key'
      RecurlyLegacyGem.subdomain.must_equal 'olddomain'
      RecurlyLegacyGem.default_currency.must_equal 'US'
    end
  end
end
