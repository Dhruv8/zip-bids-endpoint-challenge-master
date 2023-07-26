# frozen_string_literal: true

# Controller for Bids model this will handle the API bids endpoint
class BidsController < ApplicationController
  def show_bids
    query_params = bids_params.as_json
    countries = query_params['countries'].split(',')
    categories = query_params['categories'].split(',')
    channels = query_params['channels'].split(',')
    bids = []
    countries.each do |country|
      categories.each do |category|
        channels.each do |channel|
          bid = {}
          bid.merge!(country: country, category: category, channel: channel)
          amount = find_amount(country, category, channel)
          bid.merge!(amount)
          bids.push(bid)
        end
      end
    end
    result = { "bids": bids }
    render json: JSON.pretty_generate(result)
  end

  private

  def find_amount(country, category, channel)
    query = (Bid.where(country: country).and(Bid.where(category: category)).and(Bid.where(channel: channel))).to_a
    if query.first.present?
      {
        amount: query.flatten.first.amount.to_f.to_s
      }
    else
      {
        amount: Bid.where(country: country)
                   .or(Bid.where(country: '*')).and(Bid.where(category: category)
                   .or(Bid.where(category: '*')))
                   .and(Bid.where(channel: channel).or(Bid.where(channel: '*'))).first&.amount.to_f.to_s
      }
    end
  end

  def bids_params
    params.permit(:countries, :categories, :channels)
  end
end
