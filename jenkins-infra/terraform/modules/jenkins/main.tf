resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow access to Jenkins"
  vpc_id      = var.vpc_id  # Ensure you pass the VPC ID as a variable

  ingress {
    description = "Allow HTTP traffic on port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from anywhere (you can restrict this to your IP)
  }

  ingress {
    description = "Allow SSH traffic on port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from anywhere (you can restrict this to your IP)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-sg"
  }
}

resource "aws_instance" "jenkins" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.jenkins_sg.name]

  tags = {
    Name = "Jenkins"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y wget
    sudo dnf install java-17-amazon-corretto -y
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    sudo dnf install jenkins -y
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
  EOF

  # Other properties...
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}
