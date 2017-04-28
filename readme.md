# backlight.rb

![proof](http://alureon.net/img/xbacklight.png)

## no backlight you say?

![backlight.rb](http://alureon.net/img/backlight.rb.png)

## systemd service file
can be used by copying to `/usr/lib/systemd/system`

enabled with `systemctl enable backlight.rb.service`

You can change the arguments of the service file to suit your needs

## TODO
* Potentially safeguard against setting backlight to zero...don't try that.
* Find a way to determine the symlink directory without hardcoding it
