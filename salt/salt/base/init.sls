build-essential:
  pkg.installed

/home/ubuntu/run:
  file.directory:
    - user: ubuntu
    - makedirs: True

/home/ubuntu/log:
  file.directory:
    - user: ubuntu
    - makedirs: True
