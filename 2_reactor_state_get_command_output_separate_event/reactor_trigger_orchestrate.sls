Orchestrate in some reaction to an event:
  runner.state.orchestrate:
    - args:
      - mods: orchestrate.orch_create_file_run_cmd_save_output
      - pillar:
          minion_id: '{{ data["id"] }}'
          proxy_id: '{{ data["data"]["host"] }}'
          filename: '{{ data["_stamp"] }}'
