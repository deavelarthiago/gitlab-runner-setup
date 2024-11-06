resource "aws_instance" "gitlab_runner" {
  instance_type          = var.instance_type
  ami                    = var.ami
  key_name               = var.key_name
  subnet_id              = tolist(data.aws_subnets.private.ids)[0]
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile   = aws_iam_instance_profile.gitlab_runner_profile.name

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y curl git
              sudo yum install docker -y
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ec2-user
              curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh | sudo bash
              sudo yum install -y gitlab-runner
              sudo gitlab-runner register \
                --non-interactive \
                --url "https://gitlab.com/" \
                --registration-token "<insert herer your gitlab runner token>" \
                --executor "docker" \
                --docker-image "docker:stable" \
                --description "pipelines-runner" \
                --tag-list "aws, docker" \
                --run-untagged="true" \
                --locked="false"
              sleep 10
              CONFIG="/etc/gitlab-runner/config.toml"
              sed -i 's/concurrent = [0-9]*/concurrent = 1/' $CONFIG
              sed -i 's/check_interval = [0-9]*/check_interval = 0/' $CONFIG
              sed -i '/\\[session_server\\]/a\\  session_timeout = 1800' $CONFIG
              sed -i 's|volumes = \\[.*\\]|volumes = ["/cache"]|' $CONFIG
              sed -i 's/disable_cache = .*/disable_cache = true/' $CONFIG
              sudo gitlab-runner restart
              EOF

  tags = {
    Name = var.instance_name
  }

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }
}
