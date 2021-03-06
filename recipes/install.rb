#
# Cookbook Name:: chronograf
# Recipe:: install
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

case node['platform_family']
when 'debian'
  # apt repository configuration
  apt_repository 'influxdb' do
    uri node['chronograf']['apt']['uri']
    components node['chronograf']['apt']['components']
    key node['chronograf']['apt']['key']
    distribution node['chronograf']['apt']['distribution']
    action node['chronograf']['apt']['action']
  end
when 'rhel'
  # yum repository configuration
  yum_repository 'influxdb' do
    description node['chronograf']['yum']['description']
    baseurl node['chronograf']['yum']['baseurl']
    gpgcheck node['chronograf']['yum']['gpgcheck']
    gpgkey node['chronograf']['yum']['gpgkey']
    enabled node['chronograf']['yum']['enabled']
    action node['chronograf']['yum']['action']
  end
end

package 'chronograf' do
  version if node['chronograf']['version']
  notifies :restart, 'service[chronograf]' if node['chronograf']['notify_restart'] && !node['chronograf']['disable_service']
end
