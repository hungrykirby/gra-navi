require 'net/http'
require 'uri'
require 'json'

class MapsController < ApplicationController
    def oscmap
        rakuten_app_id = ENV['RAKUTEN_APP_ID']

        @center_lat = 35.6812362
        @center_lon = 139.7671248

        url = URI.parse("https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?format=json&datumType=1&latitude=" + @center_lat.to_s + "&longitude=" + @center_lon.to_s + "&searchRadius=1&applicationId=" + rakuten_app_id)
        #puts url
        json = Net::HTTP.get(url)
        result = JSON.parse(json)
        #p result
        @yado_data = []
        if result.has_key?('hotels') then
            for hotel in result['hotels'] do
                #p hotel['hotel'][0]['hotelBasicInfo']
                lat = hotel['hotel'][0]['hotelBasicInfo']['latitude']
                lon = hotel['hotel'][0]['hotelBasicInfo']['longitude']

                @yado_data.push([lat, lon])
            end
        end

    end

    def update
        place = params[:data][:text]
        results = { :message => place }
        render partial: 'ajax_partial', locals: { :results => results }
    end
end