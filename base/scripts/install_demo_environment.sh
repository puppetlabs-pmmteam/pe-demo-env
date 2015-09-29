demo_pwd="`pwd`/pe-demo-env"
cwd=`pwd`
username=`whoami`

if ! [ `uname -s` == "Darwin" ]; then
  echo "This install script only works on Mac OS X"
  exit 1
fi

[ -d $demo_pwd ] || git clone https://github.com/puppetlabs-pmmteam/pe-demo-env.git $demo_pwd

which puppet || gem install puppet

which librarian-puppet || gem install librarian-puppet

cd $demo_pwd/base/scripts
librarian-puppet install
cd $cwd

echo "Type in your local password (What you use to log into you Mac):\n"
sudo FACTER_username=$username puppet apply --modulepath $demo_pwd/base/scripts/modules $demo_pwd/base/scripts/demo_requirements.pp
