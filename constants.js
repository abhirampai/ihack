"use strict";
const root = require('./helpers.js').root;
const ip = require('ip');

exports.HOST = ip.address();
exports.DEV_PORT = 3000;
exports.E2E_PORT = 4201;
exports.PROD_PORT = 8088;

exports.USE_DEV_SERVER_PROXY = false;
exports.DEV_SERVER_PROXY_CONFIG = {
	'**': 'http://localhost:8089'
}

exports.DEV_SOURCE_MAPS = 'eval';
exports.PROD_SOURCE_MAPS = 'source-map';

exports.DEV_SERVER_WATCH_OPTIONS = {
	poll: 1000,
	aggregateTimeout: 1000,
	ignored: /node_modules/
}

exports.STORE_DEV_TOOLS = 'monitor'

exports.EXCLUDE_SOURCE_MAPS = [
	// these packages have problems with their sourcemaps
	root('node_modules/@angular'),
	root('node_modules/rxjs')
]

exports.MY_COPY_FOLDERS = [
]

exports.MY_POLYFILL_DLLS = [
]

exports.MY_VENDOR_DLLS = [
	'ngx-file-drop'
]

exports.MY_CLIENT_PLUGINS = [
	new webpack.ProvidePlugin({
		$: "jquery",
		jQuery: "jquery"
	})
]

exports.MY_CLIENT_PRODUCTION_PLUGINS = [
]

exports.MY_CLIENT_RULES = [
]

exports.MY_TEST_RULES = [
]

exports.MY_TEST_PLUGINS = [
]


exports.DEV_ENVIRONMENT = {
	'networkId': 488413,
	'tokenAddress': '0xa724a61f4b46d549fd67f5e5d4c441d950b85c43',
	'rpcProviderUrl': 'https://rpcprovider.staging.bankex.team:8635',
	'websocketProviderUrl': 'wss://wsprovider.staging.bankex.team:8636',
	'apiUrl': 'https://opencharity.staging.bankex.team/api/',
	'organizations': [
		'0x0Edd482B0D1177a197EfEd715428e54852453219',
		'0xe86Ec436401C9d853aB260C6a25273d4537645aD',
		'0x4c35a12eE22b428C3D45249b461Caf323680B949'

	]
};

exports.STAGING_ENVIRONMENT = {
	'networkId': 488413,
	'tokenAddress': '0xa724a61f4b46d549fd67f5e5d4c441d950b85c43',
	'rpcProviderUrl': 'https://rpcprovider.staging.bankex.team:8635',
	'websocketProviderUrl': 'wss://wsprovider.staging.bankex.team:8636',
	'apiUrl': 'https://opencharity.staging.bankex.team/api/',
	'organizations': [
		'0x0Edd482B0D1177a197EfEd715428e54852453219',
		'0xe86Ec436401C9d853aB260C6a25273d4537645aD',
		'0x4c35a12eE22b428C3D45249b461Caf323680B949'
	]
};

exports.PROD_ENVIRONMENT = {
	'networkId': 488423,
	'tokenAddress': '0x7487a0251a0701a89cade302679b1d01c3d8a44f',
	'rpcProviderUrl': 'https://rpcprovider.opencharity.bankex.team:8635',
	'websocketProviderUrl': 'wss://wsprovider.opencharity.bankex.team:8636',
	'apiUrl': 'https://opencharity.bankex.team/api/',
	'organizations': [
		'0x3efbEe62f4132073382cF273D78D77DFea317c2b',
		'0x9d53eB998289631F9663fe1BC3F0307589903C09',
		'0x1A6Cc32EDB9230D0aC1c842D8baF69c97F00a1AC'
	]
};
