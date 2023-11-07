resource "aws_launch_template" "app" {
  name_prefix   = "my-asg-instance"
  image_id      = data.aws_ami.amzlinux.id
  instance_type =   "t2.micro"

  vpc_security_group_ids = [module.private_security_group.security_group_id]

  user_data = filebase64("${path.module}/app1-install.sh")

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "app" {
  name_prefix          = "app-asg"
  vpc_zone_identifier  = module.vpc.private_subnets
  health_check_type         = "ELB"
  target_group_arns    = [aws_alb_target_group.my_tg.arn]

  min_size         = 1
  max_size         = 4
  desired_capacity = 2

   launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.app.id
  lb_target_group_arn    = aws_alb_target_group.my_tg.arn
}