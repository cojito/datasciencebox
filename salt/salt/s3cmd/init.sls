include:
  - users

s3cmd-install:
  pkg.installed:
    - names:
      - s3cmd

s3cmd:
  file.managed:
    - name: /home/ubuntu/.s3cfg
    - source: salt://s3cmd/s3cfg.template
    - template: jinja
    - user: ubuntu
    - mode: 0600
    - require:
      - user: ubuntu
      - pkg: s3cmd-install
