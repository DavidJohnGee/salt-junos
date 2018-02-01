## Example 1

This example directory contains the Salt configuration to implement this logic:

1.	Listen for an event using the reactor engine.
2.	Once the event has been matched, run the reactor file.
3.	The reactor file contains inline pillar data (which inserts "\_stamp" as the "jobid") and executes the state sls file.
4.	The state file executes a CLI command on the targeted minion and writes the output to a file.

Logic is based on the `salt-napalm` modules and `napalm-logs` syslog engine for event matching.

For this example, you will require a file structure which looks like the following:

```bash
/srv/salt/<state_files>
/srv/reactor/<reactor_files>
```

Your master configuration file will need to have this `file_roots` section:

```bash
file_roots:
  base:
    - /srv/salt
```

Therefore, salt orchestrate or state files can be referenced properly.


__master__

Contains the relevant `reactor` section to link an event to a reactor file. In this case, the `reactor_run_get_version.sls` file.

This `local reactor` is called when the event is hit.

__reactor_run_get_version.sls__

Contains the reactor logic and passes through inline pillar data. This reactor triggers a targeted `state.sls` apply.

__state_run_get_version_save_output.sls__

Contains the state logic required to issue a CLI command and save the file to the minion.



