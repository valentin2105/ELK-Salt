openjdk-7-jre:
  pkg:
    - installed

elasticsearch-ppa:
  pkgrepo.managed:
    - humanname: Elasticsearch
    - name: deb http://packages.elasticsearch.org/elasticsearch/{{ pillar['elasticsearch']['version'] }}/debian stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - gpgcheck: 1
    - key_url: https://packages.elasticsearch.org/GPG-KEY-elasticsearch

elasticsearch:
  pkg:
    - installed
    - requiere: elasticsearch-ppa
  service.running:
    - enable: True
    - reload: True
    - watch:
      - pkg: elasticsearch

logstash-ppa:
  pkgrepo.managed:
    - humanname: Logstash
    - name: deb http://packages.elasticsearch.org/logstash/{{ pillar['logstash']['version'] }}/debian stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/logstash.list
    - gpgcheck: 1
    - key_url: https://packages.elasticsearch.org/GPG-KEY-elasticsearch

logstash:
  pkg:
    - installed
    - requiere: logstash-ppa
  service.running:
    - enable: True
    - reload: True
    - init_delay: 10
    - watch:
      - pkg: logstash

/etc/logstash/logstash.conf:
  file:
    - managed
    - source: salt://elk/logstash.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja

kibana-base:
  archive.extracted:
    - name: /opt/
    - template: jinja
    - source: https://download.elastic.co/kibana/kibana/{{ pillar['kibana']['version'] }}.tar.gz
    - source_hash: {{ pillar['kibana']['hash'] }}
    - archive_format: tar
    - if_missing: /opt/{{ pillar['kibana']['version'] }}/

kibana4:
  service.running:
    - enable: True
    - reload: True
    - init_delay: 10
    - watch:
      - archive: kibana-base

/etc/init.d/kibana4:
  file:
    - managed
    - template: jinja
    - source: salt://elk/kibana4-init
    - user: root
    - group: root
    - mode: 750

/etc/systemd/system/kibana4.service:
  file:
    - managed
    - template: jinja
    - source: salt://elk/kibana4.service
    - user: root
    - group: root
    - mode: 644