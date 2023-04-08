###################################
## Virtual Machine Module - Main ##
###################################

# Create Elastic IP for the EC2 instance
resource "aws_eip" "linux-eip" {
  vpc = true
  tags = {
    Name = "${var.environment_slug}-linux-eip"

  }
}

# Security Group
resource "aws_security_group" "webserver_sg" {
  name        = "${var.environment_slug}-webserver-sg"
  description = "WebServer DMZ"
  vpc_id      = aws_vpc.vpc.id
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

  ingress {
    description = "server 2"
    from_port   = 8767
    to_port     = 8767
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "server 1"
    from_port   = 8766
    to_port     = 8766
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "server 1"
    from_port   = 16261
    to_port     = 16261
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "server 1"
    from_port   = 16261
    to_port     = 16261
    protocol    = "udp"
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

# Associate Elastic IP to Linux Server
resource "aws_eip_association" "linux-eip-association" {
  instance_id   = aws_instance.webserver.id
  allocation_id = aws_eip.linux-eip.id
}

# EC2 instance
resource "aws_instance" "webserver" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  # user_data     = file("./files/aws-user-data.sh")
  user_data     = data.template_file.user_data.rendered
  key_name      = var.ssh_key_name
  monitoring    = true

  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.webserver_sg.id]
  associate_public_ip_address = var.linux_associate_public_ip_address
  source_dest_check           = false

  # root disk
  root_block_device {
    volume_size           = var.linux_root_volume_size
    volume_type           = var.linux_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }
}

data "template_file" "user_data" {
  template = file(var.cloud_init_filepath)
}
# resource "aws_ec2_instance_state" "webserver" {
#   instance_id = aws_instance.webserver.id
#   state       = "stopped"
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