include:
  - python

luigi:
  conda.installed:
    - conda: /home/ubuntu/anaconda/bin/conda
    - pip: /home/ubuntu/anaconda/bin/pip
    - user: ubuntu
    - require:
      - conda: base

/etc/luigi/client.cfg:
  file.managed:
    - template: jinja
    - user: ubuntu
    - source: salt://luigi/conf.cfg
    - mode: 0777
    - require:
      - user: ubuntu
