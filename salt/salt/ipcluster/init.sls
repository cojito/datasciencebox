include:
  - ipnotebook

# Bootstrap salt-master, salt-cloud and its dependencies
salt-master:
  pkg.installed

salt-cloud:
  pkg.installed

python-pip:
  pkg.installed

apache-libcloud:
  pip.installed:
    - upgrade: True
    - require:
      - pkg: python-pip

requests:
  pip.installed:
    - upgrade: True
    - require:
      - pkg: python-pip

# ipcontroller
ipcontroller:
  background.running:
    - name: "/home/ubuntu/anaconda/bin/ipcontroller --ip='*'"
    - pid: /home/ubuntu/run/ipcontroller.pid
    - stdout: /home/ubuntu/log/ipcontroller.out
    - stderr: /home/ubuntu/log/ipcontroller.err
    - cwd: /home/ubuntu/notebooks
    - force: True
    - user: ubuntu
    - require:
      - conda: ipython-notebook

# Wait for ipcontroller-engine.json file to be ready
sleep:
  cmd.run:
    - name: "sleep 3"
    - require:
      - background: ipcontroller

/srv/salt/ipcluster/ipcontroller-engine.json:
  file.copy:
    - source: /home/ubuntu/.ipython/profile_default/security/ipcontroller-engine.json
    - user: ubuntu
    - require:
      - cmd: sleep

# Salt cloud files
/etc/salt/cloud.providers:
  file.managed:
    - source: salt://ipcluster/cloud.providers
    - user: root
    - template: jinja

/etc/salt/cloud.profiles:
  file.managed:
    - source: salt://ipcluster/cloud.profiles
    - user: root
    - template: jinja

/vagrant/ipcluster.pem:
  file.managed:
    - mode: 400
