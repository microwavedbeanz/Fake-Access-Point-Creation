right so the main issue most people will probably have with this is that it doesnt work because wlan0 couldnt be found, easy fix with 2 things.
1. Buy an external wifi card, litterally any of the ones on amazon work. mine was not an expensive alfa card like some sources say you need, it just needs to be able to go into moniter mode
2. you have an external wifi card plugged into your vm and its still not working. for some reason my card doesn't get its name reset to wlan0mon after being swapped into moniter mode, but from what i've gathered most peoples do, so if you get an issue fairly early into the code about wlan0 not being found, then use nano to change all "wlan0"'s to "wlan0mon"'s

Hoping to add some sort of initial pop-up window with a username and password propmt, for social engineering demonstration purposes

another note: if using a VM on a laptop, then when you connect to the AP created, you wont have internet on the connected device, unless you have another source of internet connectio for the device emitting the AP, so i have an ethernet plugged into my laptop to overcome this, not really an issue since it's just how the AP works, to route all traffic theough to the laptop, with the wifi card only serving as an emitter//middleman

pretty cool script though, made up of the induvidual commands i was shown in some youtube tutorial, will link here if i can find it again. with some added optimization and end-user friendlyness, so now ANYONE can make their own fake wifi !!! Hurray for the internet :P
