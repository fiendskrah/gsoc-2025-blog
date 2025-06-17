---
title: GSoC 2025 - Replicating the Guinness Toy Example
date: 2025-06-17
---

Hey again! In this post, I'll describe how I replicated the [Guinness delivery problem](https://gist.github.com/ljwolf/e5927ab8c859ed477f496329c1ce19fc#file-guinness-py) mentioned in the previous post, and outline how this helps set the direction for the next stage of the project.

---

### A Better Understanding

This past week has been about building a clearer conceptual understanding of the system I’m working with. Although I’ve been using Python for data science for years, my experience hasn’t always overlapped with core computer science concepts. accordingly, parts of the project have required a bit of catch-up.

A major point of emphasis I focused on was getting the bindings to OSRM (Open Source Routing Machine) running. While it’s undeniably powerful and fast at returning routing results, OSRM is also nontrivial to configure and maintain, making it less attractive for plug-and-play use in Python-based workflows.

That realization helped crystallize an emerging goal of the project: to move away from relying on standalone services like OSRM and instead introduce support for `routingpy`.

---

### Why `routingpy`?

`routingpy` offers an appealing alternative. it provides Python bindings to a variety of routing backends (including OSRM), but without requiring an external server to be spun up. It keeps everything in Python, making it easier to use in scripting, notebooks, and for reproducibility.

The short-term focus has been ensuring that the core logic of the package is robust, particularly the ability to set up and solve Vehicle Routing Problems (VRP) with the code that sits on top of  `pyvrp`.

---

### Solving the Problem

To that end, I’ve been working with the `LastMile` class, the object responsible for modeling and solving delivery scenarios. This class processes user-provided data, formats it appropriately, and computes a VRP solution.

If no network data is provided, the solver defaults to using Euclidean (straight-line) distances. But the goal is to support network-based routing when data is available, and that means ensuring the solver can build and parse a proper distance and duration matrix before optimization begins.

Earlier this week, I managed to get the solver running, but I quickly saw that some key outputs weren’t behaving correctly. That led me into the `solve()` method itself, which initializes the matrices and computes shortest paths through the network.

Once solved, the module has a helpful `write_results()` function that outputs both CSV files (routes and stops) and an interactive HTML webmap. Having those outputs working correctly is crucial for user feedback and visualization.

---
<div style="text-align: center;">
  <img src="{{ '/assets/wizard2.png' | relative_url }}" alt="perseverance" style="width: 50%;" />
</div>


### What’s Next?

With the toy example mostly replicated, I’m in a good place to start refactoring the VRP engine to support `routingpy` natively. That means abstracting out hardcoded dependencies and ensuring clean interfaces for routing engines of various types.

Next post, I’ll walk through the steps to extend the solver with a `routingpy` backend, and highlight the differences in output and performance.

See you then!

—Dylan
