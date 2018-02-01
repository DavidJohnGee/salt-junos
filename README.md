## Introduction

This repository contains some interesting tidbits of information on Salt and networking.

Each example will state what modules it uses, such as `napalm` or `junos`. 


## Example 1

[1_reactor_state_get_command_output](https://github.com/DavidJohnGee/salt-junos/tree/master/1_reactor_state_get_command_output)

This directory contains a set of snippets to provide the following behaviour:

1.	Listen for an event using the reactor engine.
2.	Once the event has been matched, run the reactor file.
3.	The reactor file contains inline pillar data (which inserts "\_stamp" as the "jobid") and executes the state sls file.
4.	The state file executes a CLI command on the targeted minion and writes the output to a file.

This example can be triggered from a single tag event and does not require multiple event matching to issue an RPC and collect the data. 

In essence, a CLI command is issued and the response is used directly without having to match on a separate event to record the returned data. 

```bash
Modules: napalm (net.cli), napalm-logs
```

## Example 2

[2_reactor_state_get_command_output_separate_event](https://github.com/DavidJohnGee/salt-junos/tree/master/2_reactor_state_get_command_output_separate_event)

This directory contains a set of snippets to provide the following behaviour:

1.	Listen for an event using the reactor engine.
2.	Once the event has been matched, run the orchestrator file.
3.	The reactor file sets inline pillar data from the data the reactor has at the time of rednering and triggers the orchestrate runner.
4.	The orchestrate runner does a number of sub tasks: Create file -> Insert test data in to file -> Runs a single Salt sls file state apply.
5.	The single Salt state apply runs the CLI command on the proxy-minion and appends the data in to the text file on the minion.

This example can be triggered from a single tag event and does not require multiple event matching to issue an RPC and collect the data. 

In essence, from a single event we can kick off an orchestration of tasks which runs on the master. We can apply states to minions and proxy-minions and call functions from this orchestration runner.

```bash
Modues: napalm (net.cli), napalm-logs
```

