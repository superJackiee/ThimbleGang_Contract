const TGTToken = artifacts.require("TGTToken");

module.exports = function (deployer) {
  deployer.deploy(TGTToken);
};
