demo_pwd="`pwd`/pe-demo-env"
cwd=`pwd`
username=`whoami`

if ! [ `uname -s` == "Darwin" ]; then
  echo "This install script only works on Mac OS X"
  exit 1
fi

[ -d $demo_pwd ] || git clone https://github.com/puppetlabs-pmmteam/pe-demo-env.git $demo_pwd

# Make sure we have sudo permissions
echo "Type in your local password (What you use to log into you Mac):\n"
sudo echo 'Installing system requirements......'

which puppet || sudo gem install puppet --no-rdoc --no-ri

which librarian-puppet || sudo gem install librarian-puppet --no-rdoc --no-ri

cd $demo_pwd/base/scripts
librarian-puppet install
cd $cwd

sudo FACTER_username=$username puppet apply --modulepath $demo_pwd/base/scripts/modules $demo_pwd/base/scripts/demo_requirements.pp
