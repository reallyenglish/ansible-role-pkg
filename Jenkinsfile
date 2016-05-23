node ('virtualbox') {
  stage 'Checkout'
  sh 'if [ ! -d ansible-role-pkg ]; then mkdir ansible-role-pkg; fi'
  dir('ansible-role-pkg') {
    checkout scm
  }
  dir('ansible-role-pkg') {
    stage 'bundle'
    sh 'bundle install --path vendor/bundle'
    sh 'if vagrant box list | grep trombik/ansible-freebsd-10.3-amd64 >/dev/null; then echo "installed"; else vagrant box add trombik/ansible-freebsd-10.3-amd64; fi'

    stage 'Syntax check'
    sh 'ansible-playbook --syntax-check -i localhost test/integration/default.yml'

    stage 'bundle exec kitchen test'
    sh 'bundle exec kitchen test'

    stage 'Notify'
    step([$class: 'GitHubCommitNotifier', resultOnFailure: 'FAILURE'])
  }
}
