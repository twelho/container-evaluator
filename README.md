# Container Evaluator

Container support evaluation tool, made for HPC/supercomputer environments. When dispatched as a workload, gathers node information, configuration and environment, and attempts to evaluate support for running various (rootless) container runtimes. Optimized for [CSC's](https://csc.fi/) supercomputing platforms.

## Usage

```shell
export ACCOUNT=project_123 # Enter your Slurm account here
RUN_TESTS= ./run.sh # Set RUN_TESTS= to also run tests with container runtimes
```

Alternatively, to just run on the login node:

```shell
export ACCOUNT=project_123 # Enter your Slurm account here (optional)
RUN_TESTS= ./evaluator.sh # Set RUN_TESTS= to also run tests with container runtimes
```

## Authors

- Dennis Marttinen ([@twelho](https://github.com/twelho))

## License

[MIT](https://spdx.org/licenses/MIT.html) ([LICENSE](LICENSE))
