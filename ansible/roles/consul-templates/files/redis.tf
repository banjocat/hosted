template {
  source = "/etc/consul-templates/templates/redis.ctmpl"
  destination = "/etc/nginx/conf.d/tcp/redis.conf"
  #destination = "/tmp/redis.conf"
  command = "systemctl reload nginx"
  command_timeout = "60s"
  perms = 0660
  backup = true
  wait {
    min = "2s"
    max = "10s"
  }
}

