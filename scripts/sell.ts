import { run, ethers, network } from "hardhat";
import Config from "./config.json";
import { Networks } from "./enums/Networks";

async function main() {
  await run("compile");
  try {
    var activeNetwork: Networks = Networks[network.name];
    const routerFactory = await ethers.getContractFactory("Router");
    const router = await routerFactory.attach(Config.networks[activeNetwork].addresses.router);
    const tokenFactory = await ethers.getContractFactory(Config.contract);
    const token = await tokenFactory.attach(Config.networks[activeNetwork].addresses.contract);

    const accounts = await ethers.getSigners();
    const admin = accounts[0].address;
    const marketing = accounts[1].address;
    const buyback = accounts[2];
    const sniping = accounts[3];

    await sell();

    async function sell() {
      const tokensHeldBN = await token.balanceOf(sniping.address);
      const tokensHeld = ethers.BigNumber.from(tokensHeldBN.toString()).div(10**9);
      const percentToSell = 10;
      const sellAmount = tokensHeldBN.mul(percentToSell).div(100);
      await token.connect(sniping).approve(router.address, tokensHeldBN);
      //   swapExactTokensForETHSupportingFeeOnTransferTokens(
      //     uint amountIn,
      //     uint amountOutMin,
      //     address[] calldata path,
      //     address to,
      //     uint deadline
      // )
      console.log(sellAmount.toString());
      const result = await router.connect(sniping).swapExactTokensForETHSupportingFeeOnTransferTokens(
          sellAmount,
          0,
          [token.address, Config.networks[activeNetwork].addresses.WBNB],
          sniping.address,
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