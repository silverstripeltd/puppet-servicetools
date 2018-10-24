require 'spec_helper'

describe 'servicetools::install_systemd_unit' do
	let(:title) { 'servicetools::install_systemd_unit' }
	let(:params) {{
		'name' => 'test',
		'service_options' => {
			'ExecStart' => 'echo hi',
			'Restart' => 'on-failure',
			'RestartSec' => '5'
		},
		'service_ensure' => 'running',
		'service_enable' => true
	}}

	let(:facts) {{
		:path => '/usr/local',
	}}


	it { is_expected.to compile }
	it { is_expected.to contain_file('/etc/systemd/system/test.service') }
	it { is_expected.to contain_service('test').with('ensure' => 'running', 'enable' => true) }
end


describe 'servicetools::install_systemd_unit' do
	let(:title) { 'servicetools::install_systemd_unit' }

	let(:params) {{
		'name' => 'test.timer',
		'timer_options' => {
			'OnUnitInactiveSec' => '1m',
			'AccuracySec' => '1s',
		},
		'service_ensure' => 'running',
		'service_enable' => true
	}}

	let(:facts) {{
		:path => '/usr/local',
	}}


	it { is_expected.to compile }
	it { is_expected.to contain_file('/etc/systemd/system/test.timer') }
end

describe 'servicetools::install_systemd_unit' do
	let(:title) { 'servicetools::install_systemd_unit' }

	let(:params) {{
		'name' => 'test2.service',
		'service_options' => {
			'ExecStart' => 'echo hi',
			'Restart' => 'on-failure',
			'RestartSec' => '5'
		},
		'service_ensure' => 'stopped',
		'service_enable' => false
	}}

	let(:facts) {{
		:path => '/usr/local',
	}}


	it { is_expected.to compile }
	it { is_expected.to contain_file('/etc/systemd/system/test2.service') }
	it { is_expected.to contain_service('test2').with('ensure' => 'stopped', 'enable' => false) }
end
