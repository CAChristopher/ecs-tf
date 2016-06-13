resource "aws_iam_role" "ecs" {
  name               = "ecs-ecs-role"
  assume_role_policy = "${file("policies/assume_role.json")}"
}

resource "aws_iam_policy_attachment" "ecs-role" {
  name       = "ecs-policy"
  roles      = ["${aws_iam_role.ecs.name}"]
  policy_arn = "${var.ecs_role_arn}"
}

resource "aws_iam_policy_attachment" "s3-role" {
  name       = "s3-policy"
  roles      = ["${aws_iam_role.ecs.name}"]
  policy_arn = "${var.s3_role_arn}"
}

resource "aws_iam_instance_profile" "ecs" {
  name  = "ecs-ecs-profile"
  roles = ["${aws_iam_role.ecs.name}"]
}