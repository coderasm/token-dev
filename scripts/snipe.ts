import { run, ethers, network } from "hardhat";
import Config from "./config.json";
import { Networks } from "./enums/Networks";

async function main() {
  await run("compile");
  try {
    var activeNetwork: Networks = Networks[network.name];
    const routerFactory = await ethers.getContractFactory("Router");
    const router = await routerFactory.attach(Config.networks[activeNetwork].addresses.router);

    const accounts = await ethers.getSigners();
    const admin = accounts[0].address;
    const marketing = accounts[1].address;
    const buyback = accounts[2];
    const sniping = accounts[3];

    await snipe(".1");

    async function snipe(amount:string) {
      const amountIn = ethers.utils.parseEther(amount);
      //const snipingRouter = router.connect(sniping);
      console.log(sniping.address);
      const result = await router.connect(sniping).swapExactETHForTokensSupportingFeeOnTransferTokens(
          0,
          [Config.networks[activeNetwork].addresses.WBNB, Config.networks[activeNetwork].addresses.contract],
          sniping.address,
          Math.floor(Date.now() / 1000) + 60 * 10,
          {value: amountIn} //Buy-in amount
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