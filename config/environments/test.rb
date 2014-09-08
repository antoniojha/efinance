WebFinance::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance.
  config.serve_static_assets  = true
  config.static_cache_control = 'public, max-age=3600'

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  # ***this configuration is very important when using rspec testing. If it's set to false and there is a bug
  #  the test will show internal server error instead of regular test module.  
  #  refer http://stackoverflow.com/questions/15950677/where-do-i-see-the-reason-of-a-internal-server-error-when-running-rails-reques and https://github.com/jnicklas/capybara/issues/303
  config.action_dispatch.show_exceptions = true

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
    config.action_mailer.default_url_options={:host=>"localhost:3000"}
  #raises error for deprecation
  config.active_support.deprecation = :raise
  #Set up for Gmail for SMTP
    config.action_mailer.smtp_settings={
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'gmail.com',
    enable_starttls_auto: true,
    authentication: 'plain',
    user_name: 'antoniojha@gmail.com',
    password: '6004Aj??'
  }
end
