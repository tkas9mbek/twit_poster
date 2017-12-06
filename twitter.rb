require 'twitter'
require 'optparse'

options = {}

OptionParser.new do |opt|
  opt.banner = 'Usage: twitter.rb [options]'

  opt.on('-h', 'Help') do
    puts opt
    exit
  end

  opt.on('--twit "TWIT"', 'To twit') {
      |o| options[:twit] = o
  }

  opt.on('--timeline USERNAME', 'To show last twits') {
      |o| options[:timeline] = o
  }
end.parse!

client = Twitter::REST::Client.new do |config|
  config.consumer_key = 'YDY8GJwf8cCNcfeFe23qK2rQq'
  config.consumer_secret = 'ey2eeOp3fGR2f60uE6T3MNT8JN1LN7npV4Kir6lXZxMKot0Ofd'
  config.access_token = '938444925326196737-mvnGEtMK04r91tuS6WxZ7jvFdL2biBe'
  config.access_token_secret = 'hv7uMQ89TxnWyL1gTNSP3yicMqVm8z9ZUbGRrc4qjMgjf'
end

if options.key?(:twit)
  puts "Posting the twit \"#{options[:twit]}\""
  client.update("#{options[:twit]} (Posted by ruby app)")
  puts "Done"
end

if options.key?(:timeline)
  puts "Feed of user #{options[:timeline]}"

  opts = {count: 10, include_rts: true}

  twits = client.user_timeline(options[:timeline], opts)

  twits.each do |twit|
    puts twit.text
    puts "by @#{twit.user.screen_name} at #{twit.created_at}"
    puts "*" * 40
  end
else
  puts "My feed, last 10 twits:"
  twits = client.home_timeline({count: 10, include_rts: true})
  twits.each do |twit|
    puts twit.text
    puts "by @#{twit.user.screen_name} at #{twit.created_at}"
    puts "*" * 50
  end
end