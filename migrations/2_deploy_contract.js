var Airbnb = artifacts.require("./Airbnb.sol");

module.exports = function (deployer) {
  deployer.deploy(Airbnb);
};
