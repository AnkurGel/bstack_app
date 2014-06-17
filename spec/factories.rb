FactoryGirl.define do
  factory :file do

    path ActionDispatch::Http::UploadedFile.new(
      tempfile: File.new("#{Rails.root}/spec/factories.rb"), 
      filename: 'factories.rb')

  end

  factory :user do
    name "Ankur Goel"
    email "ankur@ankurgoel.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
