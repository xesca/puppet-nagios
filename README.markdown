# nagios Module #

This module provides mechanisms to assist with patch management

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

None

Change Log
----------

* 0.1.0 : Initial Release

Contact
-------

Aaron Russo <arusso@berkeley.edu>

Support
-------

Please log tickets and issues at the
[Projects site](https://github.com/arusso23/puppet-nagios/issues/)
