resource "aws_iam_role" "gitlab_runner_role" {
  name = "gitlab_runner_role"

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Service : "ec2.amazonaws.com",
        },
        Action : "sts:AssumeRole",
      },
    ],
  })
}

resource "aws_iam_instance_profile" "gitlab_runner_profile" {
  name = "gitlab_runner_profile"
  role = aws_iam_role.gitlab_runner_role.name
}

resource "aws_iam_role_policy_attachment" "admin_access" {
  role       = aws_iam_role.gitlab_runner_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
