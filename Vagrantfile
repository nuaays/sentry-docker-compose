VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "sentry"
    config.vm.hostname = config.vm.box

    config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    config.vm.provision :shell, :path => "vagrant/bootstrap.sh"

    config.vm.provision :shell, inline: "service docker restart", run: "always"

    config.vm.box_check_update = false

    config.vm.network "private_network", ip: "192.168.123.45"

    config.vm.synced_folder ".", "/vagrant", type: 'nfs'

    config.vm.provider "virtualbox" do |vb|
        vb.name = config.vm.hostname
        vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
        vb.customize ["modifyvm", :id, "--memory", "2048"]
        vb.customize ["modifyvm", :id, "--cpus", "3"]
    end
end
