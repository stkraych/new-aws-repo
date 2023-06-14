

resource "aws_autoscaling_group" "linux_autoscalling_group" {
  desired_capacity    = 2
  max_size            = 4
  min_size            = 2
  vpc_zone_identifier = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  target_group_arns   = [aws_lb_target_group.alb_target.arn]
  launch_template {
    id      = aws_launch_template.linux_template.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "auto-scaled-instances"
    propagate_at_launch = true
  }

}


resource "aws_autoscaling_policy" "aws_autoscaling_policy" {
  name                   = "the-auto-policy"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.linux_autoscalling_group.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 4
}

