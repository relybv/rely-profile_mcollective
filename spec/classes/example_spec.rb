require 'spec_helper'

describe 'profile_mcollective' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir => "/foo"
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

        end
      end
    end
  end
end
