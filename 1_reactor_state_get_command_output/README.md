-rw-rw-r-- 1 davidgee davidgee  274 Feb  1 13:16 master
-rw-rw-r-- 1 davidgee davidgee  186 Feb  1 13:18 reactor_run_get_version.sls
-rw-rw-r-- 1 davidgee davidgee  584 Feb  1 13:21 state_run_get_version_save_output.sls


## Example 1 Readme

This example directory contains three files and this README file.

__master__

Contains the relevant `reactor` section to link an event to a reactor file. In this case, the `reactor_run_get_version.sls` file.

This `local reactor` is called when the event is hit.

__reactor_run_get_version.sls__

Contains the reactor logic and passes through inline pillar data. This reactor triggers a targeted `state.sls` apply.

__state_run_get_version_save_output.sls__

Contains the state logic required to issue a CLI command and save the file to the master.



