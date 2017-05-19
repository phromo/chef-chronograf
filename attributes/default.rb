default['chronograf']['version'] = nil
default['chronograf']['disable_service'] = false

default['chronograf']['user'] = 'chronograf'
default['chronograf']['group'] = 'chronograf'

default['chronograf']['notify_restart'] = true
default['chronograf']['conf_dir'] = '/opt/chronograf'
default['chronograf']['conf_file'] = ::File.join(node['chronograf']['conf_dir'], 'config.toml')

default['chronograf']['yum']['baseurl'] = value_for_platform(
  %w(amazon) => { 'default' => 'https://repos.influxdata.com/rhel/6/$basearch/stable' },
  %w(centos redhat fedora) => { 'default' => 'https://repos.influxdata.com/rhel/6/$basearch/stable' }
)

default['chronograf']['include_repository'] = true

default['chronograf']['yum']['description'] = 'InfluxDB Repository - RHEL $releasever'
default['chronograf']['yum']['gpgcheck'] = true
default['chronograf']['yum']['enabled'] = true
default['chronograf']['yum']['gpgkey'] = 'https://repos.influxdata.com/influxdb.key'
default['chronograf']['yum']['action'] = :create

default['chronograf']['apt']['uri'] = 'https://repos.influxdata.com/debian'
default['chronograf']['apt']['description'] = 'InfluxDB Repository'
default['chronograf']['apt']['components'] = %w(stable)
# default['chronograf']['apt']['distribution'] = ''
default['chronograf']['apt']['action'] = :add
default['chronograf']['apt']['key'] = 'https://repos.influxdata.com/influxdb.key'

default['chronograf']['bind_host'] = node['ipaddress']
default['chronograf']['bind_port'] = 10_000
default['chronograf']['local_database_dir'] = '/opt/chronograf'
default['chronograf']['config']['QueryResponseBytesLimit'] = 2_500_000
