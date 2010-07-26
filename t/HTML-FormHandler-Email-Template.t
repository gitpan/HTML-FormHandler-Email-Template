# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl HTML-FormHandler-Email-Template.t'

#########################

use Test::More tests => 1;
BEGIN { use_ok('HTML::FormHandler::Email::Template') };

#########################

# i really need to write some tests