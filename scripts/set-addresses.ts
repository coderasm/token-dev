import { run, ethers, network } from "hardhat";
import Config from "./config.json";
import Deployments from "./deployments.json";
import { Networks } from "./enums/Networks";
import * as fs from "fs";

async function main() {
  await run("compile");
  try {
    var activeNetwork: Networks = Networks[network.name];
    const tokenFactory = await ethers.getContractFactory(Config.contract);
    const token = await tokenFactory.attach(Config.networks[activeNetwork].addresses.contract);
    const claimerFactory = await ethers.getContractFactory(Config.claimer);
    const claimer = await claimerFactory.attach(Config.networks[activeNetwork].addresses.claimer);
    const accounts = await ethers.getSigners();
    const buyback = accounts[2];
    await token.migrateRouter(Config.networks[activeNetwork].addresses.router);
    await token.setClaimerAddress(claimer.address);
    await token.setBuybackAddress(buyback.address);
    await claimer.migrateRouter(Config.networks[activeNetwork].addresses.router);
    await claimer.setTokenAddress(token.address);
    await claimer.setPayoutTokenAddress(Config.networks[activeNetwork].addresses.BUSD);
    var pair = await token.pancakeswapV2Pair();
    (<any>Deployments[activeNetwork][Deployments[activeNetwork].length - 1]).pair = pair;
    Config.networks[activeNetwork].addresses.pair = pair;
    fs.writeFileSync("./deployments.json", JSON.stringify(Deployments, null, 4));
    fs.writeFileSync("./config.json", JSON.stringify(Config, null, 4));
    console.log(`Contract addresses set`);
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