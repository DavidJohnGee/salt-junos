React on some event:
  local.state.sls:
    - tgt: "vsrxnapalm"
    - kwarg:
        pillar:
          jobid: '{{ data["_stamp"] }}'
    - arg:
      - state_run_get_version_save_output
