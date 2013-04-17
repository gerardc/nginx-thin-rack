# Nginx-thin-rack

Simple capistrano-based deployment recipe for deploying a rack application (with
RVM) to a cluster of Thin servers behind Nginx. Based on the Thin docs available at http://code.macournoyer.com/thin/

## Usage

A Capistrano configuration file is available in `config/deploy.rb`
with some useful tasks for bundling gems, creating the project folder structure,
and starting/stopping Thin.

A Thin configuration file is available in `config/thin.yml`, it contains sample configuration
for a cluster of 3 servers pointing to `config.ru`.

The file `nginx.conf_example` is an example nginx configuration file that can be
dropped into `/etc/nginx/conf.d/` on your server. Again is based on the example
from the Thin documentation at http://code.macournoyer.com/thin/usage/

## Todo

- Add examples for starting multiple processes via `foreman` or `upstart`

## License

Copyright © 2013 Gerard Cahill

Distributed under the Eclipse Public License, the same as Clojure.
