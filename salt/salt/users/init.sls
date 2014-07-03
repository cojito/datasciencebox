ubuntu:
  user.present:
    - shell: /bin/zsh

# Copy the vagrant insecure key if running in local VM
insecure-key:
  cmd.run:
      - name: "mkdir .ssh && cd .ssh && wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -O authorized_keys -q"
      - cwd: /home/ubuntu
      - user: ubuntu
      - onlyif: "test -d /home/vagrant && test ! -e /home/ubuntu/.ssh/authorized_keys"
      - require:
        - user: ubuntu

pkgs:
  pkg.installed:
    - pkgs:
      - zsh
      - git

oh-my-zsh:
  git.latest:
    - name: git://github.com/robbyrussell/oh-my-zsh.git
    - target: /home/ubuntu/.oh-my-zsh
    - user: ubuntu
    - require:
      - pkg: pkgs

dot_zshrc:
  file.copy:
    - name: /home/ubuntu/.zshrc
    - source: /home/ubuntu/.oh-my-zsh/templates/zshrc.zsh-template
    - user: ubuntu
    - require:
      - git: oh-my-zsh
