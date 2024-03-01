# frozen_string_literal: true

# spec/mailers/application_mailer_spec.rb

require 'rails_helper'

RSpec.describe ApplicationMailer, type: :mailer do
  
  describe 'default settings' do
    it 'uses the correct "from" address' do
      expect(ApplicationMailer.default[:from]).to eq('from@example.com')
    end

  end
end