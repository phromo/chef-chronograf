#
# Cookbook Name:: chronograf
# Recipe:: config
#
# Copyright 2015, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'toml'

directory node['chronograf']['local_database_dir'] do
  owner node['chronograf']['user']
  group node['chronograf']['user']
  mode 0755
end

file node['chronograf']['conf_file'] do
  content TOML::Generator.new(node['chronograf']['config']).body
  notifies :restart, 'service[chronograf]' if node['chronograf']['notify_restart'] && !node['chronograf']['disable_service']
end

ruby_block 'delay chronograf service start' do
  block do
  end
  notifies :start, 'service[chronograf]'
  not_if { node['chronograf']['disable_service'] }
end

service_action = node['chronograf']['disable_service'] ? [:disable, :stop] : [:enable, :nothing]

service 'chronograf' do
  supports :status => true, :restart => true
  action service_action
end
