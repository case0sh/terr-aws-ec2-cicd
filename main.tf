# Security Group
resource "aws_security_group" "webserver_sg" {
  name        = "${var.environment_slug}-webserver-sg"
  description = "WebServer DMZ"
  tags = {
    Name = "${var.environment_slug}-webserver-sg"
  }

  ingress {
    description = "HTTP (80)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH (22)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "webserver" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  user_data     = data.cloudinit_config.server_config.rendered #file("aws-user-data.sh")
  key_name      = "new"                                        #aws_key_pair.ansible_keypair.key_name
  monitoring    = true
  associate_public_ip_address = true

  # root disk
  root_block_device {
    volume_size           = var.linux_root_volume_size
    volume_type           = var.linux_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }


  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  tags = {
    Name = "${var.environment_slug}-webserver"
  }
}

data "cloudinit_config" "server_config" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content      = file("${path.module}/server.yml")
  }
}

# resource "aws_key_pair" "ansible_keypair" {
#   key_name   = "${var.environment_slug}-ansible-key"
#   public_key = file(var.ssh_pub_key_file)
# }

# Get latest Ubuntu Linux 
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}