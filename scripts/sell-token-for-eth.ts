import { run, ethers, network } from "hardhat";
import Config from "./config.json";
import { Networks } from "./enums/Networks";

async function main() {
  await run("compile");
  try {
    var activeNetwork: Networks = Networks[network.name];
    const routerFactory = await ethers.getContractFactory("Router");
    const router = await routerFactory.attach(Config.networks[activeNetwork].addresses.router);
    const tokenFactory = await ethers.getContractFactory(Config.bep20);
    const token = await tokenFactory.attach(Config.networks[activeNetwork].addresses.WBTC);

    const accounts = await ethers.getSigners();
    const admin = accounts[0];

    await sell();

    async function sell() {
      const tokensHeldBN = await token.balanceOf(admin.address);
      console.log(tokensHeldBN.toString());
      const decimals = await token.decimals();
      const divisor = ethers.BigNumber.from(10).pow(decimals);
      const tokensHeld = ethers.BigNumber.from(tokensHeldBN.toString()).div(divisor);
      console.log(tokensHeld.toString());
      const percentToSell = 90;
      const sellAmount = tokensHeldBN.mul(percentToSell).div(100);
      await token.connect(admin).approve(router.address, tokensHeldBN);
      console.log(sellAmount.toString());
      const result = await router.connect(admin).swapExactTokensForETHSupportingFeeOnTransferTokens(
          sellAmount,
          0,
          [Config.networks[activeNetwork].addresses.WBTC, Config.networks[activeNetwork].addresses.WBNB],
          admin.address,
          Math.floor(Date.now() / 1000) + 60 * 10
      );
      //console.log(result);
    }
  }
  catch(e) {
    console.log(e);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });