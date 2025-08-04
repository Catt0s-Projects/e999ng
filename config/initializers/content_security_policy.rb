# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    hosts = config.hosts.map { |h| h.is_a?(Regexp) ? nil : "#{h}" }.compact
    policy.default_src :self, *hosts
    policy.script_src  :self, *hosts, "ads.dragonfru.it", "https://www.google.com/recaptcha/", "https://www.gstatic.com/recaptcha/", "https://www.recaptcha.net/", "https://assets.freespeechcoalition.com"
    policy.style_src   :self, *hosts, :unsafe_inline
    policy.connect_src :self, *hosts, "ads.dragonfru.it", "plausible.dragonfru.it", "static1.e621.net", "static1.e926.net", "api.freespeechcoalition.com"
    policy.object_src  :self, *hosts, "static1.e621.net", "static1.e926.net"
    policy.media_src   :self, *hosts, "static1.e621.net", "static1.e926.net"
    policy.frame_ancestors :none
    policy.frame_src   'https://www.google.com/recaptcha/', 'https://www.recaptcha.net/'
    policy.font_src    :self, *hosts
    policy.img_src     :self,  *hosts, :data, 'static1.e621.net', 'static1.e926.net', 'ads.dragonfru.it'
    policy.child_src   :none
    policy.form_action :self, 'discord.e621.net', 'discord.com'
    # Specify URI for violation reports
    # policy.report_uri "/csp-violation-report-endpoint"
  end

  # Generate session nonces for permitted importmap and inline scripts
  config.content_security_policy_nonce_generator = ->(request) { SecureRandom.base64(16) }
  config.content_security_policy_nonce_directives = %w(script-src)

  # Report violations without enforcing the policy.
  config.content_security_policy_report_only = false
end
