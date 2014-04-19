
Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

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
    override.ssh.private_key_path = "~/.ssh/_keypair.pem"

    aws.security_groups = ["open"]
    aws.keypair_name = "_keypair"

    aws.access_key_id = ""
    aws.secret_access_key = ""

    aws.region = "us-east-1"
    aws.availability_zone = "us-east-1d"

    aws.instance_type = "m1.large"
    aws.ami = "ami-59a4a230"  # ubuntu 12.04.3 LTS 64 bits

    aws.tags = {
      "Name" => "datasciencebox",
    }
  end
end
