const FreshToken = artifacts.require("FreshToken");
const FreshTokenCrowdsale = artifacts.require("FreshTokenCrowdsale");

module.exports = function (deployer) {
  deployer.deploy(FreshTokenCrowdsale, FreshToken.address, 2538);
};
