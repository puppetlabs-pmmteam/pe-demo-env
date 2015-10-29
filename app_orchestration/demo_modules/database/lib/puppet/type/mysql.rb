Puppet::Type.newtype :mysql, :is_capability => true do
  newparam :name, :is_namevar => true
  newparam :user
  newparam :database
  newparam :password
  newparam :host
end
