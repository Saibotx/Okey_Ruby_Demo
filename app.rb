require 'rubygems'
require 'sinatra'

get '/hi' do
	'dsfsdf'
end


get '/Lock' do
	id = params['id']
	approve = params['approve']
	deny = params['deny']
	find = params['find']
	viewlog = params['viewlog']
	
	if id.nil?
		"MUST SPECIFY ID"
	elsif approve = 1
		"success approve"
	elsif deny = 1
		"Success deny"
	elsif find = 1
		"Success find"
	elsif viewlog = 1
		"Success viewlog"
	else
		"no command specified"
	end
	
	
end


get '/approved' do
	if File.exist?('./tmp/approved-id.log')
		File.open('./tmp/approved-id.log', 'a') do |f|
			f.write(params['id'] + "\n")
		end
	else
		myfile = File.new('./tmp/approved-id.log', "w+")
		myfile.puts(params['id'] + "\n")
		myfile.close
	end
	
	"success"
end

get '/find' do
	id = params['id']
	
	registered_ids = []
	
	File.open('./tmp/approved-id.log', 'r').each_line do |l|
		registered_ids << l.sub("\n", "")
	end
	
	ret = "false"
	
	registered_ids.each do |rid|
		if rid == id
			ret = "true"
		end
	end
	
	ret
end

get '/denied' do
	id = params['id']
	
	registered_ids = []
	
	File.open('./tmp/approved-id.log', 'r').each_line do |l|
		registered_ids << l.sub("\n", "")
	end
	
	ret = "false"
	
	registered_ids.each do |rid|
		if rid == id
			registered_ids.delete(rid)
		end
	end
	
	File.delete('./tmp/approved-id.log')
	
	myfile = File.new('./tmp/approved-id.log', "w+")
	myfile.puts(registered_ids.join("\n"))
	myfile.puts("\n")
	myfile.close
	
	"success"
end

get '/test' do
	'hi toby'
	
	erb :test
end