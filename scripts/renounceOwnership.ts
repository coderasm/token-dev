import { run, ethers, network } from "hardhat";
import Config from "./config.json";
import { Networks } from "./enums/Networks";

async function main() {
  await run("compile");
  try {
    var activeNetwork: Networks = Networks[network.name];
    const tokenFactory = await ethers.getContractFactory(Config.contract);
    const token = await tokenFactory.attach(Config.networks[activeNetwork].addresses.contract);
    var tx = await token.renounceOwnership();
    var result = tx.wait();
    if(result.status == 1)
      console.log(`Ownership renounced`);
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