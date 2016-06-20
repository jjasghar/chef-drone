directory '/var/lib/drone'

include_recipe 'chef-vault::default'
include_recipe 'drone::_docker'

docker_image 'drone' do
  repo 'drone/drone'
  tag node['drone']['version']
end

docker_container 'drone' do
  repo 'drone/drone'
  tag node['drone']['version']
  port '80:8000'
  env drone_env
  volumes ['/var/lib/drone:/var/lib/drone', '/var/run/docker.sock:/var/run/docker.sock']
  restart_policy 'always'
  log_driver node['drone']['docker']['log_driver']
  log_opts node['drone']['docker']['log_opts']
  sensitive true
end
