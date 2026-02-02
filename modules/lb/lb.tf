resource "aws_lb" "lb_store" {
  name               = "${var.app-name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = var.subnet

  //enable_deletion_protection = false

  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_listener" "lb_store_listener" {
  load_balancer_arn = aws_lb.lb_store.arn
  port              = "8080"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_store_tg.arn
  }
}

resource "aws_lb_target_group" "lb_store_tg" {
  name     = "${var.app-name}-lb-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc-id
  target_type="ip"

}

resource "aws_security_group" "allow_http" {
  name        = "${var.app-name}-allow_http"
  description = "Allow http inbound traffic and all outbound traffic"
  vpc_id      = var.vpc-id

}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
