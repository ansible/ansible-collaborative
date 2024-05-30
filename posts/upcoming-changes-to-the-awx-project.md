---
author: Matthew Jones
date: 2024-05-30 00:00 UTC
description: Upcoming Changes to the AWX Project
lang: en-us
title: Upcoming Changes to the AWX Project
---

By **Matthew Jones**, *Chief Architect, Ansible Automation at Red Hat*

Back in 2013, a small team of engineers worked for over a year to make the first commercial release of Ansible Tower (before we expanded and evolved to Ansible Automation Platform) and during that time we put down the foundation of an application that I’m immensely proud of. 

We, the original architects of Tower, were trying to find the best way to create a system that would allow running Ansible at scale for hundreds of thousands of servers. We wanted there to be a way to not just manage those servers but store the results of that automation and provide auditability and traceability. It needed to make Ansible functional for large teams and it succeeded.

Today, we’re not just talking about hundreds of thousands. We’re thinking in the millions and tens of millions, we’re managing automation for some of the largest IT organizations in the world. And we’re not just managing servers. In the intervening years we’ve been automating containers, cloud platforms, network devices, storage, IoT devices and PLCs (among other things). One of the main challenges that we’re facing is that some of the architectural decisions we made 10 years ago are still with us. We have a monolithic system that performs its job extremely well but can be very challenging to expand with new capabilities.
<!-- TEASER_END -->
### Moments of change

Early on while building Ansible Tower we realized that we needed a way to distribute Ansible content and that’s when Ansible Galaxy was born. For years everyone had asked us for a version of Ansible Galaxy that could be installed locally. We knew that we wanted to do this but it took us several years and when we finally released it we found that we had built something that was far more capable as an integrated product than we had realized. Being able to manage the automation content and the distribution of that content to the runtime engine that we had already invested time in was extremely powerful for people who deployed and used it, even though at the time we didn’t have a great way to connect the two systems together in a way that felt seamless.

Many of you may remember in 2019 we went through a similar journey with the Ansible open source project, [Thoughts on Restructuring the Ansible Project](https://www.ansible.com/blog/thoughts-on-restructuring-the-ansible-project/), we are at a similar inflection point, with similar problems to solve but we also aim to learn from that experience and the subsequent changes that allowed.

Let's take Event-Driven Ansible, as an example. When we started working on expanding Ansible Automation Platform to accept events from external systems, we decided to try something a little different, we could foresee the risk of adding this (new to us) pattern to the established code base. We wanted a small and compact system that was capable of running Ansible workloads in a slightly different way and in response to other events and actions. It needed to sit in between those event sources, make decisions, and map data into Ansible workloads that were relevant to the task at hand. The scaling characteristics and life cycle of this system is very different from what Automation Controller (formerly Ansible Tower) does for managing direct Ansible job runs, even though this event-based system needs to be able to run those very same jobs.

Event-Driven Ansible has been a huge success, but we’ve noticed the same limitations with our existing architecture when trying to combine it with this new system. We need Jobs to be able to report their status in different ways and in different places. We need credentials and projects to be usable in a secure way by this system. Inventory management for Ansible today isn’t just about Servers or Containers, they are about Cloud and Service APIs as well as Embedded and Edge capabilities. 

### Our challenges and influences

Internally, as a team, we find ourselves at a point where adding to and maintaining the existing application architecture limits our ability to change. We’ve reached the limit of how far we can innovate with our existing system and we’ve reached a point where trying to do it the right way conflicts with the solution we have created to date. If we want to keep going, what can we do?

Over the past few years we’ve leveraged containers, both for RHEL via Podman and for OpenShift to solve some of those challenges, Execution Environments for better managing Python dependencies in Ansible Core, as an example. However in doing so never tackled the central part of the platform, Automation Controller which is built downstream from the AWX project. Like many of our customers and users will have done to their systems, we moved a “legacy” application to containers but we didn’t change it to really take advantage of what containers enable. 

While those changes gave us some breathing room, three years later, we still find ourselves being slower at making changes than we would like, with an old architecture that costs too much time to understand and test those changes.

Externally, the wider industry has moved on since AWX first emerged. Our customers now expect AAP to be operated as a cloud native application, leveraging autoscale and blue:green deployments. More of our offerings are now deployed on and via the cloud hyperscalers and our customers operate more complex hybrid cloud architectures. 

Then we also need to consider what it means to be an enterprise grade automation platform in the age of AI. Both for how we intend to leverage the wider Red Hat strategy for trained models to enhance and augment the AAP offering, and also how AAP fits into the ever growing management capabilities of customers. Many of our customers want to use AI to enhance their build and release systems and improve increasingly complex operational challenges, and those that aren’t yet, will want to do so in the future.

We have reached a point where the changes needed are too challenging to maintain the status quo. They are complex and cause unexpected impacts to the product, and where we need stability we often have fragility and this also takes a toll on the engineers doing the work. Everything goes through Automation Controller and the team that built it.

This blog is the start of us embarking on a process of reviewing and adjusting our project structures and processes, so we can better meet the demands of 2024 and beyond. While this will result in changes to projects conceived in 2013 there are many lessons we, you and the industry have learned in these 10+ years and we need to apply that learning to how we build an automation platform ready for the coming 10 years. This is especially important as we continue to understand how our customers will leverage AI and Automation as the wider industry understands how to leverage AI in enterprise use cases. We want Ansible and Ansible Automation Platform to be the foundations for many of those improvements and continue to be a secure, scalable execution platform across the lifecycle of IT activities.

I’d also like to reflect on the feedback we got at AnsibleFest 2024 just a few weeks ago in Denver. During the AWX community session I discussed the need for change during our presentation and that we are going to focus on growing the capabilities of Ansible, making good design decisions that have a positive impact on Ansible for the future and provide a stable base for Ansible Automation Platform. I had many follow up discussions with attendees, discussing the possibilities and the considerations we’ll have to think through.

Because Ansible is incredibly useful to so many of our customers and users, and the use cases you conceive of that we don’t consider, we love this aspect and the passion that Ansible generates. The historical decisions we’ve made that were justifiable and sensible at the time, are often the reason that holds you and us back from achieving so much more. My passion for Ansible is as strong now as it was in 2013, and I still want to be surprised by what people can achieve with our technology at AnsibleFest 2033. If we don’t change, we will be what blocks the next set of innovators in the Ansible ecosystem and that’s why I feel we have to make these changes now so we can be stronger and more agile to meet the needs of the next generation of automation capabilities and be having these discussions for many years to come.

### What’s next?

Before we conclude, we should be clear about what will not happen.

- We are not changing the Ansible project 
- We are not adjusting our OSS license structure

Ultimately, we need to make some changes to the way our systems work and our projects are structured. Not a rewrite but a refactoring and restructuring of how some of the core components connect and communicate with each other. 

At this time, as we finish the latest release of Ansible Automation Platform, we have lots of ideas. We will begin investigating options and as we identify areas of change, need input, and make decisions. We will leverage the communication channels we have with our contributors to share those ideas and changes with a continued blog series where we can discuss challenges and benefits.

We are conscious that this communication will generate questions, to many of which we do not yet have answers. We ask for your time, patience, and input as we take these steps to evolve our work. We want to be clear and transparent with the challenges we face and the opportunities ahead that will enable future years of innovation in the Ansible ecosystem.
