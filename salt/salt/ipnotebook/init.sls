include:
  - python

/home/ubuntu/notebooks:
  file.directory:
    - user: ubuntu
    - makedirs: True

ipython-notebook:
  conda.installed:
    - conda: /home/ubuntu/anaconda/bin/conda
    - pip: /home/ubuntu/anaconda/bin/pip
    - user: ubuntu
    - require:
      - conda: base

nbserver:
  background.running:
    - name: "/home/ubuntu/anaconda/bin/ipython notebook --ip=0.0.0.0 --port=8888 --no-browser"
    - pid: /home/ubuntu/run/nbserver.pid
    - stdout: /home/ubuntu/log/nbserver.out
    - stderr: /home/ubuntu/log/nbserver.err
    - cwd: /home/ubuntu/notebooks
    - force: True
    - user: ubuntu
    - require:
      - conda: ipython-notebook
