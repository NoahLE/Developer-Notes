# Programming notes

This is a set of notes to help me quickly reference things I find useful. I hope it helps out other developers as well!

## Table of Contents

Table of Contents will be published soon!

## Installation

1. Install Node.js [from here](https://nodejs.org/en/) (the current version is fine - 9.8.0 as of 3-12-2018)

2. Install the GatsbyJS CLI by running the following command in your shell `npm install --global gatsby-cli`

3. Clone the repository to your location of choice `git clone git@github.com:NoahLE/Developer-Notes.git` (feel free to fork as well)

4. CD into the project's root directory and run `gatsby develop` to start testing! You should be able to access the website at `localhost:8000` in your browser

## Commands

* `gatsby develop` — Gatsby will start a hot-reloading development environment accessible at localhost:8000
* `gatsby build` — Gatsby will perform an optimized production build for your site generating static HTML and per-route JavaScript code bundles.
* `gatsby serve` — Gatsby starts a local HTML server for testing your built site.

## Project Structure

Here is a quick breakdown of this project's structure.

### Content Folder

The content for all the pages is located in the `content` folder. I tried to set up a structure of `main category` -> `sub-category` (if needed) -> `page`. Ideally the depth of pages won't be more than three levels deep.

### SRC Folder

These components are written in React and control the structure and appearance of the website.

* `layouts` - The skeleton layout of the website
* `pages` - Controls the structure of each page
* `templates` - Has the layout for each post
* `utils` - Has the formatting options, such as the font

### Project Root

* `gatsby-config.js` - Controls Gatsby's plugins
* `gatsby-node.js` - Controls page creation

## Useful Links

* [Gatsby Documentation](https://www.gatsbyjs.org/docs/)