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
