{%- set minion_id = pillar.get('minion_id') %}
{%- set proxy_id = pillar.get('proxy_id') %}
{%- set filename = pillar.get('filename') %}
{%- set cmd = "show version" %}

{%- if proxy_id == 'vsrx01' %}
{% set proxy_id = "vsrxnapalm" %}
{% endif %}

create_file:
  salt.function:
    - name: file.touch
    - tgt: '{{ minion_id }}'
    - arg:
      - '/home/davidgee/eventdata/{{ filename }}'

write_file:
  salt.function:
    - name: file.append
    - tgt: '{{ minion_id }}'
    - arg:
      - 'home/davidgee/eventdata/{{ filename }}'
      - "<Test-Data>"

commit_state:
  salt.state:
     - name: "arbitrary-command-run"
     - tgt: "{{ proxy_id }}"
     - sls:
       - state_run_cmd_save_output
     - pillar:
         cmd: "{{ cmd }}"
         filename: "{{ filename }}"
