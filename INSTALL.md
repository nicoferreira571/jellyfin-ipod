# Jellyfin for iPod touch (iOS 6) - install guide

You need: a free GitHub account, 3uTools on your Windows PC, your jailbroken iPod and its USB cable.
You do NOT need Theos, Xcode, or anything else on your PC. GitHub builds the app for you in the cloud.

## PART 1 - Let GitHub build the app (about 10 minutes, one time)

1. Go to https://github.com and sign in (or click Sign up - it's free).
2. Click the green **New** button (or the + at the top right, then **New repository**).
3. Repository name: `jellyfin-ipod`. Choose **Public**. Do NOT tick any "Add a README" boxes. Click **Create repository**.
4. On the empty repo page, click the link **uploading an existing file**.
5. On your PC, unzip `jellyfin-ipod-github.zip`. Open the unzipped folder, press **Ctrl+A** to select everything inside it, and drag it all into the GitHub page where it says "Drag files here".
6. Wait until the file list finishes uploading. Check that you can see a folder called **.github** and a folder called **Resources** in the list.
   - If `.github` is missing: click **Add file > Create new file**, type `.github/workflows/build.yml` as the name (typing the slashes makes the folders), open `build.yml` from the zip with Notepad, copy everything and paste it in.
7. Click the green **Commit changes** button at the bottom (leave the defaults).
8. Click the **Actions** tab at the top. If it asks, click **I understand my workflows, go ahead and enable them**.
9. You will see a build called "Build Jellyfin IPA" with a yellow spinning circle. Wait 5-10 minutes until it turns into a green check.
   - If it shows a red X: click it, click **build**, click the step with the red X, and copy the last ~30 lines of text. Send them to Claude and it will fix the file.
10. Go back to the **Code** tab. On the right side, under **Releases**, click **Jellyfin build 1**.
11. Under **Assets**, click **Jellyfin.ipa** to download it.

## PART 2 - Install with 3uTools

1. Plug the iPod into your PC with the USB cable. If the iPod asks "Trust this computer?", tap **Trust**.
2. Open 3uTools and wait until it shows your iPod.
3. Click **Apps** on the left, then **Import & Install IPA** (button at the top).
4. Pick the `Jellyfin.ipa` you downloaded and wait for the progress bar to finish.
5. The Jellyfin triangle icon appears on your home screen. If it doesn't, restart the springboard (or reboot the iPod).
   - If the install fails with a signature error: open Cydia on the iPod, search for **AppSync** and install it, then try 3uTools again.

## PART 3 - Connect to your Jellyfin server

1. On the PC that runs Jellyfin, press the Windows key, type `cmd`, press Enter, type `ipconfig` and press Enter. Find **IPv4 Address**, for example `192.168.1.23`.
2. Make sure the iPod is on the same Wi-Fi as that PC and Jellyfin is running.
3. Open the Jellyfin app on the iPod. For **server** type `http://192.168.1.23:8096` (use YOUR number), then your Jellyfin username and password, then **Sign In**.
   - Use `http://`, not `https://`. iOS 6 does not trust modern HTTPS certificates.

## Updating later
Change any file on GitHub (or upload a new one). It rebuilds automatically and a new build appears under Releases. Install the new Jellyfin.ipa with 3uTools - it installs over the old one and keeps you signed in.

## Troubleshooting
- **Video won't start:** in the app go to Settings and turn **Direct play** Off, or lower **Streaming quality**. Jellyfin also needs ffmpeg working for converting videos (it's included in the normal Windows install).
- **Can't reach the server:** check the IP address, the port (8096) and that Windows Firewall allows Jellyfin.
- **No music when the screen locks:** music keeps playing in the background; if it stops, start it again from the app.
