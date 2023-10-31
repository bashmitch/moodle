resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "google_compute_instance" "moodle" {
  name         = var.instance_name
  machine_type = "e2-medium"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"
  }

  metadata = {
    ssh-keys = "mitchkurtz94:${tls_private_key.ssh_key.public_key_openssh}"
  }
}

resource "google_compute_firewall" "http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "https" {
  name    = "allow-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "aws_security_group" "my_security_group" {
  name        = "moodle-security-group"
  description = "My security group"
  vpc_id      = "vpc-0b1400366344602f6" # Replace with your VPC ID

  // Define inbound and outbound rules here
  // For example, to allow SSH traffic, you can use:

  // Ingress rule for SSH (Port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # This allows SSH traffic from anywhere; consider tightening this to a specific IP range for security.
  }
}

resource "aws_instance" "moodle" {
  ami           = "ami-053b0d53c279acc90" # Specify the desired Amazon Machine Image (AMI)
  instance_type = "t2.micro"              # Specify the instance type
  key_name      = "aws-ssh-key"

  tags = {
    Name = "moodle-instance"
  }
}
