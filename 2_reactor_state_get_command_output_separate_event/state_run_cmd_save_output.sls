{%- set cmd = pillar.get('cmd') %}
{%- set filename = pillar.get('filename') %}
{%- set ret = salt.net.cli(cmd) %}
{%- set cli_out = ret['out'][cmd] %}
/home/davidgee/eventdata/{{ filename }}:
  file.append:
    - text:
      - {{ cli_out | quote }}
