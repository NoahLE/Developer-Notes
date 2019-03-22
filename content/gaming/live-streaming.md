# Live Streaming

This guide teaches you how to live stream on Twitch.tv. 

At this time, this guide will only work for Windows computers. You can use OBS as a substitute for Streamlabs OBS. The section for Twitch can be substituted for whatever livestreaming service you prefer (YouTube, Mixer, Facebook, etc).

- [Live Streaming](#live-streaming)
  - [First Steps](#first-steps)
  - [Twitch Setup](#twitch-setup)
  - [Software Setup](#software-setup)
  - [Themes](#themes)
  - [Capturing and Displaying Content](#capturing-and-displaying-content)
  - [Notes](#notes)

## First Steps

1. Create an account for the Streaming service you wish to use
2. Create an account on the [Streamlabs OBS](https://streamlabs.com/) using the account in the previous step.
3. Download and install the [Streamlabs OBS software](https://streamlabs.com/)

## Twitch Setup

1. Go to your Twitch dashboard by clicking your username in the top right and selecting Dashboard
   1. The URL should look something like https://www.twitch.tv/YOUR-USERNAME/dashboard/settings
2. In the left column, select the Settings > Channel link
3. Copy the Primary Stream key

## Software Setup

1. Open up the Streamlabs OBS software
2. In the top right, click the login button and use whatever account you want linked to the software
3. Select the settings icon (the cog in the top right) and go to the Stream section
   1. Set the Stream Type -> Streaming Services
   2. Set the Service -> Twitch
   3. Leave the Server as Auto
   4. Copy any paste the API key from your Twitch dashboard
4. All the other settings are specific to your network and computer speed. You may need to turn some of these settings up or down.

## Themes

1. Go to the themes tab in the top left of Streamlabs OBS and pick a theme
   1. Sort By -> Most popular
   2. You can preview them by left clicking (there's a back button in the top left).

## Capturing and Displaying Content

Select the Editor tabs in the top left

1. The left section (Scenes) at the bottom is each of your views. For example, one could be your desktop, a few could be for messages (stream starting soon, be right back, etc), and some for games
2. The middle section (Sources) is what shows up in each scene. This is where you control the actual text boxes, images, the game capturing, and any other material you want on screen.

1. To add a game, click the plus sign and select Game Capture. Give it a name and select Add New Source. Set the mode to Capture Specific Window and in the Window dropdown select the game. Change any other settings and click accept.
2. To add text, click the plus sign and select Text (GDI+). Give it a name and then select Add New Source. Edit the text however you'd like.

## Notes

* Sources at the top will appear on top of other sources
* Streams usually have a 5-10 second delay. You can reduce this a little bit by changing your Optimization Preference (Twitch -> Dashboard -> Settings -> Channel -> Optimization Preference -> Low latency)