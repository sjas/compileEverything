# Gitlab application config file

# Email used for notification
# about new issues, comments
email:
  from: notify@gitlabhq.com
  host: gitlabhq.com

  # Protocol used for links in email letters
  # Value can be http or https
  protocol: http # or https

# Git Hosting congiguration
git_host:
  system: gitolite
  admin_uri: gitolitesrv:gitolite-admin
  base_path: @H@/repositories/
  host: localhost
  git_user: @USERNAME@
  port: @PORT_SSHD@

# Git settings
# Use default values unless you understand it
git:
  # Max size of git object like commit, in bytes
  # This value can be increased if you have a very large commits
  git_max_size: 5242880 # 5.megabytes
  # Git timeout to read commit, in seconds
  git_timeout: 10