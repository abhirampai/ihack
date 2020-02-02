const constants = require('./constants');
const orgnaizationAbi = require('./build/contracts/Organization.json').abi;
const charityEventAbi = require('./build/contracts/CharityEvent.json').abi;
const incomingDonationAbi = require('./build/contracts/IncomingDonation.json').abi;
const openCharityTokenAbi = require('./build/contracts/OpenCharityToken.json').abi;
const request = require('request');
const env = 'master';
console.log(`env: ${env}`);

const setList = (type) => {
	const body = {
		type: type,
		list: organizationsList,
		abis: {
			Organization: orgnaizationAbi,
			CharityEvent: charityEventAbi,
			IncomingDonation: incomingDonationAbi,
			OpenCharityToken: openCharityTokenAbi
		},
		token: (env === 'production') ? TOKENPROD : TOKENSTAGE
	};

	request({
		url: setOrganizationsUrl,
		method: 'POST',
		json: true,
		body: body
	}, function (error, response, body){
		if (error) {
			console.log('ERROR:');
			console.log(error);
			return;
		}
		console.log(body);
	});
};


let setOrganizationsUrl;
let organizationsList;
let type = 0;

if (env === 'production') {
	setOrganizationsUrl = constants.PROD_ENVIRONMENT.apiUrl + 'settings/setOrganizationList';
	organizationsList = constants.PROD_ENVIRONMENT.organizations;
} else if(env === 'staging') {
	setOrganizationsUrl = constants.STAGING_ENVIRONMENT.apiUrl + 'settings/setOrganizationList';
	organizationsList = constants.STAGING_ENVIRONMENT.organizations;
} else if(env === 'master') {
	setOrganizationsUrl = constants.DEV_ENVIRONMENT.apiUrl + 'settings/setOrganizationList';
	organizationsList = constants.DEV_ENVIRONMENT.organizations;
	type = -1;
}

setList(type);

