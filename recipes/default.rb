#
# Cookbook:: mongo
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

apt_repository "mongodb-org" do
  keyserver "hkp://keyserver.ubuntu.com:80"
  key "EA312927"
  uri "http://repo.mongodb.org/apt/ubuntu"
  distribution "xenial/mongodb-org/3.2"
  components ["multiverse"]
  action :add
end

apt_update "update" do
  action :update
end

package "mongodb-org" do
  action :install
end

package "mongodb-org" do
  action :upgrade
end

file "/etc/mongo.conf" do
  action :delete
end

file "/lib/systemd/system/mongod.service" do
  action :delete
end

template "/etc/mongo.conf" do
  source "mongod.conf.erb"
  notifies(:restart, "service[mongod]")
end

template "/lib/systemd/system/mongod.service" do
  source "mongod.service.erb"
  notifies(:restart, "service[mongod]")
end

service "mongod" do
  action [:enable, :start]
end
