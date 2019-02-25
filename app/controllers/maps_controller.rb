# -*- coding: utf-8 -*-

require 'net/http'
require 'uri'
require 'json'

class MapsController < ApplicationController
    
    before_action :load_vars

    def oscmap
        p @rakuten_app_id

        @center_lat = 35.6812362
        @center_lon = 139.7671248

        url = URI.parse("https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?format=json&datumType=1&latitude=" + @center_lat.to_s + "&longitude=" + @center_lon.to_s + "&searchRadius=1&applicationId=" + @rakuten_app_id)
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
        place = params[:data]
        #@results = { :message => place }
        url = URI.parse(URI.encode('https://nominatim.openstreetmap.org/search/' + place + '?format=json&polygon=0&addressdetails=1'))
        json = Net::HTTP.get(url)
        result = JSON.parse(json)

        @center_lat = 35.68
        @center_lon = 139.77

        if result.length > 0 then
            @center_lat = result[0]['lat']
            @center_lon = result[0]['lon']
        end

        url = URI.parse("https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?format=json&datumType=1&latitude=" + @center_lat.to_s + "&longitude=" + @center_lon.to_s + "&searchRadius=1&applicationId=" + @rakuten_app_id)

        json = Net::HTTP.get(url)
        result = JSON.parse(json)

        @yado_data = []
        if result.has_key?('hotels') then
            for hotel in result['hotels'] do
                #p hotel['hotel'][0]['hotelBasicInfo']
                lat = hotel['hotel'][0]['hotelBasicInfo']['latitude']
                lon = hotel['hotel'][0]['hotelBasicInfo']['longitude']

                @yado_data.push([lat, lon])
            end
        end

        @results = {
            'lat' => @center_lat, 'lon' => @center_lon, 'yado_data' => @yado_data
        }

        render json: @results, status: 200
    end
    
    private
    def load_vars
        @rakuten_app_id = ENV['RAKUTEN_APP_ID']
    end
end