module KalpeshExtensions

  def printf *args
    unless defined?(@log)
      @log = Logger.new(Rails.root.to_s + "/log/custom.log")
      @logger = Logger.new(Rails.root.to_s + "/log/#{Rails.env}.log")
    end
    if args.present?
      args.each do |arg|
        if arg.class.name == 'Array'
          arg.each {|a| print_it(a, true) }
        else
          print_it(arg)
        end
      end
    end
    puts ""
    @log.info ""
    @logger.info ""
  end

  def print *args
    unless defined?(@log)
      @log = Logger.new(Rails.root.to_s + "/log/custom.log")
      @logger = Logger.new(Rails.root.to_s + "/log/#{Rails.env}.log")
    end
    puts "\n\n\n#{'*' * 25} #{Time.now.strftime("%d %b %H:%M:%:S %P")} #{'*' * 25}"
    @log.info "\n\n\n#{'*' * 25} #{Time.now.strftime("%d %b %H:%M:%:S %P")} #{'*' * 25}"
    @logger.info "\n\n\n#{'*' * 25} #{Time.now.strftime("%d %b %H:%M:%:S %P")} #{'*' * 25}"
    if args.present?
      args.each do |arg|
        if arg.class.name == 'Array'
          arg.each {|a| print_it(a, true) }
        else
          print_it(arg)
        end
      end
    end
    puts "#{'*' * 25} #{Time.now.strftime("%d %b %H:%M:%S %P")} #{'*' * 25} \n\n\n"
    @log.info "#{'*' * 25} #{Time.now.strftime("%d %b %H:%M:%S %P")} #{'*' * 25} \n\n\n"
    @logger.info "#{'*' * 25} #{Time.now.strftime("%d %b %H:%M:%S %P")} #{'*' * 25} \n\n\n"
  end

  def print_it(arg, insp=false)
    if insp
      puts arg.inspect
      @log.info arg.inspect
      @logger.info arg.inspect
    else
      puts arg
      @log.info arg
      @logger.info arg
    end
  end

  def clear
    system 'clear'
  end

  def token_please params
    hdata = params.sort.collect{|i| i.last}.join("")
    OpenSSL::HMAC.hexdigest("sha1", Settings.encryption_secret_key, hdata)
  end
end
include KalpeshExtensions
system `cat /dev/null > log/#{Rails.env}.log`
system `cat /dev/null > log/custom.log`
