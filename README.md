# SqueroBase.jl

The Julia session layer of Squero Studio MX for
[Paperboat](https://github.com/paperboatlab/paperboat). It records session events (`clear`, `clc`),
optimization problem specifications (`optimize`) and simulation run requests (`simulate`); it does
not plot, solve or integrate.

**Docs:** <https://paperboatlab.github.io/apps/squero-studio-mx/> and [`schema/`](schema/)

## Use

Loaded automatically inside the Squero Studio MX Julia kernel alongside
[`SqueroPlot.jl`](../SqueroPlot.jl):

```julia
using SqueroBase

clear()
optimize(problem)           # LP/QP/NLP specification for Paperboat's optimization toolkit
simulate(graph; duration=5) # graph.run request for a Paperboat backend
```

## Check

```sh
julia --project=. -e 'using Pkg; Pkg.test()'
```

## CI

[![ci](https://github.com/paperboatlab/squero-mx-base/actions/workflows/ci.yml/badge.svg?branch=dev)](https://github.com/paperboatlab/squero-mx-base/actions/workflows/ci.yml?query=branch%3Adev) runs the Julia package test suite and schema fixture checks.

## Licence

Mozilla Public License Version 2.0 (see [LICENSE](LICENSE)).
