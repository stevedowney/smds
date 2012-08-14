class App

  CAPTCHA_TEXT = "Type the words you see in the image"
  
  class << self

    def test?
      Rails.env == 'test'
    end
    
    def twitter
      test? ? TestTwitter : Twitter
    end

    
  end
  
end