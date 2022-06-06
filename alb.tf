module "alb" {
  source             = "terraform-aws-modules/alb/aws"
  version            = "~> 6.0"
  name               = "${var.website_name}-alb-${var.env}"
  load_balancer_type = var.alb_type
  vpc_id             = aws_vpc.sscp_vpc_stg.id

  subnets = [for subnet in aws_subnet.public_subnet : subnet.id]

  security_groups = [aws_security_group.cloudflare_access_sg.id]

  target_groups = [
    {
      name                 = "${var.website_name}-tg-${var.env}"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/index.html"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200"
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = aws_acm_certificate.alb_cert.arn
      target_group_index = 0
    }
  ]

  tags = {
    Environment = var.env
    Project     = var.project_name
  }
}