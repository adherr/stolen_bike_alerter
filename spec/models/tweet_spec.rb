require 'spec_helper'

describe Tweet do

  describe :create_bike_index_post_hash do 
    it "should make a post hash" do 
      twitter_account = FactoryGirl.create(:national_active_twitter_account)
      bi_response = '{"id":3414,"serial":"stolen_serial_number","registration_created_at":"2014-05-20T10:34:44-05:00","registration_updated_at":"2014-05-20T10:36:50-05:00","url":"https://bikeindex.org/bikes/3414","api_url":"https://bikeindex.org/api/v1/bikes/3414","manufacturer_name":"Jamis","manufacturer_id":201,"frame_colors":["Blue"],"paint_description":"Ano Black","stolen":true,"name":"","year":2014,"frame_model":"Allegro Comp Disc","description":"Triple-butted 6061 aluminum with hydro-formed top and down tube, taper gauge \"S\" bend stays, replaceable derailleur hanger, disc brake mounts, eyeleted dropouts and seatstay rack mounts","rear_tire_narrow":true,"front_tire_narrow":true,"photo":"https://bikebook.s3.amazonaws.com/uploads/Fr/9979/14_allegrocompdisc_bk.jpg","thumb":"https://bikebook.s3.amazonaws.com/uploads/Fr/9979/small_14_allegrocompdisc_bk.jpg","title":"2014 Jamis Allegro Comp Disc (blue)","images":[],"rear_wheel_size":{"iso_bsd":622,"name":"700 C","description":"700 C, 29in mountain bikes (Standard size)"},"front_wheel_size":{"iso_bsd":622,"name":"700 C","description":"700 C, 29in mountain bikes (Standard size)"},"handlebar_type":null,"frame_material":null,"front_gear_type":null,"rear_gear_type":null,"stolen_record":{"date_stolen":"2014-05-20T01:00:00-05:00","location":"Chicago, IL","latitude":41.9161202,"longitude":-87.6677594,"theft_description":"This is a test stolen bike.","locking_description":"U-lock","lock_defeat_description":"Lock is missing, along with the bike.","police_report_number":"Some number","police_report_department":"Chicago, IL"},"components":[{"component_type":"fork","component_group":"Frame and fork","rear":null,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"headset","component_group":"Frame and fork","rear":null,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"wheel","component_group":"Wheels","rear":null,"front":true,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"wheel","component_group":"Wheels","rear":true,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"tire","component_group":"Wheels","rear":null,"front":true,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"tire","component_group":"Wheels","rear":true,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"derailleur","component_group":"Drivetrain and brakes","rear":null,"front":true,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"derailleur","component_group":"Drivetrain and brakes","rear":true,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"shifter","component_group":"Drivetrain and brakes","rear":null,"front":true,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"shifter","component_group":"Drivetrain and brakes","rear":true,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"chain","component_group":"Drivetrain and brakes","rear":null,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"cog/cassette/freewheel","component_group":"Drivetrain and brakes","rear":null,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"crankset","component_group":"Drivetrain and brakes","rear":null,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"bottom bracket","component_group":"Drivetrain and brakes","rear":null,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"pedals","component_group":"Drivetrain and brakes","rear":null,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"brake","component_group":"Drivetrain and brakes","rear":null,"front":true,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"brake","component_group":"Drivetrain and brakes","rear":true,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"handlebar","component_group":"Additional parts","rear":null,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"stem","component_group":"Additional parts","rear":null,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"grips/tape","component_group":"Additional parts","rear":null,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"seatpost","component_group":"Additional parts","rear":null,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null},{"component_type":"saddle","component_group":"Additional parts","rear":null,"front":null,"manufacturer_name":null,"manufacturer_id":null,"model_name":"","year":null}]}'
      bike = FactoryGirl.create(:bike_with_binx)
      bike.save
      tweet = Tweet.new(twitter_tweet_id: 69,
        tweet_string: 'STOLEN - something special',
        bike_id: bike.id,
        twitter_account_id: twitter_account.id
      )
      # pp tweet
      tweet.create_bike_index_post_hash
      p_hash = tweet.bike_index_post_hash
      # pp p_hash
      expect(p_hash[:bike_id]).to eq(3414)
      expect(p_hash[:tweet_id]).to eq(69)
      expect(p_hash[:tweet_string]).to match('STOLEN -')
      expect(p_hash[:tweet_account_screen_name]).to match('bikeicorn')
      expect(p_hash[:tweet_account_image]).to be_present
      expect(p_hash[:tweet_account_name]).to match('bikeicorn')
      expect(p_hash[:retweet_screen_names]).to eq([])
    end
  end

end


