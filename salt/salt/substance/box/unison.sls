
substance-bin-unison:
  file.managed:
    - name: /usr/local/bin/unison
    - source: salt://substance/box/bin/unison
    - user: root
    - group: root
    - mode: 655

substance-bin-unison-fsmonitor:
  file.managed:
    - name: /usr/local/bin/unison-fsmonitor
    - source: salt://substance/box/bin/unison-fsmonitor
    - user: root
    - group: root
    - mode: 655