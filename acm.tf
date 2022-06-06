resource "aws_acm_certificate" "alb_cert" {
  private_key       = file("${path.module}/${local.certificate_private_key}")
  certificate_body  = file("${path.module}/${local.certificate_body}")
  certificate_chain = file("${path.module}/${local.certificate_chain}")
  #tags              = local.tags
  lifecycle {
    create_before_destroy = true
  }
}