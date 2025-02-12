# {{ ansible_managed }}

services {
  name = "haproxy-t2-http"
  id   = "haproxy-t2-http"
  port = 80
}

services {
  name = "haproxy-t2-https"
  id   = "haproxy-t2-https"
  port = 443
}

services {
  name = "haproxy-t2-prometheus"
  id   = "haproxy-t2-prometheus"
  port = 8405

  meta {
    prometheus_scrape = "true"
  }
}