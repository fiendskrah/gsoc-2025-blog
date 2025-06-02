---
title: placeholder
date: 2025-06-01 (estimated)
---

Coding period begins!
I'm estatic to begin working on the routing engine

When trying to describe this project in conversation, I've basically said that it's a way to specify routing distance and related parameters from user-provided data that is intended to be used with the spopt module. 

The first lift for me was getting onboarded to the project, which means invocating a research environment. 

As a student researcher at the [Center for Open Geographic Science](cogs.sdsu.edu), I'm fortunate to have access to a *poweful* research server with more processing power than my laptop, but it can be awkward to edit code or write prose with compared to my well-honed emacs configuration. 

My strategy to get the best of both worlds means that from my local machine, I use SSH to tunnel into the remote research server, where I instantiate a jupyter lab and run my code. I edit code and take notes side by side on emacs, and push my changes to my remote fork and branch of the project on github. Then, in my jupyter instance, I git pull those changes in. 

This seems like it could be clunky because I cannot directly edit the code base and call a function, but it has its advantages. Firstly, it gives me the full range of motion enabled by emacs. Long have I slaved over my keybinding scheme and *elisp* syntax to create an environment that allows me to swiftly perform a desired function and move between production modes. Crucially, this includes git and github through an package called *magit*, which makes commiting and pushing very convinient and fluid, at least compared to the command line. The second advantage this gives me is that it forces me to push my changes frequently, meaning a richer commit history. Lastly, because this project aims to use optimization and can involve very dense travel network data, being able to leverage the more powerful research server is very desirable.

I created a new environment using *mamba* and cloned the draft Pull Request for the project and ensured I had the new module, now it's time to test the functionality.

guiness https://gist.github.com/ljwolf/e5927ab8c859ed477f496329c1ce19fc

dublin-pubs.geojson https://github.com/irishshagua/dublin-pubs-map?tab=readme-ov-file

The downside of tunnel coding is that sometimes I need to adjust the PATH to get the server to recognize where I'm pointing. 

I thought "let's just grab it and see how far I can get just running it as is" but of course, only 3 lines in I hit a traceback because the interpreter is trying to set the index on a network identifier, which of course I don't have
