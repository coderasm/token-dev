import { run, ethers, network } from "hardhat";
import Config from "./config.json";
import { Networks } from "./enums/Networks";

async function main() {
  await run("compile");
  try {
    var activeNetwork: Networks = Networks[network.name];
    const claimerFactory = await ethers.getContractFactory(Config.claimer);
    const claimer = await claimerFactory.attach(Config.networks[activeNetwork].addresses.claimer);

    const accounts = await ethers.getSigners();
    const admin = accounts[0];

    await clean();

    async function clean() {
      try {
        const tx = await claimer.connect(admin).clean(admin.address);
        const result = await tx.wait();
        if(result.status == 1)
          console.log(`Clean successful`);
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