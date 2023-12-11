#RESOURCE KEY PAIR ##

resource "aws_key_pair" "git_key" {
  key_name   = "gitkey"
  public_key = file("gitkey.pub")
  tags = {
    Name    = "${var.project_name}-${var.project_env}"
    Porject = var.project_name
    env     = var.project_env
    owner   = var.project_own
  }
}

##SECURITY GROUP ##

resource "aws_security_group" "http_access" {
  name        = "http-sg-${var.project_name}-${var.project_env}"
  description = "${var.project_name}-${var.project_env}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"

    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name    = "sg-http-${var.project_name}-${var.project_env}"
    project = var.project_name
    env     = var.project_env
    owner   = var.project_own
  }
}
###SECURITY GROUP REMOTE ACCESS ##

resource "aws_security_group" "ssh_access" {
  name        = "ssh-${var.project_name}-${var.project_env}"
  description = "${var.project_name}-${var.project_env}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "${var.project_name}-${var.project_env}-ssh-access"
    project = var.project_name
    env     = var.project_env
    owner   = var.project_own
  }
}
# Configure resource - EC2 instance
resource "aws_instance" "frontend" {

  ami                    = var.ami_id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.git_key.key_name
  vpc_security_group_ids = [aws_security_group.http_access.id, aws_security_group.ssh_access.id]
  user_data              = file("web.sh")
  tags = {
    Name    = "${var.project_name}-${var.project_env}"
    project = var.project_name
    env     = var.project_env
    owner   = var.project_own
  }

}
##RESOURCE ROUTE53##

resource "aws_route53_record" "webserver" {
  zone_id = data.aws_route53_zone.selected.id
  name    = "${var.hostname}.${var.hosted_zone_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.public_ip]
}
