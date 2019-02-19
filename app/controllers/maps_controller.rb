class MapsController < ApplicationController
    # @testに緯度経度の多重配列を渡す
    def oscmap
      @test = [[34.69, 135.49], [35.68, 139.69], [43, 141.35], [33.59, 130.40]]

      @ln = ENV['LOGIN_NAME']
      @lp = ENV['LOGIN_PASSWORD']
    end
end