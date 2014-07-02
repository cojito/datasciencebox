Vagrant.configure("2") do |config|
  config.vm.box = "trusty64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.network "forwarded_port", guest: 8888, host: 8888

  # For salt masterless, mount your file roots file root
  config.vm.synced_folder "salt/", "/srv"

  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
    salt.verbose = true
  end

  config.vm.provider :aws do |aws, override|
    override.vm.box = "dummy"
    override.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "~/.ssh/daniel_keypair.pem"

    aws.security_groups = ["open"]
    aws.keypair_name = "daniel_keypair"

    aws.access_key_id = "AKIAI5J7ALYW3FFYYC3Q"
    aws.secret_access_key = "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"

    aws.region = "us-east-1"
    aws.availability_zone = "us-east-1d"

    aws.instance_type = "m1.large"
    aws.ami = "ami-018c9568"  # ubuntu 14.04 LTS 64 bits

    aws.tags = {
      "Name" => "datasciencebox",
    }
  end
end
