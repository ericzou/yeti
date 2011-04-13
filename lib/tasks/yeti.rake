namespace :yeti do
  desc "some random puts " 
  task :do_stuff => [:environment] do 
    Rails.logger.info "here stuff"
    puts "puts stuff"
  end
end
