include:
  - base
  - python

openmpi-bin:
  pkg.installed

pyzmq:
  conda.installed:
    - conda: /home/ubuntu/anaconda/bin/conda
    - pip: /home/ubuntu/anaconda/bin/pip
    - user: ubuntu
    - require:
      - conda: base

/home/ubuntu/.ipython/profile_default/security/ipcontroller-engine.json:
  file.managed:
    - source: salt://ipcluster/ipcontroller-engine.json
    - user: ubuntu

ipengine:
  background.running:
    - name: "/usr/bin/mpiexec -n {{ pillar['ipcluster']['nengines'] }} /home/ubuntu/anaconda/bin/ipengine"
    - pid: /home/ubuntu/run/ipengine.pid
    - stdout: /home/ubuntu/log/ipengine.out
    - stderr: /home/ubuntu/log/ipengine.err
    - cwd: /home/ubuntu/
    - force: True
    - user: ubuntu
    - require:
      - conda: base
      - pkg: openmpi-bin
