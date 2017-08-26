# docker-wordpress-fail2ban

Fail2ban installation combined with popular WP Fail2ban plugin on Wordpress
official image.

## Purpose 

In light of the recent and ongoing brute force attacks on Wordpress websites,
the docker image created from this repository aims to prevent attackers
overloading a Wordpress site server and/or database server.

These brute force attacks often exploit the xmlrpc.php Wordpress file which
allows thousands of username/password combination attempts in a single request
to the server. Such attacks can therefore go undetected when analysing the
Apache error logs [1]. The Wordpress plugin WP Fail2ban By Charles Lecklider [2]
logs all failed login attempts whether made via login.php or xmlrpc.php. This
plugin combined with a server installation of Fail2ban [3] offers excellent
mitigation of these attacks by temporarily blocking the IP addresses from which
failed login attempts are made.

The source code in this repository installs and configures the WP Fail2ban
plugin and Fail2ban software (according to the instructions on the plugin
website) on top of the latest Wordpress Docker image [4].

## Please note

- The WP Fail2ban plugin must also be activated from the Wordpress
  administration panel.
- The docker container must be run with `--privileged` so that it can update the
  IP tables of the host machine.
- Visit https://hub.docker.com/_/wordpress/ for Wordpress docker image usage.

## Obtaining the image

`docker pull wworrall/wordpress-fail2ban`.


## License

MIT License.

## References

[1] <https://blog.sucuri.net/2015/10/brute-force-amplification-attacks-against-wordpress-xmlrpc.html>
[2] <https://en-gb.wordpress.org/plugins/wp-fail2ban/>
[3] <https://www.fail2ban.org>
[4] <https://hub.docker.com/_/wordpress/>
