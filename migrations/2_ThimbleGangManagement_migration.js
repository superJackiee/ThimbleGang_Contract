const ThimbleGangManagement = artifacts.require('ThimbleGangManagement');
const TGTToken = artifacts.require('TGTToken');
const ZERO_ADDRESS = '0x0000000000000000000000000000000000000000';

module.exports = async function (deployer) {
    await deployer.deploy(ThimbleGangManagement, TGTToken.address);
}