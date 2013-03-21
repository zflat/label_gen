LabelGen.configure do |config|
  config.qr_url = "http://qr.somedomain.com/items/abc-%{number}/"
  config.number_label = "%<number>.05d"
end
