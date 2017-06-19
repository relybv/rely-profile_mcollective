require 'spec_helper'

describe 'profile_mcollective' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir => "/foo",
            :monitor_address => "localhost",
          })
        end

        context "profile_mcollective class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('profile_mcollective') }
          it { is_expected.to contain_class('profile_mcollective::install') }
          it { is_expected.to contain_class('profile_mcollective::config') }
          it { is_expected.to contain_class('profile_mcollective::service') }
          it { is_expected.to contain_class('profile_mcollective::params') }
          it { is_expected.to contain_class('profile_mcollective::facts') }

          it { is_expected.to contain_cron('ckeck mco connection') }

          it { is_expected.to contain_exec('mcollective') }

          it { is_expected.to contain_file('/etc/puppetlabs/mcollective/client.cfg') }
          it { is_expected.to contain_file('/etc/puppetlabs/mcollective/facts.yaml') }
          it { is_expected.to contain_file('/etc/puppetlabs/mcollective/server.cfg') }
          it { is_expected.to contain_file('/opt/puppetlabs/mcollective/plugins/mcollective/') }

          it { is_expected.to contain_package('mcollective-plugins-service') }
          it { is_expected.to contain_package('puppet-agent') }
          it { is_expected.to contain_package('python') }

          it { is_expected.to contain_rabbitmq_exchange('mcollective_broadcast@mcollective') }
          it { is_expected.to contain_rabbitmq_exchange('mcollective_directed@mcollective') }

          it { is_expected.to contain_rabbitmq_user('admin') }
          it { is_expected.to contain_rabbitmq_user('mcollective') }

          it { is_expected.to contain_rabbitmq_user_permissions('admin@mcollective') }
          it { is_expected.to contain_rabbitmq_user_permissions('mcollective@mcollective') }

          it { is_expected.to contain_rabbitmq_vhost('mcollective') }

        end
      end
    end
  end
end
