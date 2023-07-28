# Creating External LoadBalancer
resource "aws_lb" "external-alb" {
  name               = "External-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.Web-sg.id]
  subnets            = [aws_subnet.public-subnet-1.id,aws_subnet.public-subnet-2.id]
}
resource "aws_lb_target_group" "target-elb" {
  name     = "ALB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.three-tier-app-vpc.id
}
resource "aws_lb_target_group_attachment" "attachment" {
    for_each = aws_instance.pub-instance
    target_group_arn = aws_lb_target_group.target-elb.arn
    port             = 80
    target_id        = each.value.id
        depends_on = [
            aws_instance.pub-instance
]
}

resource "aws_lb_listener" "external-elb" {
  load_balancer_arn = aws_lb.external-alb.arn
  port              = "80"
  protocol          = "HTTP"
default_action {
  type             = "forward"
  target_group_arn = aws_lb_target_group.target-elb.arn
}
}