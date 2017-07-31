# -*- mode: ruby -*-
# vi: set ft=ruby :

#######################################
#                                     #
# Vagrantfile for Predikto dev.       #
# Leverages Docker.                   #
#                                     #
#######################################

Vagrant.require_version ">= 1.8.0"
VAGRANTFILE_API_VERSION = "2"

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'
DOCKER_HOST_VAGRANTFILE = './HostVagrantFile'

time = Time.new
timestamp = time.strftime("%Y%m%d")

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.define "show_ip_dev" do |show_ip_dev|
        show_ip_dev.vm.provider "docker" do |docker|
            docker.build_dir = "."

            docker.build_args = ["-t=show_ip_dev", \
                            "--build-arg", "user=#{ENV['USER']}"]
            docker.name = "show_ip_dev" + timestamp
            docker.remains_running = true

            # Well, actually does have SSH but vagrant doesn't manage it.
            docker.has_ssh = false

            # Development instance will be accessible at 127.0.0.1:4222 via ssh.
            docker.ports = ['4222:22']

            # Vagrant manages the docker host, a VM run to contain the
            # docker instance that will host the development container.
            # This insulates the development instance from differences
            # in the host OS, be it OS X, Linux, Windows, etc.
            docker.vagrant_vagrantfile = "#{DOCKER_HOST_VAGRANTFILE}"
        end
    end
end
