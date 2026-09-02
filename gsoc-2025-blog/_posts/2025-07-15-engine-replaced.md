---
title: GSoC 2025 - A RoutingPy Wrapper Appears
date: 2025-07-15
---

Hey again! I’ve got a solid update: the project now includes a working wrapper for `routingpy`, and with it, a more flexible way to configure how routing is handled during VRP solving.

---

### Shifting Responsibility to the User

The key design decision here was to push the responsibility for routing engine configuration to the user. Rather than locking everything into a single backend like OSRM, the new interface allows users to select the routing engine and service that fits their workflow. That might mean spinning up a local OSRM Docker container, tapping into a cloud-hosted service, or using one of the other backends supported by `routingpy`.

This makes the routing engine more of a plug-in component, and it aligns well with the generalized goals of this project.

---

### What’s Working

The latest commit in my open PR includes a replaced `engine.py` module with this new logic. When tested locally, everything works: the solver runs, the VRP is solved, and the HTML map output is generated correctly.

One of the nice features added is the ability to pass a routing configuration dictionary directly into the `solve()` call. For example:

```python
m.solve(
    stop=pyvrp.stop.MaxRuntime(60),
    routing={"base_url": "http://localhost:5000", "engine": OSRM}
```
---

### Work in Progress

At the moment, I’ve only tested this with OSRM. While routingpy supports several backends, I haven’t yet verified compatibility with them. I’ve also yet to add a fallback to Euclidean distances when no network is provided. This was part of the old implementation and needs to be folded into the new structure.

---

### Next Steps
The accompanying notebook currently demonstrates the VRP use case, but it’s pretty light on explanation around the new API. My next step is to expand that notebook into something more like a user guide. It will cover how to specify different routing backends, what kind of data you need to provide, how to interpret the outputs, and where things might go wrong.

More soon!

—Dylan
