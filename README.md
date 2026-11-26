# SqueroBase.jl

The Julia session layer of Squero Studio MX for
[Paperboat](https://github.com/paperboatlab/paperboat). It records session events (`clear`, `clc`) and
simulation run requests (`simulate`); it does not plot, solve or integrate. For optimization use
[CasADiNative.jl](https://github.com/casadi/CasADiNative.jl).

**Docs:** <https://paperboatlab.org/apps/squero-studio-mx/>

## Use

Loaded automatically inside the Squero Studio MX Julia kernel alongside
[`SqueroPlot.jl`](../SqueroPlot.jl):

```julia
using SqueroBase

clear()
simulate(graph; duration=5) # graph.run request for a Paperboat station
```

## Check

```sh
julia --project=. -e 'using Pkg; Pkg.test()'
```

## CI

[![ci](https://github.com/paperboatlab/squero-mx-base/actions/workflows/ci.yml/badge.svg?branch=dev)](https://github.com/paperboatlab/squero-mx-base/actions/workflows/ci.yml?query=branch%3Adev) runs the Julia package test suite.

## Licence

Mozilla Public License Version 2.0 (see [LICENSE](LICENSE)).
