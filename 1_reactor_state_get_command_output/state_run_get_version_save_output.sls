# Set the cmd to 'show version'. This command could also be passed via pillar data
{%- set cmd = 'show version' %}
# Issue command and set ret to the returned data
{%- set ret = salt.net.cli(cmd) %}
# cli_out now represents the actual data returned
{%- set cli_out = ret['out'][cmd] %}
# Only three dictionaries are available here, 'out', 'result' and 'comment'.
{%- set jobid = salt['pillar.get']('jid', 'bob') %}
# Here we create a file with id of 'jobid'
/home/davidgee/{{ jobid }}.txt:
  file.managed:
    # Dump out the data with quotations
    - contents: {{ cli_out | quote }}
