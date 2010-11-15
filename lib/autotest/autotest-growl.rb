 def self.is_windows?
    processor, platform, *rest = RUBY_PLATFORM.split("-")
    platform == 'mswin32'
  end
 
  ##
  # Display a message through Growl.
  def self.growl title, message, icon, priority=0, stick=""
    growl = File.join(GEM_PATH, 'growl', 'growlnotify')
    image = File.join(ENV['HOME'], '.autotest-growl', "#{icon}.png")
    image = File.join(GEM_PATH, 'img', "#{icon}.png") unless File.exists?(image)
 
    if is_windows?
      growl += '.com'
      cmd = "#{growl} #{message.inspect} /a:\"autotest\" /r:\"Autotest\" /n:\"Autotest\" /i:\"#{image}\" /p:#{priority} /t:\"#{title}\""
    else 
      if @@remote_notification
        cmd = "#{growl} -H localhost -n autotest --image '#{image}' -p #{priority} -m #{message.inspect} '#{title}' #{stick}"
      else
        cmd = "#{growl} -n autotest --image '#{image}' -p #{priority} -m #{message.inspect} '#{title}' #{stick}"
      end
    end
 
  system cmd
  end