template {
  source = "/etc/consul-templates/templates/jackmuratore.ctmpl"
  destination = "/etc/nginx/conf.d/http/jackmuratore.conf"
  command = "systemctl reload nginx"
  command_timeout = "60s"
  perms = 0660
  backup = true
  wait {
    min = "2s"
    max = "10s"
  }
}

