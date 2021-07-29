import { run, ethers, network } from "hardhat";
import Config from "./config.json";
import { Networks } from "./enums/Networks";

async function main() {
  await run("compile");
  try {
    var activeNetwork: Networks = Networks[network.name];
    const tokenFactory = await ethers.getContractFactory(Config.contract);
    const token = await tokenFactory.attach(Config.networks[activeNetwork].addresses.contract);

    const accounts = await ethers.getSigners();
    const sniping = accounts[3];

    await claim();

    async function claim() {
      try {
        const tx = await token.connect(sniping).claimBNB(sniping.address);
        const result = await tx.wait();
        if(result.status == 1)
          console.log(`Claim successful`);
      } catch (error) {
        console.log(error);
      }
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