<?php
$CONF['configured'] = true;
$CONF['database_type'] = 'mysqli';
$CONF['database_host'] = '{{ db_host }}';
$CONF['database_port'] = '{{ db_port }}';
$CONF['database_user'] = '{{ db_user }}';
$CONF['database_password'] = '{{ db_password }}';
$CONF['database_name'] = '{{ db_name }}';
$CONF['encrypt'] = 'dovecot:ARGON2I';
$CONF['dovecotpw'] = "/usr/bin/doveadm pw -r 5";
if(@file_exists('/usr/bin/doveadm')) { // @ to silence openbase_dir stuff; see https://github.com/postfixadmin/postfixadmin/issues/171
    $CONF['dovecotpw'] = "/usr/bin/doveadm pw -r 5"; # debian
}
$CONF['setup_password'] = '$2y$10$153IB.fCrD3HB3PUUZ2R6O.CYCNY8kRZZFFfCAQuSW24xYdCk.4GO';