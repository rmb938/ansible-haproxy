# {{ ansible_managed }}

services {
  name = "haproxy-t1-http"
  id   = "haproxy-t1-http"
  port = 80
}

services {
  name = "haproxy-t1-https"
  id   = "haproxy-t1-https"
  port = 443
}