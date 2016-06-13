provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_ecs_cluster" "ecs" {
  name = "cluster"
}

resource "aws_launch_configuration" "ecs" {
  name_prefix          = "ecs-${aws_ecs_cluster.ecs.name}-"
  image_id             = "${lookup(var.ami, var.aws_region)}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs.id}"
  key_name             = "${lookup(var.key_name, var.aws_region)}"
  security_groups      = ["${split(",", lookup(var.security_group_ids, var.aws_region))}"]
  user_data            = "${file("./cloud-config/cloud-init.yml")}"

  root_block_device = {
    volume_size = "${var.root_size}"
  }

  lifecycle {
      create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "ecs" {
  availability_zones        = ["${split(",", lookup(var.availability_zones, var.aws_region))}"]
  vpc_zone_identifier       = ["${split(",", lookup(var.subnet_ids, var.aws_region))}"]
  name                      = "ECS ${aws_ecs_cluster.ecs.name}"
  min_size                  = "${var.min_size}"
  max_size                  = "${var.max_size}"
  desired_capacity          = "${var.desired_capacity}"
  health_check_type         = "EC2"
  launch_configuration      = "${aws_launch_configuration.ecs.name}"
  health_check_grace_period = "${var.health_check_grace_period}"

  tag {
    key                     = "Name"
    value                   = "ECS ${aws_ecs_cluster.ecs.name}"
    propagate_at_launch     = true
  }
  tag {
    key                 = "billingcode"
    value               = "dino"
    propagate_at_launch = true
  }

  lifecycle {
      create_before_destroy = true
    }
}
