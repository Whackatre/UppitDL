# Uppit Direct Downloader (UppitDL)
# Author: Mew
# Date: November 8, 2012
#
# To see usage instructions, please
# refer to the README (README.md).

require "net/http"
require "uri"

url = ARGV[0]

# Exit if no argument is received.
if url == nil
	puts "Invalid argument received.\nUsage: ./uppitdl <uppit_link>\n"
	puts "Use the argument -n (at the end) to not download the file (and only return the URL)."
	exit
end

# Get the actual page if it is the 'short link'.
if url.include?('up.ht')
	short_found = false
	uri = URI.parse(url)
	http = Net::HTTP.new(uri.host, uri.port)
	response = http.request(Net::HTTP::Get.new(uri.request_uri))
	response.body.each do |line|
		m = /<a href="(.*)">moved here<\/a>/.match(line)
		url = m[1] if m
		short_found = true
	end
	if not short_found
		puts "Long form of short URL not found!"
		exit
	end
end

# Visit the specified page.
uri = URI.parse(url)
http = Net::HTTP.new(uri.host, uri.port)
response = http.request(Net::HTTP::Get.new(uri.request_uri))
form = {"method_free" => "btn_download"}

# Parse the page and push values into the form hash.
response.body.each do |line|
	m = /<input type="hidden" name="(.*)" value="(.*)">/.match(line)
	form[m[1]] = m[2] if m
end

# Visit the page again and find the direct download URL.
link = nil
response = Net::HTTP.post_form(uri, form)
response.body.each do |line|
	m = /<DIV class="downloadSteps download"><A class="downloadLink" href="(.*)"><SPAN>Download/i.match(line)
	link = m[1] if m
end

# If the link was found, download it using wget;
# otherwise, print debug information.
if link != nil
	puts "Direct Download URL: #{link}"
	if not ARGV.include?('-n')
		puts "Initiating download..."
		`wget #{link}`
	end
else
	puts "Failed to find download!\nTry updating at 'https://github.com/Whackatre/UppitDL'!"
	puts "Debug:"
	puts url
	form.each do |k, v|
		puts "#{k} => '#{v}'"
	end
end
