# Git logs
i connected to the git server through ssh with the credentials in the exercise

then i used the `git log` command to go back to the commit with a password

then i rolled back a commit by running `git revert <commit id from log>`

it was in main.go, when using `cat main.go` i could see the flag
# SSHtay HYDRAted
i start the exercise with credentials to ssh, and the lead of something called hydra, hydra is some password cracking software

when attempting to ssh i get a message with hints to the password, it can be reduced to being 4 letters resembling a number in upper case

i solved the exercise by using hydra to check all letter combinations with length 4 with upper case letters IVX
# Micro CMS XSS
I've solved the other Micro CMS exerises before...

For this exercise it leads me on to check if i can use html syntax in the title or body of a new page.

using HTML in the title field granted me an alert that had the flag
# Admin logon
i am greeted by a login page where i can log in to any user with any password including admin

when checking my cookies i find that i can change a value set to false, to true and reload. After the reload the page contains the flag
# jacobs hus
from the short lecture i learned that pages sometimes contain a robots.txt at the root, here i find a file under http://jacobshus/backup/hemmelig.txt that ccontains ssh information where i can log in at jacob@jacobshus.hkn the root directory contains the flag
# Micro RMS - Robots
similar to micro cms, i check the robots.txt and find a micro-rms.hkn/secret.txt file containing a flag
# Micro RMS - url
i go to make a post on one of the movies on the site and find out when i press edit i get an url as micro-rms.hkn/editReview/2/11

if i change 11 to 1 so i edit a different review i find the flag
# Micro RMS - XSS
when you make a post you can like micro cms use HTML in the posts, when i made a post containing <script>alert()</script> i get a second alert containing a flag
# chatten
i've attempted this one a few lectures ago where i was unsuccessful, i found out you can overwrite the other users passwords by creating a new user with the same email, this must've broke the site because when i tried again i found out i can make a request to change password and post this as a link in the chat on the site to make the other users click on the request url and change their password so i can log in and get the flag
