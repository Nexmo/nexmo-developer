---
title: "Home"
permalink: /
---

# Station

1.  [What Is Station?](#what-is-station)
2.  [What Is Station For?](#what-is-station-for)
3.  [What Problems Does Station Solve?](#what-problems-does-station-solve)
4.  [How Does Station Accomplish Its Goals?](#how-does-station-accomplish-its-goals)

## What Is Station?

Station is a platform tool. In combination with custom configuration files and a path to content files in markdown, Station provides a platform website that can be used for any number of purposes.

Station is built with Ruby on Rails as its infrastructure incorporated with Webpack. For the experienced Rails developer, it will feel familiar. For a person not acquainted with Rails, it will be unnecessary to learn the nuances of the framework to run or contribute content to a Station powered site.

## What Is Station For?

Station is built to provide the following out of the box:

*   A solution for creating text-driven content websites quickly
*   The ability for non-software developers to contribute content in a streamlined fashion
*   Highly customizable to meet each site's needs through a set of defined configuration files

## What Problems Does Station Solve?

There are multiple concerns involved in creating a platform site, and all too often, any individual contributor needs to be proficient in many of them to make a contribution in their area of expertise. A technical writer should not need to know Ruby to offer documentation. A graphic designer should not need to know JavaScript to contribute a graphic design for the site. Yet, in many instances, that is the case.

Furthermore, a single business often can have multiple product lines that need multiple documentation or developer portals. It can be difficult to ensure that the style guide and overall look of the business remain consistent over time across different platform sites.

Station comes to solve both of these problems. Through Station people can contribute in their area of expertise without needing to be proficient in other areas. Likewise, through Station distinct product documentation portals under the same business can be built and can retain sustainably the same experience across platforms.

## How Does Station Accomplish Its Goals?

Station accomplishes this by:

*   Providing a CLI that lets administrators boot up a platform with a one-line command
*   Offering different configuration files for different customizable aspects of the platform
*   Integrating web assets such as images from the `/public` folder in the content path into the platform
*   Utilizing custom exception messaging to provide users with advice during troubleshooting platform problems
*   Disaggregating the code of the platform and its content so content contributors do not need to be concerned at all with the code
*   With regular releases of new versions following semantic versioning guidelines, providing administrators with the assurance that their platform will be current with dependency upgrades by maintaining a single gem dependency, that of Station itself

Learn more about [Getting Started](Getting-Started.md) and [How To Use](How-To-Use.md) Station.
