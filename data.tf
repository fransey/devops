data "aws_availability_zones" "available" {
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.sscp_vpc_stg.id]
  }
  tags = {
    Tier = "public subnet"
  }
}

data "aws_ami_ids" "amazon_linux_2" {
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.sscp_vpc_stg.id]
  }
  tags = {
    Tier = "private subnet"
  }

}

output "efs-file-system-dns-name" {
  value = aws_efs_file_system.efs.dns_name
}

data "template_file" "efs_mount" {

  template = <<EOF

  #!/bin/bash
  mkdir -p /var/www/html
  # Making Mount Permanent
  echo ${aws_efs_file_system.efs.dns_name}:/ /var/www/html nfs4 defaults,_netdev 0 0  | sudo cat >> /etc/fstab 
  #Mount
  sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/  /var/www/html
  wait 10
  mount -a

  EOF

}

data "template_file" "bastion_boot" {

  template = <<EOF

  #!/bin/bash
  mkdir -p /var/www/html 
  ### vsftp server for sftp access
  yum -y install vsftpd
  ## Hardening to limit anonymous user access
  sed -i 's/anonymous_enable=YES/anonymous_enable=NO/g' /etc/vsftpd/vsftpd.conf
  echo "chroot_local_user=YES" >> /etc/vsftpd/vsftpd.conf
  echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf
  echo "pasv_enable=Yes" >> /etc/vsftpd/vsftpd.conf
  echo "pasv_min_port=40000" >> /etc/vsftpd/vsftpd.conf
  echo "pasv_max_port=40100" >> /etc/vsftpd/vsftpd.conf
  systemctl restart vsftpd.service
  groupadd sftp
  useradd -m ssc-sftp -d /var/www/html -s /sbin/nologin -g sftp
  sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
  sed -e '/Subsystem / s/^#*/#/' -i /etc/ssh/sshd_config 
  echo "Subsystem sftp internal-sftp" >> /etc/ssh/sshd_config
  echo "Match group sftp" >> /etc/ssh/sshd_config
  echo "ChrootDirectory /var/www/html" >> /etc/ssh/sshd_config
  echo "X11Forwarding no" >> /etc/ssh/sshd_config
  echo "AllowTcpForwarding no" >> /etc/ssh/sshd_config
  echo "ForceCommand internal-sftp" >> /etc/ssh/sshd_config
  chown root /var/www/html
  chmod go-w /var/www/html
  mkdir /var/www/html/data
  chown ssc-sftp:sftp /var/www/html/data
  chmod ug+rwX /var/www/html/data
  systemctl restart sshd

  #Mount
  sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/  /var/www/html
  # Making Mount Permanent
  echo ${aws_efs_file_system.efs.dns_name}:/ /var/www/html nfs4 defaults,_netdev 0 0  | sudo cat >> /etc/fstab 
  wait 20
  mount -a

  EOF

}
