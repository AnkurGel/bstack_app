FactoryGirl.define do
  factory :upload do
    file ActionDispatch::Http::UploadedFile.new(
      tempfile: File.new("#{Rails.root}/spec/factories.rb"), 
      filename: 'factories.rb')
    user
  end

  factory :user do
    name "Ankur Goel"
    email "ankur@ankurgoel.com"
    password "hocuspocus"
    password_confirmation "hocuspocus"
  end
end
