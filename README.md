## Introduction

This README describes each sub-directory within this repository.

This repository in turn contains `Salt` snippets. These snippets show you how to do certain tasks and describe the logical workflows.

##Example 1

[1_reactor_state_get_command_output](https://github.com/DavidJohnGee/salt-junos/tree/master/1_reactor_state_get_command_output)

This directory contains a set of snippets to provide the following behaviour:

1.	Listen for an event using the reactor engine.
2.	Once the event has been matched, run the reactor file.
3.	The reactor file contains inline pillar data (which inserts "\_stamp" as the "jobid") and executes the state sls file.
4.	The state file executes a CLI command on the targeted minion and writes the output to a file.

This example contains all of the above to one event match and therefore one statefile execution. A CLI command is issued and the response is used directly without having to match on a separate event to record the returned data. 
