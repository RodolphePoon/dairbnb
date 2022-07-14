var Airbnb = artifacts.require("./Airbnb.sol");
var Chainmessage = artifacts.require("./Chainmessage.sol");

module.exports = function (deployer) {
  deployer.deploy(Airbnb);
  deployer.deploy(Chainmessage);
};
