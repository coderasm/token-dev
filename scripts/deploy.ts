import { run, ethers, network } from "hardhat";
import Config from "./config.json";
import Deployments from "./deployments.json";
import * as fs from "fs";
import { Networks } from "./enums/Networks";

async function main() {
  await run("compile");
  var activeNetwork: Networks = Networks[network.name];
  //deploy claimer
  const Claimer = await ethers.getContractFactory(Config.claimer);
  const claimer = await Claimer.deploy();
  await claimer.deployed();

  //deploy contract
  const Contract = await ethers.getContractFactory(Config.contract);
  const contract = await Contract.deploy();
  await contract.deployed();

  //get wallet addresses
  const accounts = await ethers.getSigners();
  const buyback = accounts[2];

  //Set contract addresses
  await setContractAddresses();

  //Save all addresses to json files
  var pair = await contract.pancakeswapV2Pair();
  var now = new Date(Date.now());
  (<any[]>Deployments[activeNetwork]).push({
    time: `${now.getMonth() + 1}-${now.getDate()}-${now.getFullYear()}T${now.getHours()}:${now.getMinutes()}:${now.getSeconds()}`,
    contract: contract.address,
    claimer: claimer.address,
    pair: pair
  });
  Config.networks[activeNetwork].addresses.contract = contract.address;
  Config.networks[activeNetwork].addresses.claimer = claimer.address;
  Config.networks[activeNetwork].addresses.pair = pair;
  fs.writeFileSync("./scripts/deployments.json", JSON.stringify(Deployments, null, 4));
  fs.writeFileSync("./scripts/config.json", JSON.stringify(Config, null, 4));

  async function setContractAddresses() {
    //await contract.migrateRouter(Config.networks[activeNetwork].addresses.router);
    await contract.setClaimerAddress(claimer.address);
    await contract.setBuybackAddress(buyback.address);
    //await claimer.migrateRouter(Config.networks[activeNetwork].addresses.router);
    await claimer.setTokenAddress(contract.address);
    await claimer.setPayoutTokenAddress(Config.networks[activeNetwork].addresses.BUSD);
    console.log(`Contract addresses set`);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });