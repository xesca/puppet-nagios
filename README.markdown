# nagios Module #

This module manages nagios. It lacks functionality for use with exported
resources at this time.

# Examples #

<pre><code>
  class { 'nagios':
    admin_email           => 'admin@example.com',
    admin_pager           => '5551234567@txt.att.net',
    enable_event_handlers => false,
  }

  include nagios::plugin::disk
  include nagios::plugin::nrpe
</code></pre>
 
License
-------

See LICENSE file

Copyright
---------

Copyright &copy; 2014 The Regents of the University of California

Contact
-------

Aaron Russo <arusso@berkeley.edu>

Support
-------

Please log tickets and issues at the
[Projects site](https://github.com/arusso/puppet-nagios/issues/)
