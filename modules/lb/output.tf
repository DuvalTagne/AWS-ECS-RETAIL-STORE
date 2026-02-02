output "lb-arn" {
  value = aws_lb.lb_store.arn
}
output "lb-tg-arn" {
  value = aws_lb_target_group.lb_store_tg.arn
}

output "sg_id" {
  value = aws_security_group.allow_http.id
}