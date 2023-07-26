# frozen_string_literal: true

require 'factory_bot_rails'

FactoryBot.create(:bid, country: 'us', category: 'finance', channel: 'ca', amount: 4.0)
FactoryBot.create(:bid, country: 'uk', category: 'sports', channel: '*', amount: 3.0)
FactoryBot.create(:bid, country: 'us', category: '*' , channel: '*', amount: 2.0)
FactoryBot.create(:bid, country: '*', category: '*', channel: '*', amount: 1.0)