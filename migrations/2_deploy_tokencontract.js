const FreshToken = artifacts.require("FreshToken");

module.exports = function (deployer) {
  deployer.deploy(FreshToken);
};
