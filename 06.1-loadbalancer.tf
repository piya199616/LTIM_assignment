
resource "aws_alb" "alb" {
  name            = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [module.lb_security_group.security_group_id]
  subnets         = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
 #subnets = [module.vpc.public_subnets]

 
}

#Listener

resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.my_tg.arn}"
    type             = "forward"
  }
}

#target group

resource "aws_alb_target_group" "my_tg" {
  name     = "my-alb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  stickiness {
    type = "lb_cookie"
  }
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/app1/index.html"
    port = 80
    protocol  = "HTTP"
  }
}

#Target group attachments




/*
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.1.0"

  name = var.name
  load_balancer_type = "application"
  vpc_id = module.vpc.vpc_id
  subnets = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]


  # Security Group
  
  security_groups = [module.lb_security_group.security_group_id ]
 listeners = {

    ex-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }

 }
  
 target_groups = {
    app1_instance = {
      name_prefix                       = "app1-"
      backend_protocol                  = "HTTP"
      backend_port                      = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false
 
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
 
      protocol_version = "HTTP1"

       
     target_id = tostring([for instance in module.private_ec2_instance : instance.id ])
     
     port     =    80
      
    }
 }


}

resource "aws_lb_target_group_attachment" "test" {
for_each = {
   
   for i , instance in module.private_ec2_instance[*] : i => instance.id
  
  }

 #target_id        = each.value.id
 
  target_group_arn = aws_alb_target_group.group.arn
  port             = 80
}
 


  targets = {
        my_app1_vm1 = {
          target_id = module.ec2_private[0].id
          port      = 80
        },
        my_app1_vm2 = {
          target_id = module.ec2_private[1].id
          port      = 80
        }        
      }


      targets = [
        {
          target_id = module.private_ec2_instance.id[0]
          port = 80
        },
        {
          target_id = module.private_ec2_instance.id[1]
          port = 80
        }
      ]



      http_listeners =  {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
      */