# backlight.rb

![proof](http://alureon.net/img/xbacklight.png)

## no backlight you say?

![backlight.rb](http://alureon.net/img/backlight.rb.png)

## i want to use this
You can, but you'll have to change the symlink variable at the top of the script.

`$symlinkDir = "/sys/class/backlight/intel_backlight"`

This is where my backlight is controlled.  Try an `ls` of your `/sys/class/backlight`
directory.  You will want to try a directory there to utilize this.  Change the
variable at the top of the script to reflect that path and then try to run it.

## systemd service file
can be used by copying to `/usr/lib/systemd/system`

enabled with `systemctl enable backlight.rb.service`

You can change the arguments of the service file to suit your needs.  The included
example sets my backlight to max.

## TODO
* Potentially safeguard against setting backlight to zero...don't try that.
* Find a way to determine the symlink directory without hardcoding it
