namespace :adminuseradd do

  desc "Create AdminUser"
  task :create, ['name', 'email', 'password'] => :environment do |task, args|
    if args.name.nil?
      puts "name is required"
      next
    end
    if args.email.nil?
      puts "email is required"
      next
    end
    if args.password.nil?
      puts "password is required"
      next
    end
    begin
      @user = User.new(name: args.name, email: args.email, password: args.password)
      @user.admin = true
      if @user.save!
        puts "Success to Create!"
       end
      rescue => e
        puts e
      end
    p args
  end

end