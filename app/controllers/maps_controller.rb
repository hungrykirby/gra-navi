require 'net/http'
require 'uri'
require 'json'

class MapsController < ApplicationController
    # @testに緯度経度の多重配列を渡す
    def oscmap
        rakuten_app_id = ENV['RAKUTEN_APP_ID']

        url = URI.parse("https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?format=json&latitude=128440.51&longitude=503172.21&searchRadius=1&applicationId=" + rakuten_app_id)
        puts url
        json = Net::HTTP.get(url)
        result = JSON.parse(json)
        for hotel in result['hotels'] do
            #p hotel['hotel'][0]['hotelBasicInfo']
            p hotel['hotel'][0]['hotelBasicInfo']['latitude']
            p hotel['hotel'][0]['hotelBasicInfo']['longitude']
        end

        @test = [[34.69, 135.49], [35.68, 139.69], [43, 141.35], [33.59, 130.40]]

        #puts result

    end
end