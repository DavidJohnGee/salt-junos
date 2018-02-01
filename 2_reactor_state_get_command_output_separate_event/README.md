## Example 2

This example directory contains the Salt configuration to implement this logic:

1.	Listen for an event using the reactor engine.
2.	Once the event has been matched, run the orchestrator file.
3.	The reactor file sets inline pillar data from the data the reactor has at the time of rednering and triggers the orchestrate runner.
4.	The orchestrate runner does a number of sub tasks: Create file -> Insert test data in to file -> Runs a single Salt sls file state apply.
5.	The single Salt state apply runs the CLI command on the proxy-minion and appends the data in to the text file on the minion.

Logic is based on the `salt-napalm` modules and `napalm-logs` syslog engine for event matching.

For this example, you will require a file structure which looks like the following:

```bash
/srv/salt/orchestrate/<orch_files>
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

__reactor_trigger_orchestrate.sls__

Contains the reactor logic and passes through inline pillar data. This reactor triggers an orchestrate runner instance.

__orch_create_file_run_cmd_save_output.sls__

This orchestration sls retrieves the pillar data that was passed in, creates a text file, writes test data to the text file and runs a single targeted state apply.

__state_run_cmd_save_output.sls__

This single state file runs a CLI command on the targeted node and inserts the return data in to the previously created file.

__Output example from successful run___ 

```bash
Salt.home_master:
----------
          ID: create_file
    Function: salt.function
        Name: file.touch
      Result: True
     Comment: Function ran successfully. Function file.touch ran on minion1.
     Started: 16:18:36.755072
    Duration: 365.376 ms
     Changes:
              minion1:
                  True
----------
          ID: write_file
    Function: salt.function
        Name: file.append
      Result: True
     Comment: Function ran successfully. Function file.append ran on minion1.
     Started: 16:18:37.121003
    Duration: 302.263 ms
     Changes:
              minion1:
                  Wrote 1 lines to "home/davidgee/eventdata/2018-02-01T16:18:34.382879"
----------
          ID: commit_state
    Function: salt.state
        Name: arbitrary-command-run
      Result: True
     Comment: States ran successfully. Updating vsrxnapalm.
     Started: 16:18:37.423505
    Duration: 3454.446 ms
     Changes:
              vsrxnapalm:
              ----------
                        ID: /home/davidgee/eventdata/2018-02-01T16:18:34.382879
                  Function: file.append
                    Result: True
                   Comment: Appended 1 lines
                   Started: 16:18:40.762149
                  Duration: 4.138 ms
                   Changes:
                            ----------
                            diff:
                                ---

                                +++

                                @@ -1 +1,2 @@

                                 <Test-Data>
                                + Hostname: vsrx01 Model: vsrx Junos: 17.3R1.10 JUNOS Software Release [17.3R1.10]

              Summary for vsrxnapalm
              ------------
              Succeeded: 1 (changed=1)
              Failed:    0
              ------------
              Total states run:     1
              Total run time:   4.138 ms

Summary for Salt.home_master
------------
Succeeded: 3 (changed=3)
Failed:    0
------------
Total states run:     3
Total run time:   4.122 s
```


