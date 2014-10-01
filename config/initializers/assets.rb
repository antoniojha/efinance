
Rails.application.config.assets.precompile += %w( jquery-ui-1.10.4.custom.js )
[ Proc.new { |path, fn| fn =~ /app\/assets/ && !%w(.js .css).include?(File.extname(path)) }, /application.(css|js)$/ ]
