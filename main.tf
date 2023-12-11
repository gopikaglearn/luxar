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
