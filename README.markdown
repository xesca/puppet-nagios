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


Contact
-------

Xesc Arbona <x.arbona@topdesk.com>


Support
-------

Please log tickets and issues at the
[Projects site](https://github.com/xesca/puppet-nagios/issues/)

Original module: https://github.com/arusso/puppet-nagios/
